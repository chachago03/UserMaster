import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../routes/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();

    _goToLogin();
  }

  Future<void> _goToLogin() async {

    await Future.delayed(
      const Duration(seconds: 3),
    );

    if (!mounted) return;

    Navigator.pushReplacementNamed(
      context,
      AppRoutes.login,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: const [
            Icon(
              Icons.flutter_dash,
              color: Colors.white,
              size: 100,
            ),

            SizedBox(height: 20),

            Text(
              'UserMaster',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}