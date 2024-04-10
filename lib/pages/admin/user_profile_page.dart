import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uloginazure/utils/helpers.dart';
import '../../models/auth_service_model.dart';
import '../../models/api_services_model.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      Map<String, dynamic> userProfile =
          await ApiService.fetchUserProfile(context);
      setState(() {
        userData = userProfile;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user profile: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Center(
        child: userData.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    UserProfileField(
                      label: 'Display Name',
                      value: userData['displayName'],
                      icon: Icons.person,
                    ),
                    UserProfileField(
                      label: 'Given Name',
                      value: userData['givenName'],
                      icon: Icons.person,
                    ),
                    UserProfileField(
                      label: 'Job Title',
                      value: userData['jobTitle'],
                      icon: Icons.work,
                    ),
                    UserProfileField(
                      label: 'Surname',
                      value: userData['surname'],
                      icon: Icons.person,
                    ),
                    UserProfileField(
                      label: 'User Principal Name',
                      value: userData['userPrincipalName'],
                      icon: Icons.email,
                    ),
                    UserProfileField(
                      label: 'ID',
                      value: userData['id'],
                      icon: Icons.info,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        // Realiza el logout llamando al método correspondiente en AuthService
                        String logoutResult = await AuthService.logout();
                        if (logoutResult == "Account removed") {
                          // Si el logout tiene éxito, elimina el token y los datos del perfil del usuario
                          await ApiServiceHelper.deleteAllTokens();
                          // Redirige al usuario a la página de inicio
                          Navigator.pushReplacementNamed(context, '/login');
                        } else {
                          // Si hay un error en el logout, muestra un mensaje de error
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(logoutResult),
                            duration: const Duration(seconds: 3),
                          ));
                        }
                      },
                      child: const Text('Logout'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          // Realiza la llamada a la API para obtener la lista de tareas
                          final todoList =
                              await ApiService.fetchTodoList(context);
                          // Muestra la respuesta de la API en un widget de texto
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Lista de Tareas'),
                                content: Text(todoList
                                    .toString()), // Aquí se muestra la respuesta de la API
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cerrar'),
                                  ),
                                ],
                              );
                            },
                          );
                        } catch (e) {
                          if (kDebugMode) {
                            print('Error fetching todo list: $e');
                          }
                          // Manejar el error si no puede acceder a la API
                        }
                      },
                      child: const Text('Obtener Lista de Tareas'),
                    ),
                  ],
                ),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}

// Widget reutilizable para mostrar un campo del perfil de usuario
class UserProfileField extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const UserProfileField({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
