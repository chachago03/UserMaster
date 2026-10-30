import 'package:flutter/material.dart';

import '../pages/splash_page.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';
import '../pages/forgot_password_page.dart';
import '../pages/dashboard_page.dart';

import '../../domain/entities/user_profile.dart';

class AppRoutes {
  static const String splash = '/';

  static const String login = '/login';

  static const String register = '/register';

  static const String forgotPassword = '/forgot-password';

  static const String dashboard = '/dashboard';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
          settings: settings,
        );

      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
          settings: settings,
        );

      case register:
        return MaterialPageRoute(
          builder: (_) => const RegisterPage(),
          settings: settings,
        );

      case forgotPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordPage(),
          settings: settings,
        );

      case dashboard:
        final arguments = settings.arguments;

        if (arguments is UserProfile) {
          return MaterialPageRoute(
            builder: (_) => DashboardPage(user: arguments),
            settings: settings,
          );
        }

        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
    }
  }
}