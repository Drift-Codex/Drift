import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/app_feedback.dart';
import 'navigation/main_tab_scope.dart';
import 'widgets/top_app_bar.dart';
import 'widgets/bottom_nav_bar.dart';
import 'features/teacher_dashboard/dashboard_page.dart';
import 'features/auth/login_page.dart';
import 'features/announcements/announcements_page.dart';
import 'features/sales/sales_page.dart';
import 'features/stats/stats_page.dart';
import 'features/profile/profile_page.dart';

void main() {
  runApp(const EduPlatformTeacherApp());
}

class EduPlatformTeacherApp extends StatelessWidget {
  const EduPlatformTeacherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduPlatform BF - Teacher Dashboard',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}

class MainLayout extends StatefulWidget {
  final String teacherName;

  const MainLayout({super.key, required this.teacherName});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // On met à jour dynamiquement la première page avec le nom du professeur
    final List<Widget> pages = [
      DashboardPage(teacherName: widget.teacherName),
      const AnnouncementsPage(),
      const SalesPage(),
      const StatsPage(),
      const ProfilePage(),
    ];

    return MainTabScope(
      goToTab: (index) {
        setState(() {
          _currentIndex = index.clamp(0, pages.length - 1);
        });
      },
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: TeacherTopAppBar(
              onNotificationTap: () {
                AppFeedback.snackBar(context, 'Aucune nouvelle notification.');
              },
            ),
            body: Stack(
              children: [
                pages[_currentIndex],
                TeacherBottomNavBar(
                  currentIndex: _currentIndex,
                  onTap: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
