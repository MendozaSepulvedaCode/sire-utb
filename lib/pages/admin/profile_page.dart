import 'package:flutter/material.dart';
import 'package:uloginazure/models/auxiliar_model.dart';
import 'package:uloginazure/utils/colores_util.dart';
import 'package:uloginazure/widgets/appbar_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<Auxiliar> listaAuxiliares = List.generate(10, (index) {
    return Auxiliar(
        id: 1,
        fotoPerfil:
            "https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-PNG-Image-File.png",
        nombreAux: "Jose Miguel Mendoza Sepulveda",
        estado: 1);
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(textoAppBar: "Asignar"),
      backgroundColor: barColor,
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            _searchTextField(),
            const SizedBox(height: 20.0),
            Expanded(
              child: _auxiliarItem(listaAuxiliares),
            ),
          ],
        ),
      ),
    );
  }

  _searchTextField() {
    return TextField(
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(5.0),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 11.0, horizontal: 22.0),
        hintText: "Buscar",
        filled: true,
        fillColor: grisTonoOscuro,
        hintStyle: const TextStyle(
          color: colorGris,
          fontWeight: FontWeight.bold,
          fontSize: 15.0,
        ),
        suffixIcon: const Icon(
          Icons.search,
          color: colorGris,
        ),
      ),
    );
  }

  _auxiliarItem(List<Auxiliar> listaAuxiliares) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: listaAuxiliares.length,
      itemBuilder: (BuildContext context, int index) {
        final auxiliar = listaAuxiliares[index];
        late Color colorEstado;
        late String textoEstado;
        if (auxiliar.estado == 0) {
          colorEstado = colorAmarillo;
          textoEstado = "Pendiente";
        } else {
          colorEstado = primaryColor;
          textoEstado = "Completado";
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0),
            Row(
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
            ),
            const SizedBox(height: 10.0),
            const Divider(height: 2.0),
          ],
        );
      },
    );
  }
}
