import 'package:flutter/material.dart';
import 'package:uloginazure/models/auxiliar_model.dart';
import 'package:uloginazure/utils/colores_util.dart';
import 'package:uloginazure/widgets/appbar_widget.dart';
import 'package:uloginazure/widgets/aux_profile_widget.dart';

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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0),
            GestureDetector(
              child: ProfileAux(
                auxiliar: auxiliar,
              ),
              onTap: () {
                Navigator.pushNamed(context, 'aux-assign', arguments: auxiliar);
              },
            ),
            const SizedBox(height: 10.0),
            const Divider(height: 2.0),
          ],
        );
      },
    );
  }
}
