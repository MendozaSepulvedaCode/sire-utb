import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uloginazure/utils/colores_util.dart';

class InitialRoute extends StatelessWidget {
  const InitialRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _fondoApp(),
          _contentApp(context),
        ],
      ),
    );
  }

  _fondoApp() {
    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: FractionalOffset(0.0, 0.2),
            end: FractionalOffset(0.0, 1.0),
            colors: [
              primaryColor,
              colorVerde,
            ]),
      ),
    );

    final cajaRosa = Positioned(
      top: -50,
      left: -10,
      child: Transform.rotate(
        angle: -pi / 4.0,
        child: Container(
          height: 240.0,
          width: 240.0,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [
              primaryColor,
              colorVerde,
            ]),
            borderRadius: BorderRadius.circular(120.0),
          ),
        ),
      ),
    );

    return Stack(
      children: [
        gradiente,
        cajaRosa,
      ],
    );
  }

  _contentApp(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "navigation");
            },
            child: const Text("Iniciar"),
          ),
        ),
      ],
    );
  }
}
