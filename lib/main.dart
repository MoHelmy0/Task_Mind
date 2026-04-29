import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_mind/core/theme/app_theme.dart';
import 'package:task_mind/features/onboarding/screens/onboarding_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: TaskMindApp(),
    ),
  );
}

class TaskMindApp extends StatelessWidget {
  const TaskMindApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 891), // Pixel 6 logical size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'TaskMind',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
          home: const OnboardingScreen(),
        );
      },
    );
  }
}
