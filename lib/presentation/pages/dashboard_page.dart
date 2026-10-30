import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

import '../../domain/entities/user_profile.dart';

import '../routes/app_routes.dart';
import 'profile_page.dart';

class DashboardPage extends StatefulWidget {
  final UserProfile user;

  const DashboardPage({super.key, required this.user});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
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

      ProfilePage(user: widget.user, onLogout: _logout),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'UserMaster' : 'Mi perfil'),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey,
        backgroundColor: AppColors.white,
        elevation: 12,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  Widget _buildHome() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'BIENVENIDO',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Hola, ${widget.user.name}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Este es tu panel de usuario.',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.waving_hand_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        const Text(
          'Actividad reciente',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        ..._tasks.map((task) {
          return Card(
            color: AppColors.white,
            elevation: 1,
            shadowColor: AppColors.black.withValues(alpha: 0.06),
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            clipBehavior: Clip.antiAlias,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 6,
              ),
              leading: CircleAvatar(
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                child: Icon(task['icon'] as IconData, color: AppColors.primary),
              ),
              title: Text(
                task['title'] as String,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(task['description'] as String),
              trailing: const Icon(Icons.chevron_right, color: AppColors.grey),
            ),
          );
        }),
      ],
    );
  }

  void _logout() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
    );
  }
}
