import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:task_mind/core/theme/app_theme.dart';
import 'package:task_mind/features/auth/controllers/auth_controller.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.deepNavy,
      body: Stack(
        children: [
          _buildBackgroundGlows(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  _buildHeader(ref),
                  SizedBox(height: 30.h),
                  _buildDailyProgressCard(),
                  SizedBox(height: 30.h),
                  Text(
                    "Today's Focus",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Expanded(
                    child: _buildTaskPlaceholder(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Command Center',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14.sp,
              ),
            ),
            Text(
              'Stay Focused',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => ref.read(authControllerProvider.notifier).logout(),
          child: GlassmorphicContainer(
            width: 45.w,
            height: 45.h,
            borderRadius: 12.r,
            blur: 10,
            alignment: Alignment.center,
            border: 1,
            linearGradient: LinearGradient(
              colors: [Colors.white.withValues(alpha: 0.1), Colors.white.withValues(alpha: 0.05)],
            ),
            borderGradient: LinearGradient(
              colors: [AppColors.accentIndigo.withValues(alpha: 0.5), AppColors.emerald.withValues(alpha: 0.5)],
            ),
            child: const Icon(Icons.logout_rounded, color: Colors.white, size: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildDailyProgressCard() {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 160.h,
      borderRadius: 24.r,
      blur: 20,
      alignment: Alignment.center,
      border: 1.5,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.accentIndigo.withValues(alpha: 0.15),
          AppColors.emerald.withValues(alpha: 0.05),
        ],
      ),
      borderGradient: LinearGradient(
        colors: [AppColors.accentIndigo.withValues(alpha: 0.3), AppColors.emerald.withValues(alpha: 0.3)],
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Daily Goal',
                    style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'You have completed 0% of your tasks today.',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 13.sp),
                  ),
                ],
              ),
            ),
            Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.emerald.withValues(alpha: 0.5), width: 8.w),
              ),
              child: Center(
                child: Text('0%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskPlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_task_rounded, size: 60.sp, color: AppColors.textSecondary.withValues(alpha: 0.3)),
          SizedBox(height: 16.h),
          Text(
            'No focus tasks yet.\nReady to start deep work?',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 16.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundGlows() {
    return Stack(
      children: [
        Positioned(
          top: -100.h,
          right: -100.w,
          child: Container(
            width: 300.w,
            height: 300.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accentIndigo.withValues(alpha: 0.1),
            ),
          ),
        ),
      ],
    );
  }
}
