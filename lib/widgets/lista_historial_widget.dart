import 'package:flutter/material.dart';
import 'package:uloginazure/models/evento_model.dart';
import 'package:uloginazure/utils/colores_util.dart';

class ListaHistorial extends StatelessWidget {
  const ListaHistorial({super.key, required this.listaEvento});

  final Evento listaEvento;

  @override
  Widget build(BuildContext context) {
    const textStyleTitle = TextStyle(
      fontSize: 13.0,
      fontWeight: FontWeight.bold,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          listaEvento.nombrePersona,
          style: textStyleTitle,
        ),
        Text(
          listaEvento.aula,
          style: const TextStyle(fontSize: 11.0),
        ),
        const SizedBox(height: 5.0),
        const Divider(
          height: 2.0,
          color: colorGris,
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
