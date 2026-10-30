import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

import '../../domain/entities/user_profile.dart';

import '../widgets/primary_button.dart';

class ProfilePage extends StatelessWidget {
  final UserProfile user;

  final VoidCallback onLogout;

  const ProfilePage({super.key, required this.user, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      children: [
        Card(
          color: AppColors.white,
          elevation: 1,
          shadowColor: AppColors.black.withValues(alpha: 0.06),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 42,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  child: const Icon(
                    Icons.person,
                    size: 48,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  user.name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  user.email,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.grey),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Información personal',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Card(
          color: AppColors.white,
          elevation: 1,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.person_outline,
                  color: AppColors.primary,
                ),
                title: const Text('Nombre completo'),
                subtitle: Text(user.name),
              ),
              const Divider(height: 1, indent: 72),
              ListTile(
                leading: const Icon(
                  Icons.email_outlined,
                  color: AppColors.primary,
                ),
                title: const Text('Correo electrónico'),
                subtitle: Text(user.email),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        PrimaryButton(
          text: 'Cerrar sesión',
          color: AppColors.red,
          onPressed: onLogout,
        ),
      ],
    );
  }
}
