import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:uloginazure/models/api_services_model.dart';
import 'package:uloginazure/models/profesor_model.dart';

class ProfesorProvider {
  bool _isLoading = false;
  final List<Profesor> _profesores = [];
  final StreamController<List<Profesor>> _profesoresStreamController =
      StreamController<List<Profesor>>.broadcast();

  void dispose() {
    _profesoresStreamController.close();
  }

  Function(List<Profesor>) get profesoresSink =>
      _profesoresStreamController.sink.add;

  Stream<List<Profesor>> get profesoresStream =>
      _profesoresStreamController.stream;

  Future<List<Profesor>> getReservasAprobar(BuildContext context) async {
    if (_isLoading) return [];

    _isLoading = true;

    try {
      final todoList = await ApiService.fetchTodoList<Profesor>(
        context,
        url: 'https://coral-app-up4fv.ondigitalocean.app/profe/reserva_profe',
        method: 'get',
        fromJson: (json) => Profesor.fromJson(json),
      );

      _profesores.addAll(todoList);
      profesoresSink(_profesores);
      notifyListeners();
      _isLoading = false;
      return _profesores;
    } catch (e) {
      _isLoading = false;
      log('Error fetching todo list: $e');
      return [];
    }
  }

  void notifyListeners() {
    _profesoresStreamController.add(_profesores);
  }
}
