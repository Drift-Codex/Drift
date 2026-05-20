import 'package:go_router/go_router.dart';
import '../widgets/admin_shell.dart';
import '../screens/admin_dashboard_screen.dart';
import '../screens/admin_users_screen.dart';
import '../screens/admin_content_screen.dart';
import '../screens/admin_settings_screen.dart';
import '../screens/admin_create_subject_screen.dart';
import '../screens/admin_user_detail_screen.dart';
import '../screens/admin_statistics_screen.dart';
import '../screens/admin_create_course_screen.dart';

import '../screens/settings/admin_platform_info_screen.dart';
import '../screens/settings/admin_categories_screen.dart';
import '../screens/settings/admin_social_links_screen.dart';
import '../screens/settings/admin_administrators_screen.dart';
import '../screens/settings/admin_permissions_screen.dart';
import '../screens/settings/admin_backup_screen.dart';
import '../screens/settings/admin_notifications_screen.dart';
import '../screens/settings/admin_about_screen.dart';

class AdminRouter {
  static GoRouter create({String initialLocation = '/admin/dashboard'}) {
    return GoRouter(
      initialLocation: initialLocation,
      routes: [
        ShellRoute(
          builder: (context, state, child) => AdminShell(child: child),
          routes: [
            GoRoute(
              path: '/admin/dashboard',
              builder: (context, state) => const AdminDashboardScreen(),
            ),
            GoRoute(
              path: '/admin/users',
              builder: (context, state) => const AdminUsersScreen(),
            ),
            GoRoute(
              path: '/admin/content',
              builder: (context, state) => const AdminContentScreen(),
            ),
            GoRoute(
              path: '/admin/settings',
              builder: (context, state) => const AdminSettingsScreen(),
            ),
          ],
        ),
        GoRoute(
          path: '/admin/create_subject',
          builder: (context, state) => const AdminCreateSubjectScreen(),
        ),
        GoRoute(
          path: '/admin/user_detail',
          builder: (context, state) => const AdminUserDetailScreen(),
        ),
        GoRoute(
          path: '/admin/statistics',
          builder: (context, state) => const AdminStatisticsScreen(),
        ),
        GoRoute(
          path: '/admin/create_course',
          builder: (context, state) => const AdminCreateCourseScreen(),
        ),
        // Paramètres Sous-pages
        GoRoute(
          path: '/admin/settings/platform_info',
          builder: (context, state) => const AdminPlatformInfoScreen(),
        ),
        GoRoute(
          path: '/admin/settings/categories',
          builder: (context, state) => const AdminCategoriesScreen(),
        ),
        GoRoute(
          path: '/admin/settings/social_links',
          builder: (context, state) => const AdminSocialLinksScreen(),
        ),
        GoRoute(
          path: '/admin/settings/administrators',
          builder: (context, state) => const AdminAdministratorsScreen(),
        ),
        GoRoute(
          path: '/admin/settings/permissions',
          builder: (context, state) => const AdminPermissionsScreen(),
        ),
        GoRoute(
          path: '/admin/settings/backup',
          builder: (context, state) => const AdminBackupScreen(),
        ),
        GoRoute(
          path: '/admin/settings/notifications',
          builder: (context, state) => const AdminNotificationsScreen(),
        ),
        GoRoute(
          path: '/admin/settings/about',
          builder: (context, state) => const AdminAboutScreen(),
        ),
      ],
    );
  }
}
