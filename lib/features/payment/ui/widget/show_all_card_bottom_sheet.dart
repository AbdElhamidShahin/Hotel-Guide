import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/helpers/contact/custom_show_snackbar.dart';
import '../../../../core/network/model/booking_model.dart';
import '../../../../core/network/model/notification_model.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/colors.dart';
import '../../../notification/logic/notificatin_logic.dart';
import '../../logic/booking_cubit.dart';
import '../../logic/booking_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void showCardBottomSheet(
  BuildContext parentContext,
  BookingEntity bookingData,
) {
  final bookingCubit = parentContext.read<BookingCubit>();

  showModalBottomSheet(
    context: parentContext,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      String selectedCard = 'master';

      return BlocListener<BookingCubit, BookingState>(
        bloc: bookingCubit,
        listener: (context, state) async {
          // ✅ Step 1: السيرفر رجع clientSecret — افتح PaymentSheet
          if (state is StripeReady) {
            await _openStripePaymentSheet(
              context: parentContext,
              clientSecret: state.clientSecret,
              bookingCubit: bookingCubit,
            );
          }
          // ✅ Step 2: الحجز اتسجل في الـ DB بنجاح
          else if (state is BookingSuccess) {
            Navigator.of(context).pop();
            _addNotification(bookingData, success: true);
            showCustomSnackbar(
              parentContext,
              ContentType.success,
              'تم الحجز بنجاح ✅',
              'تمت عملية الدفع بالبطاقة بنجاح',
            );
          }
          // ✅ Step 3: حصل خطأ
          else if (state is BookingError) {
            Navigator.of(context).pop();
            _addNotification(
              bookingData,
              success: false,
              message: state.message,
            );
            showCustomSnackbar(
              parentContext,
              ContentType.failure,
              'فشل الحجز ❌',
              state.message,
            );
          }
        },
        child: StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.r),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close),
                        ),
                        Text(
                          'البطاقة البنكية',
                          style: textStyle20RegularPrimary.copyWith(
                            color: AppColors.black6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                  _CardItem(
                    image: 'assets/icons/MasterCard.svg',
                    title: 'Master Card',
                    selected: selectedCard == 'master',
                    onTap: () => setState(() => selectedCard = 'master'),
                  ),
                  SizedBox(height: 12.h),
                  _CardItem(
                    image: 'assets/icons/Visa.svg',
                    title: 'Visa',
                    selected: selectedCard == 'visa',
                    onTap: () => setState(() => selectedCard = 'visa'),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(bottom: 30.h),
                    child: BlocBuilder<BookingCubit, BookingState>(
                      bloc: bookingCubit,
                      builder: (context, state) {
                        final isLoading =
                            state is StripeLoading || state is BookingLoading;
                        return GestureDetector(
                          onTap: isLoading
                              ? null
                              : () => bookingCubit.initiateStripePayment(
                                  bookingData,
                                ),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 60.h,
                            decoration: BoxDecoration(
                              color: isLoading
                                  ? AppColors.primary.withOpacity(0.6)
                                  : AppColors.primary,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Center(
                              child: isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      'تأكيد الدفع ${bookingData.totalAmount.toInt()} EGP',
                                      style: textStyle20BoldShadowPurple
                                          .copyWith(color: Colors.white),
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

// ── Stripe PaymentSheet ──────────────────────────

Future<void> _openStripePaymentSheet({
  required BuildContext context,
  required String clientSecret,
  required BookingCubit bookingCubit,
}) async {
  try {
    // ✅ Step 1: جهز الـ PaymentSheet
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'Hotel Guide',
        style: ThemeMode.light,
      ),
    );

    // ✅ Step 2: افتح الـ PaymentSheet للمستخدم
    await Stripe.instance.presentPaymentSheet();

    // ✅ Step 3: المستخدم دفع — سجل الحجز في الـ DB
    await bookingCubit.confirmStripeBooking();
  } on StripeException catch (e) {
    if (e.error.code == FailureCode.Canceled) {
      // المستخدم ضغط Back — مش error حقيقي
      return;
    }
    bookingCubit.emit(
      BookingError('فشل الدفع: ${e.error.localizedMessage ?? e.error.message}'),
    );
  } catch (e) {
    bookingCubit.emit(BookingError('حدث خطأ غير متوقع أثناء الدفع'));
  }
}

// ── Notification Helper ──────────────────────────

void _addNotification(
  BookingEntity booking, {
  required bool success,
  String? message,
}) {
  final user = Supabase.instance.client.auth.currentUser;
  if (user == null) return;

  final notif = NotificationModel(
    title: success ? 'عملية حجز ناجحة ✅' : 'فشل عملية الدفع ❌',
    body: success
        ? 'تم تأكيد حجزك في ${booking.hotelName} بالبطاقة بنجاح.'
        : 'عفواً، لم يتم الحجز: $message',
    time: DateTime.now(),
    type: success ? NotificationType.success : NotificationType.failure,
  );

  getIt<NotificationCubit>().addNotification(notif);

  Supabase.instance.client
      .from('notifications')
      .insert(notif.toJson(user.id))
      .catchError((e) => debugPrint('Notification save error: $e'));
}

// ── Card Item Widget ─────────────────────────────

class _CardItem extends StatelessWidget {
  const _CardItem({
    required this.image,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final String image;
  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected ? AppColors.Purple : Colors.transparent,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(14.w),
            child: Row(
              children: [
                SvgPicture.asset(image),
                SizedBox(width: 20.w),
                Text(
                  title,
                  style: textStyle16BoldWhite.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey),
                    color: selected ? AppColors.primary : Colors.transparent,
                  ),
                  child: Icon(Icons.done, color: AppColors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
