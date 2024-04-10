import 'package:flutter/material.dart';
import 'package:uloginazure/pages/admin/navigation_page.dart';
import 'package:uloginazure/pages/app.dart';
import 'pages/login/login_page.dart';
import 'models/auth_storage_model.dart';
import 'models/auth_service_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Obtener el token almacenado al iniciar la aplicación
  String? token = await AuthStorage.getToken('GraphToken');
  // Verifica si el token es válido
  bool tokenValid =
      token != null ? await AuthService.isTokenValid(token) : false;
  // Definir la página de inicio basada en la presencia de un token válido
  Widget initialPage = tokenValid ? const NavigationPage() : const LoginPage();
  runApp(MyApp(initialPage: initialPage));
}
