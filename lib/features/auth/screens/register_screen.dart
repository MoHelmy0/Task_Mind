import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:task_mind/core/theme/app_theme.dart';
import 'package:task_mind/core/widgets/task_mind_logo.dart';
import 'package:task_mind/features/auth/controllers/auth_controller.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    await ref.read(authControllerProvider.notifier).signUp(email, password, name);

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
      // ✅ النجاح: نقوم بمسح شاشات التسجيل والعودة للشاشة الرئيسية
      // الـ main.dart سيقوم بعرض الـ Dashboard تلقائياً لأن الـ State تغيرت
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
                    const TaskMindLogo(size: 80),
                    SizedBox(height: 24.h),
                    Text(
                      'Create Account',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                            fontSize: 28.sp,
                          ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Join TaskMind and start your journey',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 15.sp,
                          ),
                    ),
                    SizedBox(height: 40.h),
                    
                    _buildGlassTextField(
                      controller: _nameController,
                      hint: 'Full Name',
                      icon: Icons.person_outline_rounded,
                    ),
                    SizedBox(height: 16.h),
                    
                    _buildGlassTextField(
                      controller: _emailController,
                      hint: 'Email Address',
                      icon: Icons.email_outlined,
                    ),
                    SizedBox(height: 16.h),
                    
                    _buildGlassTextField(
                      controller: _passwordController,
                      hint: 'Password',
                      icon: Icons.lock_outline_rounded,
                      isPassword: true,
                    ),
                    SizedBox(height: 16.h),
                    
                    _buildGlassTextField(
                      controller: _confirmPasswordController,
                      hint: 'Confirm Password',
                      icon: Icons.lock_reset_rounded,
                      isPassword: true,
                    ),
                    
                    SizedBox(height: 32.h),
                    
                    isLoading 
                      ? const CircularProgressIndicator(color: AppColors.accentIndigo)
                      : _buildRegisterButton(context),

                    SizedBox(height: 24.h),
                    _buildLoginRedirect(),
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

  Widget _buildLoginRedirect() {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Text(
          "Already have an account? ",
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
        ),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Text(
            'Login',
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

  Widget _buildRegisterButton(BuildContext context) {
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
          onTap: _register,
          borderRadius: BorderRadius.circular(16.r),
          child: Center(
            child: Text(
              'Register',
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

  Widget _buildBackgroundGlows() {
    return Container();
  }
}
