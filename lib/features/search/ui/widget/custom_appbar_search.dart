import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/routers.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/colors.dart';

class CustomAppbarSearch extends StatelessWidget {
  const CustomAppbarSearch({super.key, required this.onChanged});
  final ValueChanged<String> onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                onChanged: onChanged,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  hintText: "...البحث عن الفنادق",
                  hintStyle: textStyle17MediumBlack.copyWith(
                    color: Color(0xFFB7B7B7),
                  ),

                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: SvgPicture.asset(
                      "assets/icons/Filter_alt.svg",
                      width: 30,
                      height: 30,
                      color: AppColors.black4,
                    ),
                  ),

                  suffixIcon: Icon(
                    Icons.search_sharp,
                    color: AppColors.black4,
                    weight: 0.2,
                    size: 28,
                  ),

                  filled: true,
                  fillColor: Colors.transparent,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 20,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: 12),
          IconButton(
            onPressed: () {
              context.go(routes.homeScreen);
            },
            icon: Icon(Icons.arrow_forward, color: AppColors.black6, size: 24),
          ),
        ],
      ),
    );
  }
}
