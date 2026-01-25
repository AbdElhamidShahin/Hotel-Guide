import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentTile extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;
  final Widget? trailing;

  const PaymentTile({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? const Color(0xFF8E7CFF) : Colors.grey[300]!,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
            ),
            const Spacer(),
            Text(title),
            if (trailing != null) ...[
              SizedBox(width: 8.w),
              trailing!,
            ]
          ],
        ),
      ),
    );
  }
}
