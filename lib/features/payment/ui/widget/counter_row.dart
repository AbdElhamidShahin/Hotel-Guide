import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CounterRow extends StatelessWidget {
  final String title;
  final int value;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const CounterRow({
    super.key,
    required this.title,
    required this.value,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16.sp)),
          Row(
            children: [
              _circleBtn(Icons.remove, onRemove),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Text('$value',
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
              ),
              _circleBtn(Icons.add, onAdd),
            ],
          )
        ],
      ),
    );
  }

  Widget _circleBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 16,
        backgroundColor: const Color(0xFF2D2D3F),
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }
}
