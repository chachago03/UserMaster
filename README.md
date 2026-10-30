# UserMaster

Aplicación Flutter desarrollada para el Taller 2.

## Descripción

UserMaster es una aplicación de gestión de usuarios
que implementa pantallas de autenticación y navegación
siguiendo principios básicos de Clean Architecture.

## Tecnologías

- Flutter
- Dart
- Material Design 3
- Git
- GitHub

## Funcionalidades

- Splash Screen.
- Inicio de sesión.
- Registro de usuarios.
- Recuperación de contraseña.
- Dashboard.
- Perfil de usuario.
- Cierre de sesión.
- Navegación mediante rutas centralizadas.

## Arquitectura

El proyecto está organizado en:

- Core: configuraciones y componentes generales.
- Domain: entidades principales.
- Presentation: pantallas, rutas y widgets.

## Ejecución

Instalar dependencias:

    flutter pub get

Ejecutar aplicación:

    flutter run

Ejecutar en Chrome:

    flutter run -d chrome

Analizar código:

    flutter analyze

Ejecutar pruebas:

    flutter test

## Consideraciones

Esta versión no utiliza backend ni base de datos.

El inicio de sesión, registro y recuperación
de contraseña son simulaciones locales.

No se guardan usuarios ni se envían correos reales.