import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:task_mind/core/theme/app_theme.dart';
import 'package:task_mind/features/dashboard/screens/dashboard_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const Center(child: Text('Tasks Screen', style: TextStyle(color: Colors.white))),
    const Center(child: Text('Calendar Screen', style: TextStyle(color: Colors.white))),
    const Center(child: Text('Focus Session', style: TextStyle(color: Colors.white))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepNavy,
      extendBody: true, // This allows the content to go behind the bottom bar
      body: _screens[_selectedIndex],
      floatingActionButton: _buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildFab() {
    return Container(
      width: 64.w,
      height: 64.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [AppColors.accentIndigo, AppColors.emerald],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentIndigo.withValues(alpha: 0.4),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: RawMaterialButton(
        onPressed: () {
          // TODO: Add Task Logic
        },
        shape: const CircleBorder(),
        child: Icon(Icons.add_rounded, color: Colors.white, size: 32.sp),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h, left: 16.w, right: 16.w),
      child: GlassmorphicContainer(
        width: double.infinity,
        height: 70.h,
        borderRadius: 24.r,
        blur: 20,
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
            AppColors.accentIndigo.withValues(alpha: 0.3),
            AppColors.emerald.withValues(alpha: 0.3),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home_filled, 0, 'Home'),
            _buildNavItem(Icons.task_alt_rounded, 1, 'Tasks'),
            SizedBox(width: 40.w), // Space for FAB
            _buildNavItem(Icons.calendar_month_rounded, 2, 'Calendar'),
            _buildNavItem(Icons.timer_rounded, 3, 'Focus'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index, String label) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.accentIndigo : AppColors.textSecondary,
            size: 26.sp,
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.accentIndigo : AppColors.textSecondary,
              fontSize: 10.sp,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
