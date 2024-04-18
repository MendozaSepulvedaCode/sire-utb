import 'package:flutter/material.dart';
import 'package:uloginazure/models/auxiliar_model.dart';
import 'package:uloginazure/utils/colores_util.dart';

class ProfileAux extends StatelessWidget {
  const ProfileAux({super.key, required this.auxiliar});

  final Auxiliar auxiliar;

  @override
  Widget build(BuildContext context) {
    late Color colorEstado;
    late String textoEstado;
    if (auxiliar.estado == 0) {
      colorEstado = colorAmarillo;
      textoEstado = "Pendiente";
    } else {
      colorEstado = primaryColor;
      textoEstado = "Completado";
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: Image.network(
                  auxiliar.fotoPerfil,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 180.0,
                  child: Text(
                    auxiliar.nombreAux,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 3.0),
                Text(
                  textoEstado,
                  style: TextStyle(
                    color: colorEstado,
                    fontSize: 12.0,
                  ),
                )
              ],
            ),
          ],
        ),
        const Icon(
          Icons.arrow_forward_ios,
          size: 17.0,
        )
      ],
    );
  }
}
