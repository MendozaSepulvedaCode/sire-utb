import 'package:flutter/material.dart';

class HomePrf extends StatelessWidget {
  const HomePrf({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("Teacher Page"),
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
