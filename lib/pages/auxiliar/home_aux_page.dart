import 'package:flutter/material.dart';

class HomeAux extends StatelessWidget {
  const HomeAux({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("Aux Page"),
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
