import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_mind/core/theme/app_theme.dart';
import 'package:task_mind/features/auth/data/auth_repository.dart';
import 'package:task_mind/features/dashboard/screens/main_navigation_screen.dart';
import 'package:task_mind/features/onboarding/screens/onboarding_screen.dart';
import 'firebase_options.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: TaskMindApp(),
    ),
  );
}

class TaskMindApp extends ConsumerWidget {
  const TaskMindApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return ScreenUtilInit(
      designSize: const Size(411, 891),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'TaskMind',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
          home: authState.when(
            data: (user) {
              if (user != null) {
                return const MainNavigationScreen();
              }
              return const OnboardingScreen();
            },
            loading: () => const Scaffold(
              backgroundColor: AppColors.deepNavy,
              body: Center(
                child: CircularProgressIndicator(color: AppColors.accentIndigo),
              ),
            ),
            error: (e, st) => Scaffold(
              backgroundColor: AppColors.deepNavy,
              body: Center(child: Text('Error: $e', style: const TextStyle(color: Colors.white))),
            ),
          ),
        );
      },
    );
  }
}
