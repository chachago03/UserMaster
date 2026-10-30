import 'package:flutter/material.dart';

import 'core/themes/app_theme.dart';
import 'presentation/routes/app_routes.dart';

class UserMasterApp extends StatelessWidget {
  const UserMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UserMaster',

      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme,

      initialRoute: AppRoutes.splash,

      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}