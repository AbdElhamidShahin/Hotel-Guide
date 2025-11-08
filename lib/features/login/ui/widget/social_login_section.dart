import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_guide/core/theme/colors.dart';

class SocialLoginSection extends StatelessWidget {
  const SocialLoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconSocial("assets/icons/faceBook.svg"),

        SizedBox(width: 16),
        IconSocial("assets/icons/x.svg"),
        SizedBox(width: 16),
        IconSocial("assets/icons/google.svg"),
      ],
    );
  }
}

Widget IconSocial(String image) {
  return Container(
    width: 75,
    height: 58,
    decoration: BoxDecoration(
      color: Colors.transparent,
      border: Border.all(
        color: AppColors.grayLight.withOpacity(0.17),
        width: 2,
      ),
      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20),topRight: Radius.circular(20)),
    ),
    child: Center(child: SvgPicture.asset(image)),
  );
}
