import 'package:flutter/material.dart';
import 'package:hotel_guide/features/home/ui/widget/custom_appBar_home.dart';
import 'package:hotel_guide/features/home/ui/widget/custom_welcome_header.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
              children: [
              
              
                CustomAppbarHome(),SizedBox(height: 16,),
                CustomWelcomeHeader(),
              ]
          ),
        )
    );
  }
}
