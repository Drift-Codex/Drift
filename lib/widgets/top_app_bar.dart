import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../core/app_feedback.dart';

class TeacherTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final String avatarUrl;
  final VoidCallback? onNotificationTap;

  const TeacherTopAppBar({
    super.key,
    this.title = 'EduPlatform BF',
    this.subtitle = 'DASHBOARD',
    this.avatarUrl = 'https://ui-avatars.com/api/?name=Prof+Issouf&background=random',
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64, // h-16
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8), // px-container-margin py-base
      decoration: BoxDecoration(
        color: AppTheme.surface,
        boxShadow: [
          BoxShadow(
            color: const Color(0x0D111111), // rgba(17,17,17,0.05)
            offset: const Offset(0, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppTheme.primaryContainer, width: 2),
                  image: DecorationImage(
                    image: NetworkImage(avatarUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12), // gap-sm
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    subtitle.toUpperCase(),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: AppTheme.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: onNotificationTap ??
                  () {
                    AppFeedback.snackBar(context, 'Centre de notifications (démo).');
                  },
              child: Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.notifications_outlined,
                  color: AppTheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}
