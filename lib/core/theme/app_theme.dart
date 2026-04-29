import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color midnightNavy = Color(0xFF0A0E14);
  static const Color indigo = Color(0xFF3F51B5);
  static const Color deepNavy = Color(0xFF020617);
  static const Color surfaceNavy = Color(0xFF1E293B);
  static const Color emerald = Color(0xFF10B981);
  static const Color accentIndigo = Color(0xFF6366F1);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color error = Color(0xFFEF4444);
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.deepNavy,
      primaryColor: AppColors.accentIndigo,
      fontFamily: GoogleFonts.manrope().fontFamily,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accentIndigo,
        secondary: AppColors.emerald,
        surface: AppColors.surfaceNavy,
        onSurface: AppColors.textPrimary,
        error: AppColors.error,
      ),
      textTheme: GoogleFonts.manropeTextTheme(
        ThemeData.dark().textTheme,
      ).apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceNavy.withValues(alpha: 0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.white10, width: 1.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.accentIndigo.withValues(alpha: 0.5), width: 1.w),
        ),
        labelStyle: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
        hintStyle: TextStyle(color: AppColors.textSecondary.withValues(alpha: 0.5), fontSize: 14.sp),
      ),
      useMaterial3: true,
    );
  }
}
