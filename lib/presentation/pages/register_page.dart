import 'package:flutter/material.dart';

import '../widgets/auth_text_field.dart';
import '../widgets/primary_button.dart';

import '../../core/constants/app_colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {

    _nameController.dispose();

    _emailController.dispose();

    _passwordController.dispose();

    _confirmPasswordController.dispose();

    super.dispose();
  }

  String? _validateEmail(String? value) {

    if (value == null || value.trim().isEmpty) {
      return 'Ingresa tu correo';
    }

    final regex = RegExp(
      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
    );

    if (!regex.hasMatch(value.trim())) {
      return 'Correo electrónico inválido';
    }

    return null;
  }

  Future<void> _register() async {

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

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Registro simulado correctamente. '
          'No se creó una cuenta real.',
        ),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Crear cuenta'),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [

                const Icon(
                  Icons.person_add_alt_1,
                  color: AppColors.primary,
                  size: 70,
                ),

                const SizedBox(height: 20),

                const Text(
                  'Regístrate en UserMaster',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                AuthTextField(
                  label: 'Nombre completo',
                  icon: Icons.person,
                  controller: _nameController,

                  validator: (value) {

                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Ingresa tu nombre';
                    }

                    if (value.trim().length < 3) {
                      return 'El nombre es demasiado corto';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 18),

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
                      return 'Ingresa una contraseña';
                    }

                    if (value.length < 6) {
                      return 'Mínimo 6 caracteres';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 18),

                AuthTextField(
                  label: 'Confirmar contraseña',
                  icon: Icons.lock_outline,
                  controller: _confirmPasswordController,
                  obscureText: true,

                  validator: (value) {

                    if (value == null || value.isEmpty) {
                      return 'Confirma tu contraseña';
                    }

                    if (value != _passwordController.text) {
                      return 'Las contraseñas no coinciden';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 25),

                PrimaryButton(
                  text: 'Crear cuenta',
                  isLoading: _isLoading,
                  onPressed: _register,
                ),

                const SizedBox(height: 15),

                TextButton(
                  onPressed: _isLoading
                      ? null
                      : () {
                          Navigator.pop(context);
                        },

                  child: const Text(
                    'Ya tengo una cuenta',
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Este registro es una simulación local. '
                  'No se guardan usuarios en una base de datos.',
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
    );
  }
}