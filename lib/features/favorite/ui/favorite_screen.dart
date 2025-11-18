import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart'; // لإمكانية العودة بالـ goRouter

import '../../../core/theme/colors.dart'; // نفترض وجود AppColors
import '../logic/cubit/favorite_cubit.dart';
import '../logic/cubit/favorite_state.dart';
import 'widget/custom_item_favorite.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  // ويدجت لعرض حالة عدم وجود عناصر في المفضلة بشكل جذاب
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 100,
              color: Colors.red.shade200,
            ),
            const SizedBox(height: 20),
            Text(
              'قائمة المفضلة فارغة!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.black, // يفترض وجود هذا اللون
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'ابدأ بإضافة الفنادق التي تعجبك إلى مفضلتك لتظهر هنا.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // العودة إلى الشاشة الرئيسية أو شاشة البحث
                context.pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade400,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'اكتشف الفنادق',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'المفضلة',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        // الأيقونة اليمنى (سهم لليمين كما في الصورة)
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.black),
            onPressed: () {
              // يمكن إضافة وظيفة هنا إذا لزم الأمر، وإلا يُترك فارغاً
            },
          ),
        ],
      ),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FavoriteError) {
            return Center(child: Text(state.message));
          }

          final favoriteItems = state is FavoriteUpdated ? state.favorites : [];

          // عرض حالة عدم وجود عناصر
          if (favoriteItems.isEmpty) {
            return _buildEmptyState(context);
          }

          // عرض قائمة العناصر
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            itemCount: favoriteItems.length,
            itemBuilder: (context, index) {
              final item = favoriteItems[index];
              return Customfavoriteitem(hotelModel: item);
            },
          );
        },
      ),
    );
  }
}