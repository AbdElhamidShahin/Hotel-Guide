import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/helpers/widget/custom_item.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../favorite/logic/cubit/favorite_cubit.dart';
import '../../../logic/cubit/home_cubit.dart';
import '../../../logic/cubit/home_state.dart';

void showHotelsBottomSheet(BuildContext context,String text) {
  final homeCubit = context.read<HomeCubit>();
  final favoriteCubit = getIt<FavoriteCubit>(); // ✅ من getIt

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (context) => MultiBlocProvider(
      // ✅ ضيف الاتنين
      providers: [
        BlocProvider.value(value: homeCubit),
        BlocProvider.value(value: favoriteCubit),
      ],
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.9,
        builder: (_, scrollController) => Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 12.h),
              height: 5.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            Text(
              text,
              style: font17RegularPrimary.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
              ),
            ),
            const Divider(),
            Expanded(
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoaded) {
                    return ListView.builder(
                      controller: scrollController,
                      itemCount: state.hotels.length,
                      itemBuilder: (context, index) {
                        return CustomItem(
                          hotelModel: state.hotels[index], // ✅
                          isContinar: false,
                        );
                      },
                    );
                  } else if (state is HomeLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return const Center(child: Text('لا توجد فنادق'));
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
