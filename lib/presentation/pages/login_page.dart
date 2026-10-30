import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../domain/entities/user_profile.dart';

import '../routes/app_routes.dart';

import '../widgets/auth_text_field.dart';
import '../widgets/primary_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  String? _validateEmail(String? value) {

    if (value == null || value.trim().isEmpty) {
      return 'Ingresa tu correo electrónico';
    }

    final emailRegex = RegExp(
      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Ingresa un correo válido';
    }

    return null;
  }

  Future<void> _login() async {

    if (_isLoading) return;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (!mounted) return;

    final email = _emailController.text.trim();

    final user = UserProfile(
      name: _getNameFromEmail(email),
      email: email,
    );

    Navigator.pushReplacementNamed(
      context,
      AppRoutes.dashboard,
      arguments: user,
    );
  }

  String _getNameFromEmail(String email) {

    final username = email.split('@').first;

    if (username.isEmpty) {
      return 'Usuario';
    }

    return username[0].toUpperCase() +
        username.substring(1);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),

            child: Form(
              key: _formKey,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,

                children: [

                  const Icon(
                    Icons.flutter_dash,
                    size: 80,
                    color: AppColors.primary,
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Bienvenido a UserMaster',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Ingresa tus datos para continuar',
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 35),

                  AuthTextField(
                    label: 'Correo electrónico',
                    icon: Icons.email,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: _validateEmail,
                  ),

                  const SizedBox(height: 18),

                  AuthTextField(
                    label: 'Contraseña',
                    icon: Icons.lock,
                    controller: _passwordController,
                    obscureText: true,

                    validator: (value) {

                      if (value == null || value.isEmpty) {
                        return 'Ingresa tu contraseña';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 12),

                  Align(
                    alignment: Alignment.centerRight,

                    child: TextButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.forgotPassword,
                              );
                            },

                      child: const Text(
                        '¿Olvidaste tu contraseña?',
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  PrimaryButton(
                    text: 'Ingresar',
                    isLoading: _isLoading,
                    onPressed: _login,
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      const Text(
                        '¿No tienes una cuenta?',
                      ),

                      TextButton(
                        onPressed: _isLoading
                            ? null
                            : () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.register,
                                );
                              },

                        child: const Text('Regístrate'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Inicio de sesión de demostración. '
                    'No se verifican credenciales en un servidor.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}