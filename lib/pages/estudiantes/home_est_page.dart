import 'package:flutter/material.dart';

class HomeEst extends StatelessWidget {
  const HomeEst({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("Student Page"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, "settings");
        },
        child: const Icon(Icons.door_front_door_outlined),
      ),
    );
  }
}
