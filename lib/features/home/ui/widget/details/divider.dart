import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        height: 1,
        // DividerThemeData in AppThemeData provides the correct colour for
        // both light (0xFFD9D9D9) and dark (0xFF3A3A4A) automatically.
        color: Theme.of(context).dividerTheme.color,
      ),
    );
  }
}
