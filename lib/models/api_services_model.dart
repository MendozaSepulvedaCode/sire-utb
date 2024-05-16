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
          ['api://f928ab89-bd59-4400-8477-829e0cf9cc59/reservas.acceso'],
          context);

      // Obtener el perfil del usuario desde la API
      final response = await http.get(
        Uri.parse('https://sire-utb-x2ifq.ondigitalocean.app/form/materia'),
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

  static Future<List<T>> fetchTodoList<T>(
    BuildContext context, {
    required String url,
    required String method,
    Map<String, dynamic>? body,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      String token = await ApiServiceHelper.getValidToken(
        "todoListToken",
        ['api://f928ab89-bd59-4400-8477-829e0cf9cc59/reservas.acceso'],
        context,
      );

      late http.Response response;
      if (method.toLowerCase() == 'post') {
        if (body == null) {
          throw ArgumentError('Body must not be null for POST method');
        }
        response = await http.post(
          Uri.parse(url),
          headers: {'Authorization': 'Bearer $token'},
          body: json.encode(body),
        );
      } else {
        response = await http.get(
          Uri.parse(url),
          headers: {'Authorization': 'Bearer $token'},
        );
      }

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        log(response.body);
        List<T> items = [];
        for (var json in jsonList) {
          items.add(fromJson(json));
        }
        return items;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
