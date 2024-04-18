import 'package:flutter/material.dart';
import 'package:uloginazure/pages/admin/settings_page.dart';
import 'package:uloginazure/pages/auxiliar/principal_aux.dart';
import 'package:uloginazure/utils/colores_util.dart';

class HomeAux extends StatefulWidget {
  const HomeAux({super.key});

  @override
  State<HomeAux> createState() => _HomeAuxState();
}

class _HomeAuxState extends State<HomeAux> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: barColor,
      body: _cargarPage(currentIndex),
      bottomNavigationBar: _bottomNavigationbar(),
    );
  }

  _cargarPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return const PrincipalAux();
      case 1:
        return const SettingsPage();

      default:
        return const PrincipalAux();
    }
  }

  _bottomNavigationbar() {
    double alto = MediaQuery.of(context).size.height;
    double ancho = MediaQuery.of(context).size.width;
    return SizedBox(
      height: alto * 0.07,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          _iconosNavigation(Icons.home),
          _iconosNavigation(Icons.settings),
        ],
        selectedIconTheme: IconThemeData(
          size: ancho * 0.08,
        ),
        unselectedIconTheme: IconThemeData(size: ancho * 0.08),
      ),
    );
  }

  _iconosNavigation(IconData icono) {
    return BottomNavigationBarItem(
      icon: SizedBox(
        height: 6.0,
        child: Icon(icono),
      ),
      label: '',
    );
  }
}
