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
      // Cargar el perfil del usuario solo si está vacío o si se actualiza explícitamente
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
}
