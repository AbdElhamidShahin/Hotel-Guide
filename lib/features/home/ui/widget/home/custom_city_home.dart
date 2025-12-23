import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/network/city_model.dart';
import '../../../../../core/network/hotel_model.dart';
import '../../../logic/cubit/home_cubit.dart';
import '../../../logic/cubit/home_state.dart';

class CustomCityHome extends StatelessWidget {
  const CustomCityHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HomeError) {
          return Center(child: Text("حدث خطأ: ${state.message}"));
        }

        if (state is HomeLoaded) {
          if (state.cities.isEmpty) {
            return const Center(child: Text("لا توجد مدن حالياً"));
          }

          return Column(
            children: [
              // لستة المدن (Grid)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                itemCount: state.cities.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) {
                  final city = state.cities[index];
                  // بنعرف لو المدينة دي هي اللي تم اختيارها عشان نغير شكلها (اختياري)
                  bool isSelected = state.selectedCityId == city.id;

                  return CustomCityHomeItem(
                    city: city,
                    isSelected: isSelected, // ضفنا خاصية التحديد
                    onTap: () {
                      // لما يضغط، الـ Cubit بيغير لستة الفنادق المعروضة فوراً
                      context.read<HomeCubit>().updateSelectedCity(city.id);
                    },
                  );
                },
              ),

              const Divider(height: 30),

              // هنا تقدر تعرض لستة الفنادق بناءً على المدينة المختارة
              // state.selectedHotels هي اللستة اللي جاية من الكيوبيت حالياً
              _buildHotelsList(state.selectedHotels),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  // ودجت بسيطة لعرض الفنادق تحت المدن
  Widget _buildHotelsList(List<HotelModel> hotels) {
    if (hotels.isEmpty) return const Text("لا توجد فنادق في هذه المدينة");
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: hotels.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(hotels[index].name),
        subtitle: Text("${hotels[index].price} EGP"),
        leading: Image.network(
          hotels[index].imageUrl,
          width: 50,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class CustomCityHomeItem extends StatelessWidget {
  const CustomCityHomeItem({
    super.key,
    required this.city,
    this.onTap,
    this.isSelected = false,
  });

  final CityModel city;
  final VoidCallback? onTap;
  final bool isSelected; // تم الإضافة

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        // استخدمنا AnimatedContainer عشان شكل الاختيار يبقى شيك
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? Border.all(color: Colors.blue, width: 3) // برواز أزرق لو مختارة
              : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(isSelected ? 17 : 20),
          child: Stack(
            children: [
              // Image
              Positioned.fill(
                child: Image.network(
                  city.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Center(child: Icon(Icons.error)),
                ),
              ),

              // Dark Overlay
              Container(color: Colors.black.withOpacity(0.3)),

              // City Name
              Center(
                child: Text(
                  city.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
