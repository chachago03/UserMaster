import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

import '../../domain/entities/user_profile.dart';

import '../widgets/primary_button.dart';

class ProfilePage extends StatelessWidget {

  final UserProfile user;

  final VoidCallback onLogout;

  const ProfilePage({
    super.key,
    required this.user,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {

    return Center(

      child: SingleChildScrollView(

        padding: const EdgeInsets.all(24),

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            const CircleAvatar(
              radius: 55,

              backgroundColor: AppColors.primary,

              child: Icon(
                Icons.person,
                size: 65,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              user.name,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              user.email,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.grey,
              ),
            ),

            const SizedBox(height: 35),

            Card(

              child: ListTile(
                leading: const Icon(
                  Icons.person_outline,
                  color: AppColors.primary,
                ),

                title: const Text('Nombre completo'),

                subtitle: Text(user.name),
              ),
            ),

            Card(

              child: ListTile(
                leading: const Icon(
                  Icons.email_outlined,
                  color: AppColors.primary,
                ),

                title: const Text('Correo electrónico'),

                subtitle: Text(user.email),
              ),
            ),

            const SizedBox(height: 30),

            PrimaryButton(
              text: 'Cerrar sesión',
              color: AppColors.red,
              onPressed: onLogout,
            ),

          ],
        ),
      ),
    );
  }
}