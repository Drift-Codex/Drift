import 'package:flutter/material.dart';

import 'package:nafa_edu/prof/core/theme/app_theme.dart';

import 'élèves/routes/app_router.dart';

class NafaEduApp extends StatelessWidget {
  const NafaEduApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Nafa Edu',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
