import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uloginazure/models/auxiliar_model.dart';
import 'package:uloginazure/utils/colores_util.dart';

class AsignarAux extends StatelessWidget {
  const AsignarAux({super.key});

  @override
  Widget build(BuildContext context) {
    final Auxiliar auxiliar =
        ModalRoute.of(context)?.settings.arguments as Auxiliar;

    return Scaffold(
      backgroundColor: barColor,
      appBar: AppBar(
        backgroundColor: barColor,
        centerTitle: true,
        title: const Text(
          "Perfil",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Row(children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            iconSize: 20.0,
            color: colorLetras,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ]),
      ),
      body: _containerAuxAssign(context, auxiliar),
    );
  }

  _containerAuxAssign(BuildContext context, Auxiliar auxiliar) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.85,
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _profileContent(context, auxiliar),
            _asignarAux(context, auxiliar),
            _botonAsignar(),
          ],
        ),
      ),
    );
  }

  _profileContent(BuildContext context, Auxiliar auxiliar) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.28,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 100.0,
            child: Image.network(auxiliar.fotoPerfil),
          ),
          Text(
            auxiliar.nombreAux,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: colorLetras,
              fontSize: 16.0,
            ),
          ),
          const Text(
            "Auxiliar",
            style: TextStyle(color: primaryColor),
          ),
          const Divider(
            height: 1.0,
            color: colorGris,
          ),
        ],
      ),
    );
  }

  _asignarAux(BuildContext context, Auxiliar auxiliar) {
    const estiloNumeros = TextStyle(
        fontSize: 15.0, fontWeight: FontWeight.bold, color: colorLetras);
    const estiloLetras = TextStyle(
        fontSize: 12.0, fontWeight: FontWeight.normal, color: colorGris);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.43,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 1,
            height: 50.0,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "3",
                      style: estiloNumeros,
                    ),
                    Text(
                      "Bloques",
                      style: estiloLetras,
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "40",
                      style: estiloNumeros,
                    ),
                    Text(
                      "Asignaciones",
                      style: estiloLetras,
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "27.5",
                      style: estiloNumeros,
                    ),
                    Text(
                      "Horas",
                      style: estiloLetras,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _botonAsignar() {
    const estiloLetras = TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.w500, color: colorBlanco);
    return Center(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
        ),
        child: const Text(
          "Asignar",
          style: estiloLetras,
        ),
      ),
    );
  }
}
