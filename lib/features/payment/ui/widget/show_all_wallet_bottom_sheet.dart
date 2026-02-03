import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/helpers/contact/custom_show_snackbar.dart';
import '../../../../core/network/model/booking.dart';
import '../../../../core/router/routers.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/colors.dart';
import '../../logic/booking_cubit.dart';
import '../../logic/booking_state.dart';
import 'custom_wallet_item.dart';

class WalletBottomSheet extends StatelessWidget {
  final BookingModel bookingData;

  const WalletBottomSheet({super.key, required this.bookingData});

  @override
  Widget build(BuildContext context) {
    final bookingCubit = context.read<BookingCubit>();

    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          _buildHeader(context),
          SizedBox(height: 20.h),

          BlocBuilder<BookingCubit, BookingStates>(
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
                    selected: bookingCubit.selectedWallet == "AQUA",
                    onTap: () => bookingCubit.changeWallet('AQUA'),
                  ),
                ],
              );
            },
          ),

          const Spacer(),

          BlocListener<BookingCubit, BookingStates>(
            listener: (context, state) {
              if (state is BookingSuccess) {
                showCustomSnackbar(
                  context,
                  ContentType.success,
                  'تم الحجز!',
                  'تم تأكيد حجزك في ${bookingData.hotelName}',
                );
                Navigator.pop(context);
                context.go(routes.homeScreen);
              } else if (state is BookingError) {
                showCustomSnackbar(
                  context,
                  ContentType.failure,
                  'خطأ',
                  state.message,
                );
              }
            },
            child: _buildConfirmButton(context, bookingCubit),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
          Text(
            "المحفظة الإلكترونية",
            style: textStyle20RegularPrimary.copyWith(color: AppColors.black6),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context, BookingCubit bookingCubit) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.h),
      child: GestureDetector(
        onTap: () {
          final cubit = context.read<BookingCubit>();
          if (cubit.selectedWallet != 'AQUA') {
            showCustomSnackbar(
              context,
              ContentType.warning,
              'تنبيه',
              'عفواً، الدفع عن طريق أورنج كاش غير متاح حالياً. يرجى استخدام محفظة AQUA.',
            );
            return;
          }
          final user = Supabase.instance.client.auth.currentUser;///بنتحقق ان المستخدم سجل دخول ولا لا
          if (user == null) return;

          final finalBooking = bookingData.copyWith(
            userId: user.id,
            paymentMethod: bookingCubit.selectedWallet,
          );
          bookingCubit.confirmBooking(finalBooking);
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: 55.h,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Center(
            child: BlocBuilder<BookingCubit, BookingStates>(
              builder: (context, state) {
                if (state is BookingLoading)
                  return const CircularProgressIndicator(color: Colors.white);
                return Text(
                  "تأكيد دفع ${bookingData.totalPrice.toInt()} EGP",
                  style: textStyle20BoldShadowPurple.copyWith(
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
