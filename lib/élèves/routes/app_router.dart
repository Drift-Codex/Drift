import 'package:go_router/go_router.dart';

import '../screens/onboarding_screen.dart';
import '../screens/landing_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/auth/otp_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/exam_bank_screen.dart';
import '../screens/ai_assistant_screen.dart';
import '../screens/forum_screen.dart';
import '../screens/marketplace_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/teacher_portal_screen.dart';
import '../screens/help_screen.dart';
import '../screens/contact_screen.dart';
import '../screens/about_screen.dart';
import '../widgets/main_shell.dart';
import '../screens/post_detail_screen.dart';

class AppRouter {
  static GoRouter create({String initialLocation = '/'}) {
    return GoRouter(
      initialLocation: initialLocation,
      routes: [
      // Onboarding splash (no bottom nav)
      GoRoute(path: '/', builder: (context, state) => const OnboardingScreen()),

      // Auth routes (no bottom nav)
      GoRoute(
        path: '/auth/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/auth/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/auth/otp',
        builder: (context, state) => const OtpScreen(),
      ),

      // Main app routes (with bottom nav via ShellRoute)
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const ExamBankScreen(),
          ),
          GoRoute(
            path: '/statistiques',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/assistant',
            builder: (context, state) => const AiAssistantScreen(),
          ),
          GoRoute(
            path: '/forum',
            builder: (context, state) => const ForumScreen(),
          ),
          GoRoute(
            path: '/marketplace',
            builder: (context, state) => const MarketplaceScreen(),
          ),
          GoRoute(
            path: '/profil',
            builder: (context, state) => const ProfileScreen(),
          ),
          GoRoute(
            path: '/post-detail',
            builder: (context, state) {
              final args = state.extra as Map<String, dynamic>;
              return PostDetailScreen(
                author: args['author'],
                username: args['username'],
                title: args['title'],
                description: args['description'],
                imageUrl: args['imageUrl'],
                timeAgo: args['timeAgo'],
                aspectRatio: args['aspectRatio'],
                likes: args['likes'],
                shares: args['shares'],
                comments: args['comments'],
                category: args['category'],
                publishedAt: args['publishedAt'],
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: '/teacher-portal',
        builder: (context, state) => const TeacherPortalScreen(),
      ),
      GoRoute(
        path: '/parametres',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(path: '/aide', builder: (context, state) => const HelpScreen()),
      GoRoute(
        path: '/contact',
        builder: (context, state) => const ContactScreen(),
      ),
      GoRoute(
        path: '/a-propos',
        builder: (context, state) => const AboutScreen(),
      ),
    ],
  );
 }

  static GoRouter get router => create();
}
