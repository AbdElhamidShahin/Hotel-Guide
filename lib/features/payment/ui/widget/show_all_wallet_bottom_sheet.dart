import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/helpers/contact/custom_show_snackbar.dart';
import '../../../../core/network/model/notification_model.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/colors.dart';
import '../../../notification/logic/notificatin_logic.dart';
import '../../data/entities/booking_entity.dart';
import '../../logic/booking_cubit.dart';
import '../../logic/booking_state.dart';
import 'custom_wallet_item.dart';

/// ✅ UI updated to use [BookingEntity] (domain type) instead of [BookingModel].
/// The presentation layer now speaks the Domain language.
void showWalletBottomSheet(
    BuildContext parentContext,
    BookingEntity bookingData,
    ) {
  final bookingCubit = parentContext.read<BookingCubit>();

  showModalBottomSheet(
    context: parentContext,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return BlocListener<BookingCubit, BookingState>(
        bloc: bookingCubit,
        listener: (context, state) async {
          if (state is BookingLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) =>
              const Center(child: CircularProgressIndicator()),
            );
          } else if (state is BookingSuccess) {
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.of(context).pop();
            _saveNotification(
              parentContext,
              bookingData.hotelName,
              success: true,
            );
            showCustomSnackbar(
              parentContext,
              ContentType.success,
              'تم الحجز بنجاح ✅',
              'تمت العملية بنجاح',
            );
          } else if (state is BookingError) {
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.of(context).pop();
            _saveNotification(
              parentContext,
              bookingData.hotelName,
              success: false,
              errorMessage: state.message,
            );
            showCustomSnackbar(
              parentContext,
              ContentType.failure,
              'عفواً، فشل الحجز',
              state.message,
            );
          }
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
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
                      'المحفظة الإلكترونية',
                      style: textStyle20RegularPrimary.copyWith(
                        color: AppColors.black6,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              BlocBuilder<BookingCubit, BookingState>(
                bloc: bookingCubit,
                builder: (context, state) {
                  return Column(
                    children: [
                      CustomWalletItem(
                        image: 'assets/images/Orange.png',
                        title: 'أورنج كاش',
                        cashBack: 'كاش باك 5%',
                        selected: bookingCubit.selectedWallet == 'orange',
                        onTap: () => bookingCubit.changeWallet('orange'),
                      ),
                      SizedBox(height: 12.h),
                      CustomWalletItem(
                        image: 'assets/images/logo/logo-light.png',
                        title: 'محفظة AQUA',
                        cashBack: 'كاش باك 10%',
                        selected: bookingCubit.selectedWallet == 'AQUA',
                        onTap: () => bookingCubit.changeWallet('AQUA'),
                      ),
                    ],
                  );
                },
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 30.h),
                child: GestureDetector(
                  onTap: () async {
                    if (bookingCubit.selectedWallet != 'AQUA') {
                      showCustomSnackbar(
                        context,
                        ContentType.warning,
                        'تنبيه',
                        'يرجى اختيار محفظة AQUA',
                      );
                      return;
                    }

                    final user = Supabase.instance.client.auth.currentUser;
                    if (user == null) return;

                    final finalBooking = bookingData.copyWith(
                      userId: user.id,
                      paymentMethod: bookingCubit.selectedWallet,
                    );

                    await bookingCubit.confirmBooking(finalBooking);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 55.h,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Text(
                        'تأكيد دفع ${bookingData.totalAmount.toInt()} EGP',
                        style: textStyle20BoldShadowPurple.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

// ── Private helpers ──────────────────────────────────────────────────────────

Future<void> _saveNotification(
    BuildContext context,
    String hotelName, {
      required bool success,
      String? errorMessage,
    }) async {
  final user = Supabase.instance.client.auth.currentUser;
  if (user == null) return;

  final notif = NotificationModel(
    title: success ? 'عملية حجز ناجحة ✅' : 'فشل عملية الدفع ❌',
    body: success
        ? 'تم تأكيد حجزك في $hotelName بنجاح.'
        : 'عفواً، لم يتم الحجز: $errorMessage',
    time: DateTime.now(),
    type: success ? NotificationType.success : NotificationType.failure,
  );

  getIt<NotificationCubit>().addNotification(notif);

  try {
    await Supabase.instance.client
        .from('notifications')
        .insert(notif.toJson(user.id));
  } catch (e) {
    debugPrint('Error saving notification: $e');
  }
}
