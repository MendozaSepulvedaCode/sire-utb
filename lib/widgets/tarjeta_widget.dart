import 'package:flutter/material.dart';
import 'package:uloginazure/models/evento_model.dart';
import 'package:uloginazure/utils/colores_util.dart';

class TarjetaEvento extends StatelessWidget {
  const TarjetaEvento({super.key, required this.listaEvento});

  final Evento listaEvento;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.only(right: 10.0),
      width: double.infinity,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              width: 150.0,
              decoration: const BoxDecoration(
                color: colorBlanco,
                boxShadow: [
                  BoxShadow(
                    color: Colors.red,
                    blurRadius: 4,
                    offset: Offset(10.0, 2.5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 30.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: cardColor,
                        ),
                        child: IconButton(
                          icon: Icon(listaEvento.icono),
                          onPressed: () {},
                          iconSize: 15.0,
                          color: colorLetras,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        listaEvento.aula,
                        style: const TextStyle(fontSize: 12.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7.0),
                  Text(
                      "${listaEvento.horaInicio.hour} am - ${listaEvento.horaFin.hour} pm"),
                  const SizedBox(height: 7.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Container(
                      height: 21.5,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      color: colorAmarillo,
                      child: const Center(
                        child: Text(
                          "Pronto a iniciar",
                          style: TextStyle(
                            fontSize: 10.0,
                            color: colorBlanco,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 7.0),
                  Text(
                    listaEvento.nombrePersona,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
