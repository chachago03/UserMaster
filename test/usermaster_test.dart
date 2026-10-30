import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:usermaster/domain/entities/user_profile.dart';

import 'package:usermaster/presentation/pages/login_page.dart';
import 'package:usermaster/presentation/pages/register_page.dart';
import 'package:usermaster/presentation/pages/forgot_password_page.dart';
import 'package:usermaster/presentation/pages/dashboard_page.dart';

import 'package:usermaster/presentation/routes/app_routes.dart';

void main() {

  Widget createTestApp() {

    return MaterialApp(
      home: const LoginPage(),
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }

  group('Pruebas de UserMaster', () {

    testWidgets(
      'Login permite navegar a Registro',
      (tester) async {

        await tester.pumpWidget(createTestApp());

        expect(find.byType(LoginPage), findsOneWidget);

        await tester.tap(find.text('Regístrate'));

        await tester.pumpAndSettle();

        expect(find.byType(RegisterPage), findsOneWidget);

      },
    );

    testWidgets(
      'Login permite navegar a Recuperar contraseña',
      (tester) async {

        await tester.pumpWidget(createTestApp());

        expect(find.byType(LoginPage), findsOneWidget);

        await tester.tap(
          find.text('¿Olvidaste tu contraseña?'),
        );

        await tester.pumpAndSettle();

        expect(
          find.byType(ForgotPasswordPage),
          findsOneWidget,
        );

      },
    );

    testWidgets(
      'Registro muestra error si las contraseñas no coinciden',
      (tester) async {

        await tester.pumpWidget(
          const MaterialApp(
            home: RegisterPage(),
          ),
        );

        final fields = find.byType(TextFormField);

        await tester.enterText(fields.at(0), 'Santiago');

        await tester.enterText(
          fields.at(1),
          'santiago@gmail.com',
        );

        await tester.enterText(
          fields.at(2),
          '123456',
        );

        await tester.enterText(
          fields.at(3),
          '654321',
        );

        await tester.tap(
          find.widgetWithText(ElevatedButton, 'Crear cuenta'),
        );

        await tester.pump();

        expect(
          find.text('Las contraseñas no coinciden'),
          findsOneWidget,
        );

      },
    );

    testWidgets(
      'Dashboard muestra cinco tarjetas',
      (tester) async {

        tester.view.physicalSize = const Size(1080, 2400);

        tester.view.devicePixelRatio = 1;

        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          MaterialApp(
            home: DashboardPage(
              user: const UserProfile(
                name: 'Santiago',
                email: 'santiago@gmail.com',
              ),
            ),
          ),
        );

        expect(
          find.byType(Card),
          findsNWidgets(5),
        );

      },
    );

    testWidgets(
      'Perfil muestra el botón de cerrar sesión',
      (tester) async {

        await tester.pumpWidget(
          MaterialApp(
            home: DashboardPage(
              user: const UserProfile(
                name: 'Santiago',
                email: 'santiago@gmail.com',
              ),
            ),
          ),
        );

        await tester.tap(find.text('Perfil'));

        await tester.pumpAndSettle();

        expect(
          find.text('Cerrar sesión'),
          findsOneWidget,
        );

      },
    );

    testWidgets(
      'Cerrar sesión vuelve a Login y elimina Dashboard',
      (tester) async {

        await tester.pumpWidget(
          MaterialApp(
            onGenerateRoute: AppRoutes.generateRoute,

            home: const DashboardPage(
              user: UserProfile(
                name: 'Santiago',
                email: 'santiago@gmail.com',
              ),
            ),
          ),
        );

        await tester.tap(find.text('Perfil'));

        await tester.pumpAndSettle();

        await tester.tap(find.text('Cerrar sesión'));

        await tester.pumpAndSettle();

        expect(find.byType(LoginPage), findsOneWidget);

        expect(find.byType(DashboardPage), findsNothing);

      },
    );

  });

}