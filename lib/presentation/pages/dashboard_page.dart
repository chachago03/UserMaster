import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

import '../../domain/entities/user_profile.dart';

import 'profile_page.dart';

class DashboardPage extends StatefulWidget {

  final UserProfile user;

  const DashboardPage({
    super.key,
    required this.user,
  });

  @override
  State<DashboardPage> createState() =>
      _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _tasks = [

    {
      'title': 'Bienvenido a UserMaster',
      'description': 'Tu espacio de gestión de usuarios.',
      'icon': Icons.waving_hand,
    },

    {
      'title': 'Perfil actualizado',
      'description': 'Consulta tu información personal.',
      'icon': Icons.person,
    },

    {
      'title': 'Nueva actividad',
      'description': 'Tienes una nueva actividad pendiente.',
      'icon': Icons.notifications,
    },

    {
      'title': 'Seguridad',
      'description': 'Recuerda proteger tus credenciales.',
      'icon': Icons.security,
    },

    {
      'title': 'Organización',
      'description': 'Mantén tus tareas organizadas.',
      'icon': Icons.check_circle,
    },

  ];

  @override
  Widget build(BuildContext context) {

    final List<Widget> pages = [

      _buildHome(),

      ProfilePage(
        user: widget.user,
        onLogout: _logout,
      ),

    ];

    return Scaffold(

      appBar: AppBar(
        title: Text(
          _selectedIndex == 0 ? 'UserMaster' : 'Mi perfil',
        ),
      ),

      body: pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: _selectedIndex,

        selectedItemColor: AppColors.primary,

        onTap: (index) {

          setState(() {
            _selectedIndex = index;
          });

        },

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),

        ],
      ),
    );
  }

  Widget _buildHome() {

    return ListView(

      padding: const EdgeInsets.all(20),

      children: [

        Text(
          'Hola, ${widget.user.name}',
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        const Text(
          'Bienvenido a tu panel de usuario.',
          style: TextStyle(
            color: AppColors.grey,
          ),
        ),

        const SizedBox(height: 25),

        const Text(
          'Mis actividades',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        ..._tasks.map((task) {

          return Card(

            margin: const EdgeInsets.only(bottom: 12),

            child: ListTile(

              leading: CircleAvatar(
                backgroundColor: AppColors.primary.withValues(
                  alpha: 0.12,
                ),

                child: Icon(
                  task['icon'] as IconData,
                  color: AppColors.primary,
                ),
              ),

              title: Text(
                task['title'] as String,
              ),

              subtitle: Text(
                task['description'] as String,
              ),

              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ),
          );

        }),

      ],
    );
  }

  void _logout() {

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
      (route) => false,
    );

  }
}