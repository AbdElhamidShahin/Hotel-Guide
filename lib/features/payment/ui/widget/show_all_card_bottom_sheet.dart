// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import '../../../../core/network/model/booking_model.dart';
// import '../../../../core/router/routers.dart';
// import '../../../../core/theme/app_theme.dart';
// import '../../../../core/theme/colors.dart';
// import '../../data/model/payment_intent_input_model.dart';
// import '../../logic/booking_cubit.dart';
// import '../../logic/booking_state.dart';
//
// // ── المدل البسيط للبطاقة المحفوظة محلياً ─────────────────────────────────────
// // (لو عندك SavedCardEntity من Supabase استخدمه بدلاً من ده)
// class _LocalCard {
//   final String id; // pm_xxxxx من Stripe
//   final String last4;
//   final String brand; // 'visa' أو 'mastercard'
//   final String expiry; // 'MM/YY'
//   bool isDefault;
//
//   _LocalCard({
//     required this.id,
//     required this.last4,
//     required this.brand,
//     required this.expiry,
//     this.isDefault = false,
//   });
// }
//
// void showAllCardBottomSheet(
//   BuildContext parentContext, {
//   required double totalPrice,
//   required BookingModel currentBooking,
// }) {
//   showModalBottomSheet(
//     context: parentContext,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     builder: (context) => BlocProvider.value(
//       value: parentContext.read<BookingCubit>(),
//       child: _CardBottomSheet(
//         parentContext: parentContext,
//         totalPrice: totalPrice,
//         currentBooking: currentBooking,
//       ),
//     ),
//   );
// }
//
// class _CardBottomSheet extends StatefulWidget {
//   const _CardBottomSheet({
//     required this.parentContext,
//     required this.totalPrice,
//     required this.currentBooking,
//   });
//
//   final BuildContext parentContext;
//   final double totalPrice;
//   final BookingModel currentBooking;
//
//   @override
//   State<_CardBottomSheet> createState() => _CardBottomSheetState();
// }
//
// class _CardBottomSheetState extends State<_CardBottomSheet> {
//   // ── البطاقات المحفوظة (بتيجي من Supabase في التطبيق الحقيقي) ─────────────
//   final List<_LocalCard> _cards = [];
//   _LocalCard? _selectedCard;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadSavedCards();
//   }
//
//   // ── تحميل البطاقات من Supabase ────────────────────────────────────────────
//   Future<void> _loadSavedCards() async {
//     try {
//       final user = Supabase.instance.client.auth.currentUser;
//       if (user == null) return;
//
//       final data = await Supabase.instance.client
//           .from('saved_cards')
//           .select()
//           .eq('user_id', user.id)
//           .order('is_default', ascending: false);
//
//       setState(() {
//         _cards.clear();
//         for (final row in data) {
//           _cards.add(
//             _LocalCard(
//               id: row['payment_method_id'],
//               last4: row['last4'],
//               brand: row['brand'],
//               expiry: row['expiry'],
//               isDefault: row['is_default'] ?? false,
//             ),
//           );
//         }
//         // اختر الافتراضية مسبقاً لو موجودة
//         if (_cards.isNotEmpty) {
//           _selectedCard = _cards.firstWhere(
//             (c) => c.isDefault,
//             orElse: () => _cards.first,
//           );
//         }
//       });
//     } catch (_) {}
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<BookingCubit, BookingStates>(
//       listener: (context, state) {
//         if (state is CardSaved) {
//           // بعد الحفظ — أعد تحميل البطاقات
//           _loadSavedCards();
//         } else if (state is BookingSuccess) {
//           Navigator.of(context).pop();
//           widget.parentContext.push(
//             routes.bookingResult,
//             extra: {'isSuccess': true, 'paymentMethod': 'البطاقة البنكية'},
//           );
//         } else if (state is BookingError) {
//           Navigator.of(context).pop();
//           widget.parentContext.push(
//             routes.bookingResult,
//             extra: {'isSuccess': false, 'errorMessage': state.message},
//           );
//         }
//       },
//       child: Container(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
//         ),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // ── Drag Handle ──────────────────────────────────────────────
//             Container(
//               width: 40.w,
//               height: 4.h,
//               margin: EdgeInsets.only(top: 12.h, bottom: 4.h),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade300,
//                 borderRadius: BorderRadius.circular(2.r),
//               ),
//             ),
//
//             // ── Header ───────────────────────────────────────────────────
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   IconButton(
//                     onPressed: () => Navigator.pop(context),
//                     icon: const Icon(Icons.close),
//                   ),
//                   Text(
//                     'اختر بطاقة للدفع',
//                     style: textStyle20RegularPrimary.copyWith(
//                       color: AppColors.black6,
//                     ),
//                   ),
//                   SizedBox(width: 48.w), // balance
//                 ],
//               ),
//             ),
//
//             Divider(color: Colors.grey.shade100, height: 1),
//             SizedBox(height: 12.h),
//
//             // ── Cards List ────────────────────────────────────────────────
//             if (_cards.isEmpty)
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: 20.h),
//                 child: Column(
//                   children: [
//                     Icon(
//                       Icons.credit_card_off_outlined,
//                       size: 48.r,
//                       color: Colors.grey.shade300,
//                     ),
//                     SizedBox(height: 12.h),
//                     Text(
//                       'لا توجد بطاقات محفوظة',
//                       style: TextStyle(
//                         fontFamily: 'Cairo',
//                         color: Colors.grey,
//                         fontSize: 14.sp,
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             else
//               ..._cards.map(
//                 (card) => _CardTile(
//                   card: card,
//                   isSelected: _selectedCard?.id == card.id,
//                   onTap: () => setState(() => _selectedCard = card),
//                 ),
//               ),
//
//             SizedBox(height: 8.h),
//
//             // ── Add New Card ──────────────────────────────────────────────
//             BlocBuilder<BookingCubit, BookingStates>(
//               buildWhen: (_, s) => s is CardSavingLoading || s is CardSaved,
//               builder: (context, state) {
//                 final isSaving = state is CardSavingLoading;
//                 return Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20.w),
//                   child: GestureDetector(
//                     onTap: isSaving ? null : () => _addNewCard(context),
//                     child: Container(
//                       padding: EdgeInsets.all(14.w),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16.r),
//                         border: Border.all(
//                           color: AppColors.primary.withOpacity(0.3),
//                         ),
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 44.r,
//                             height: 44.r,
//                             decoration: BoxDecoration(
//                               color: isSaving ? Colors.grey : AppColors.primary,
//                               borderRadius: BorderRadius.circular(12.r),
//                             ),
//                             child: isSaving
//                                 ? Padding(
//                                     padding: EdgeInsets.all(10.r),
//                                     child: const CircularProgressIndicator(
//                                       color: Colors.white,
//                                       strokeWidth: 2,
//                                     ),
//                                   )
//                                 : Icon(
//                                     Icons.add,
//                                     color: Colors.white,
//                                     size: 22.r,
//                                   ),
//                           ),
//                           SizedBox(width: 16.w),
//                           Text(
//                             isSaving
//                                 ? 'جاري حفظ البطاقة...'
//                                 : 'إضافة بطاقة جديدة',
//                             style: textStyle16BoldWhite.copyWith(
//                               color: isSaving ? Colors.grey : AppColors.primary,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//
//             SizedBox(height: 20.h),
//             Divider(color: Colors.grey.shade100),
//             SizedBox(height: 16.h),
//
//             // ── Confirm Button ────────────────────────────────────────────
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.w),
//               child: BlocBuilder<BookingCubit, BookingStates>(
//                 buildWhen: (_, s) =>
//                     s is BookingLoading ||
//                     s is BookingError ||
//                     s is BookingSuccess,
//                 builder: (context, state) {
//                   final isLoading = state is BookingLoading;
//                   final canPay = _selectedCard != null && !isLoading;
//
//                   return GestureDetector(
//                     onTap: canPay ? () => _confirmPayment(context) : null,
//                     child: AnimatedContainer(
//                       duration: const Duration(milliseconds: 200),
//                       width: double.infinity,
//                       height: 56.h,
//                       decoration: BoxDecoration(
//                         color: canPay
//                             ? AppColors.primary
//                             : Colors.grey.shade300,
//                         borderRadius: BorderRadius.circular(14.r),
//                       ),
//                       child: Center(
//                         child: isLoading
//                             ? const CircularProgressIndicator(
//                                 color: Colors.white,
//                               )
//                             : Text(
//                                 _selectedCard == null
//                                     ? 'اختر بطاقة أولاً'
//                                     : 'تأكيد الدفع',
//                                 style: textStyle20BoldShadowPurple.copyWith(
//                                   color: Colors.white,
//                                 ),
//                               ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//
//   Future<void> _confirmPayment(BuildContext context) async {
//     if (_selectedCard == null) return;
//
//     final user = Supabase.instance.client.auth.currentUser;
//     if (user == null) return;
//
//   }
// }
//
// // ─── Card Tile ────────────────────────────────────────────────────────────────
//
// class _CardTile extends StatelessWidget {
//   const _CardTile({
//     required this.card,
//     required this.isSelected,
//     required this.onTap,
//   });
//
//   final _LocalCard card;
//   final bool isSelected;
//   final VoidCallback onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
//         padding: EdgeInsets.all(14.w),
//         decoration: BoxDecoration(
//           color: isSelected
//               ? AppColors.primary.withOpacity(0.05)
//               : Colors.white,
//           borderRadius: BorderRadius.circular(14.r),
//           border: Border.all(
//             color: isSelected ? AppColors.primary : Colors.grey.shade200,
//             width: isSelected ? 1.5 : 1,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.04),
//               blurRadius: 6,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Row(
//           textDirection: TextDirection.rtl,
//           children: [
//             // Brand Icon
//             SvgPicture.asset(
//               card.brand == 'visa'
//                   ? 'assets/icons/Visa.svg'
//                   : 'assets/icons/MasterCard.svg',
//               width: 44.w,
//             ),
//             SizedBox(width: 14.w),
//
//             // Card Info
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     card.brand == 'visa' ? 'Visa' : 'Master Card',
//                     style: textStyle16BoldWhite.copyWith(
//                       color: AppColors.black6,
//                     ),
//                   ),
//                   SizedBox(height: 2.h),
//                   Text(
//                     '**** **** **** ${card.last4}    •    ${card.expiry}',
//                     style: TextStyle(
//                       fontFamily: 'Cairo',
//                       fontSize: 12.sp,
//                       color: Colors.grey,
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // Radio Indicator
//             AnimatedContainer(
//               duration: const Duration(milliseconds: 200),
//               width: 22.r,
//               height: 22.r,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: isSelected ? AppColors.primary : Colors.grey.shade400,
//                   width: 2,
//                 ),
//                 color: isSelected ? AppColors.primary : Colors.transparent,
//               ),
//               child: isSelected
//                   ? Icon(Icons.check, size: 13.r, color: Colors.white)
//                   : null,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
