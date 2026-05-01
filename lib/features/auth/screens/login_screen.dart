import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:task_mind/core/theme/app_theme.dart';
import 'package:task_mind/core/widgets/task_mind_logo.dart';
import 'package:task_mind/features/auth/controllers/auth_controller.dart';
import 'package:task_mind/features/auth/screens/register_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      await ref.read(authControllerProvider.notifier).login(email, password);
      _handleAuthState();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
    }
  }

  void _loginWithGoogle() async {
    await ref.read(authControllerProvider.notifier).signInWithGoogle();
    _handleAuthState();
  }

  void _handleAuthState() {
    final authState = ref.read(authControllerProvider);
    if (authState.hasError) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authState.error.toString()),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } else {
      // ✅ النجاح: نغلق شاشة الدخول ونرجع للـ Dashboard
      if (mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider).isLoading;

    return Scaffold(
      backgroundColor: AppColors.deepNavy,
      body: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          _buildBackgroundGlows(),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.h),
                    const TaskMindLogo(size: 100),
                    SizedBox(height: 24.h),
                    Text(
                      'Welcome Back',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                            fontSize: 28.sp,
                          ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Log in to continue your deep work',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 15.sp,
                          ),
                    ),
                    SizedBox(height: 40.h),
                    _buildGlassTextField(
                      controller: _emailController,
                      hint: 'Email Address',
                      icon: Icons.email_outlined,
                    ),
                    SizedBox(height: 20.h),
                    _buildGlassTextField(
                      controller: _passwordController,
                      hint: 'Password',
                      icon: Icons.lock_outline_rounded,
                      isPassword: true,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: AppColors.accentIndigo,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),
                    isLoading 
                      ? const CircularProgressIndicator(color: AppColors.accentIndigo)
                      : Column(
                          children: [
                            _buildLoginButton(context),
                            SizedBox(height: 20.h),
                            _buildGoogleSignInButton(),
                          ],
                        ),
                    SizedBox(height: 32.h),
                    _buildRegisterRedirect(),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterRedirect() {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterScreen()),
            );
          },
          child: Text(
            'Register',
            style: TextStyle(
              color: AppColors.emerald,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGlassTextField({
    required TextEditingController controller,
    required String hint, 
    required IconData icon, 
    bool isPassword = false
  }) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 56.h,
      borderRadius: 16.r,
      blur: 10,
      alignment: Alignment.center,
      border: 1,
      linearGradient: LinearGradient(
        colors: [
          Colors.white.withValues(alpha: 0.05),
          Colors.white.withValues(alpha: 0.02),
        ],
      ),
      borderGradient: LinearGradient(
        colors: [
          Colors.white.withValues(alpha: 0.1),
          Colors.white.withValues(alpha: 0.05),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: AppColors.textSecondary, size: 20.sp),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15.h),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 60.h,
      borderRadius: 16.r,
      blur: 20,
      alignment: Alignment.center,
      border: 1.5,
      linearGradient: LinearGradient(
        colors: [
          AppColors.accentIndigo.withValues(alpha: 0.8),
          AppColors.accentIndigo.withValues(alpha: 0.6),
        ],
      ),
      borderGradient: LinearGradient(
        colors: [
          AppColors.accentIndigo.withValues(alpha: 0.5),
          AppColors.emerald.withValues(alpha: 0.5),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _login,
          borderRadius: BorderRadius.circular(16.r),
          child: Center(
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleSignInButton() {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 60.h,
      borderRadius: 16.r,
      blur: 10,
      alignment: Alignment.center,
      border: 1,
      linearGradient: LinearGradient(
        colors: [
          Colors.white.withValues(alpha: 0.1),
          Colors.white.withValues(alpha: 0.05),
        ],
      ),
      borderGradient: LinearGradient(
        colors: [
          Colors.white.withValues(alpha: 0.2),
          Colors.white.withValues(alpha: 0.1),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _loginWithGoogle,
          borderRadius: BorderRadius.circular(16.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.g_mobiledata_rounded, color: Colors.white, size: 35),
              SizedBox(width: 8.w),
              Text(
                'Continue with Google',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundGlows() {
    return Container();
  }
}
