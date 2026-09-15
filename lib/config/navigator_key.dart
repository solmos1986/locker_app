import 'package:flutter/material.dart';

/// Permite navegar y acceder a providers desde fuera del árbol de widgets
/// (p. ej. desde un evento de Socket.IO recibido mientras el usuario está
/// en cualquier pantalla).
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
