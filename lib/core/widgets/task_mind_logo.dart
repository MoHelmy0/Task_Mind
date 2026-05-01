import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_mind/core/theme/app_theme.dart';

class TaskMindLogo extends StatelessWidget {
  final double size;
  final bool showShadow;

  const TaskMindLogo({
    super.key,
    this.size = 120,
    this.showShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.w,
      height: size.h,
      decoration: BoxDecoration(
        color: AppColors.accentIndigo,
        borderRadius: BorderRadius.circular(size * 0.28).r,
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: AppColors.accentIndigo.withValues(alpha: 0.4),
                  blurRadius: 30,
                  spreadRadius: 2,
                )
              ]
            : null,
      ),
      child: Icon(
        Icons.hub_rounded, // هذا هو الأيقونة الأقرب للشعار في الصورة
        size: (size * 0.6).sp,
        color: Colors.white,
      ),
    );
  }
}
