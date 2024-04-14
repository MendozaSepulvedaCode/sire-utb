import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uloginazure/models/api_services_model.dart';

class UserProfileProvider with ChangeNotifier {
  static final UserProfileProvider _singleton = UserProfileProvider._internal();

  factory UserProfileProvider() {
    return _singleton;
  }

  UserProfileProvider._internal();

  static UserProfileProvider get instance => _singleton;

  Map<String, dynamic> _userData = {};

  Map<String, dynamic> get userData => _userData;

  Future<void> loadUserProfile(BuildContext context) async {
    try {
      if (_userData.isEmpty) {
        _userData = await ApiService.fetchUserProfile(context);
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user profile: $e');
      }
    }
  }

  // Método para limpiar los datos del usuario (llamado al cerrar sesión)
  void clearUserProfile() {
    _userData.clear();
    notifyListeners();
  }

  String getPageName() {
    String jobTitle = _userData['jobTitle'] ?? '';
    if (jobTitle.contains('Administrador')) {
      return 'Administrador';
    } else if (jobTitle.contains('Aux_Administrativo')) {
      return 'Auxiliar';
    } else if (jobTitle.contains('Profesor')) {
      return 'Profesor';
    } else if (jobTitle.contains('Estudiante')) {
      return 'Estudiante';
    } else {
      return 'Desconocido';
    }
  }

  String get displayName => _userData['displayName'] ?? '';
  String get givenName => _userData['givenName'] ?? '';
  String get surname => _userData['surname'] ?? '';
  String get userPrincipalName => _userData['userPrincipalName'] ?? '';
  String get id => _userData['id'] ?? '';
}
