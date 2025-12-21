import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/theme/app_theme.dart';
import '../../../../core/helpers/local_storage_account.dart';
import '../../../../core/router/routers.dart';

class CustomWelcomeHeader extends StatefulWidget {
  const CustomWelcomeHeader({super.key, required this.name});
  final String name;

  @override
  State<CustomWelcomeHeader> createState() => _CustomWelcomeHeaderState();
}

class _CustomWelcomeHeaderState extends State<CustomWelcomeHeader> {
  String? name;

  @override
  void initState() {
    super.initState();
    name = widget.name;
    _loadIfNeeded();
  }

  Future<void> _loadIfNeeded() async {
    if (name == null || name!.isEmpty) {
      final data = await UserDataManager.loadUserData();
      setState(() {
        name = data['name'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  context.go(routes.menuScreen);
                },
                icon: Icon(Icons.menu_outlined, size: 34),
              ),
              Expanded(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: [
                      Text(
                        "مرحبًا ${name}",
                        style: textStyle23SemiBoldBlack,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Image.asset(
                        "assets/images/hi.png",
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  context.go(
                    routes.accountScreen,
                    extra: {'name': name ?? widget.name ?? ''},
                  );
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(46.5),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    "assets/images/profile.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            ".كل ما تحتاجه للإقامة المثالية أصبح بين يديك الآن",
            style: textStyle17MediumBlack,
          ),
        ],
      ),
    );
  }
}
