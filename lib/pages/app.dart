import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uloginazure/models/auth_service_model.dart';
import 'package:uloginazure/models/auth_storage_model.dart';
import 'package:uloginazure/pages/inital_route_page.dart';
import 'package:uloginazure/pages/login/login_page.dart';
import 'package:uloginazure/routes/routes.dart';
import 'package:uloginazure/utils/helpers.dart';

class MyApp extends StatefulWidget {
  final Widget initialPage;

  const MyApp({super.key, required this.initialPage});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Timer _timer;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _startTokenRefreshTimer();
    _initialized = true;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTokenRefreshTimer() {
    _timer = Timer.periodic(const Duration(minutes: 75), (timer) async {
      if (_initialized) {
        String? token = await AuthStorage.getToken('GraphToken');
        if (token != null) {
          bool tokenValid = await AuthService.isTokenValid(token);
          if (tokenValid) {
            //Adquisicion de token de manera silenciosa
            await AuthService.acquireTokenSilently([
              "https://graph.microsoft.com/User.Read",
              "https://graph.microsoft.com/User.Read.All"
            ]);
          } else {
            // Si el token expira manda al login
            String logoutResult = await AuthService.logout();
            if (logoutResult == "Account removed") {
              await ApiServiceHelper.deleteAllTokens();
              // Redirige al usuario a la página de inicio
              Navigator.pushReplacementNamed(context, 'login');
            } else {
              // Si hay un error en el logout, muestra un mensaje de error
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(logoutResult),
                duration: const Duration(seconds: 3),
              ));
            }
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SiRe UTB',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(0, 103, 184, 1),
        ),
        useMaterial3: true,
      ),
      home: const InitialRoute(),
      routes: getRoutes(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case 'login':
            return MaterialPageRoute(builder: (context) => const LoginPage());
          case 'initial':
            return MaterialPageRoute(
                builder: (context) => const InitialRoute());
          default:
            // Si la ruta no se encuentra, regresa a página a una ruta predeterminada
            return MaterialPageRoute(builder: (context) => const LoginPage());
        }
      },
    );
  }
}
