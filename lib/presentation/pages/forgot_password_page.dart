import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

import '../widgets/auth_text_field.dart';
import '../widgets/primary_button.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() =>
      _ForgotPasswordPageState();
}

class _ForgotPasswordPageState
    extends State<ForgotPasswordPage> {

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  Future<void> _sendRecovery() async {

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

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Solicitud simulada correctamente. '
          'No se envió ningún correo real.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Recuperar contraseña'),
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [

                const Icon(
                  Icons.lock_reset,
                  size: 85,
                  color: AppColors.primary,
                ),

                const SizedBox(height: 20),

                const Text(
                  '¿Olvidaste tu contraseña?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  'Ingresa tu correo electrónico para '
                  'simular una solicitud de recuperación.',
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 30),

                AuthTextField(
                  label: 'Correo electrónico',
                  icon: Icons.email,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,

                  validator: (value) {

                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Ingresa tu correo';
                    }

                    final regex = RegExp(
                      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                    );

                    if (!regex.hasMatch(value.trim())) {
                      return 'Correo inválido';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 25),

                PrimaryButton(
                  text: 'Enviar enlace de recuperación',
                  isLoading: _isLoading,
                  onPressed: _sendRecovery,
                ),

                const SizedBox(height: 15),

                TextButton(
                  onPressed: _isLoading
                      ? null
                      : () {
                          Navigator.pop(context);
                        },

                  child: const Text(
                    'Volver al inicio de sesión',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}