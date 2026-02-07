import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/router/routers.dart';
import 'package:hotel_guide/features/on_boarding/ui/widget/build_dot.dart';
import 'package:hotel_guide/features/on_boarding/ui/widget/custom_elevated_button.dart';
import '../../../core/theme/app_theme.dart';
import '../data/onpording_item.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    _controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            bottom: 200.h,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Stack(
                  children: contents.asMap().entries.map((entry) {
                    int index = entry.key;
                    double pageOffset = 0;
                    if (_controller.hasClients) {
                      pageOffset = _controller.page! - index;
                    }

                    return Opacity(
                      opacity: (1 - pageOffset.abs()).clamp(0.0, 1.0),
                      child: Transform.translate(
                        offset: Offset(-pageOffset * 100, 0),
                        child: Image.asset(
                          entry.value.image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),

          Positioned.fill(
            bottom: 200.h,
            child: Container(color: Colors.black.withOpacity(0.33)),
          ),

          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: contents.length,
                  onPageChanged: (int index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (_, i) {
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * 0.3.h,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 40.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                contents[i].title,
                                textAlign: TextAlign.end,
                                style: textStyle30BoldPrimary,
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                textAlign: TextAlign.end,

                                contents[i].description,
                                style: textStyle20RegularPrimary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              Container(
                color: Colors.white,
                padding: EdgeInsets.only(bottom: 40.h, left: 20.w, right: 20.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        contents.length,
                        (index) => buildDot(index, currentIndex),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    CustomElevatedButton(
                      name: currentIndex == contents.length - 1
                          ? "ابدأ الآن"
                          : "التالي",
                      onPressed: () {
                        if (currentIndex == contents.length - 1) {
                          context.go(routes.signUpScreen);
                        } else {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOutCubic,
                          );
                        }
                      },
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
