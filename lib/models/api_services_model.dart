import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:uloginazure/utils/helpers.dart';
import 'auth_storage_model.dart';

class ApiService {
  static Future<Map<String, dynamic>> fetchUserProfile(
      BuildContext context) async {
    try {
      String token = await ApiServiceHelper.getValidToken(
          'GraphToken',
          [
            "https://graph.microsoft.com/User.Read",
            "https://graph.microsoft.com/User.Read.All"
          ],
          context);

      // Obtener el perfil del usuario desde la API
      final response = await http.get(
        Uri.parse('https://graph.microsoft.com/v1.0/me'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> userProfile = json.decode(response.body);
        // Guardar los datos del perfil en el almacenamiento local
        await AuthStorage.saveUserProfile(userProfile);
        return userProfile;
      } else {
        throw Exception('Failed to fetch user profile');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<Map<String, dynamic>> fetchTodoList(
      BuildContext context) async {
    try {
      String token = await ApiServiceHelper.getValidToken(
          "todoListToken",
          [
            "api://cc30dbee-cc7a-421e-845c-80c1ee92db0b/Todolist.ReadWrite",
            "api://cc30dbee-cc7a-421e-845c-80c1ee92db0b/Todolist.Read",
          ],
          context);

      final response = await http.get(
        Uri.parse('http://192.168.1.13:5000/api/todolist'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        log("Failed to fetch todo list");
        throw Exception('Failed to fetch todo list');
      }
    } catch (e) {
      log('Error: $e');
      throw Exception('Error: $e');
    }
  }
}
