import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:task_mind/core/theme/app_theme.dart';
import 'package:task_mind/core/widgets/task_mind_logo.dart';
import 'package:task_mind/features/auth/screens/login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepNavy,
      body: Stack(
        children: [
          // Background Aesthetic: Luminous Velocity
          _buildBackgroundGlows(),

          // Main Content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  
                  // The New TaskMind Logo (Recreated from your image)
                  const TaskMindLogo(size: 120),

                  SizedBox(height: 40.h),
                  Text(
                    'TaskMind',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      fontSize: 48.sp,
                      letterSpacing: -1,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Where intelligence meets productivity.\nOrganize your deep work in a luminous environment.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.6,
                      fontSize: 18.sp,
                    ),
                  ),
                  const Spacer(flex: 3),
                  
                  // Get Started Button
                  _buildGetStartedButton(context),
                  
                  SizedBox(height: 60.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundGlows() {
    return Stack(
      children: [
        Positioned(
          top: -50.h,
          right: -50.w,
          child: Container(
            width: 350.w,
            height: 350.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accentIndigo.withValues(alpha: 0.15),
            ),
          ),
        ),
        Positioned(
          top: 250.h,
          left: -100.w,
          child: Container(
            width: 300.w,
            height: 300.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.emerald.withValues(alpha: 0.08),
            ),
          ),
        ),
        Positioned(
          bottom: -150.h,
          left: 50.w,
          right: 50.w,
          child: Container(
            width: 400.w,
            height: 400.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accentIndigo.withValues(alpha: 0.12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGetStartedButton(BuildContext context) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 64.h,
      borderRadius: 20.r,
      blur: 15,
      alignment: Alignment.center,
      border: 1.5,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withValues(alpha: 0.1),
          Colors.white.withValues(alpha: 0.05),
        ],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.accentIndigo.withValues(alpha: 0.5),
          AppColors.emerald.withValues(alpha: 0.5),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
          borderRadius: BorderRadius.circular(20.r),
          child: Center(
            child: Text(
              'Get Started',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
