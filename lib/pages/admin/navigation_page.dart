import 'package:flutter/material.dart';
import 'package:uloginazure/pages/admin/home_page.dart';
import 'package:uloginazure/pages/admin/profile_page.dart';
import 'package:uloginazure/pages/admin/settings_page.dart';
import 'package:uloginazure/utils/colores_util.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
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
        return const HomePage();
      case 1:
        return const ProfilePage();
      case 2:
        return const SettingsPage();

      default:
        return const HomePage();
    }
  }

  _bottomNavigationbar() {
    return SizedBox(
      height: 41.0,
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
          _iconosNavigation(Icons.person),
          _iconosNavigation(Icons.settings),
        ],
        selectedIconTheme: const IconThemeData(
          size: 24.0,
        ),
        unselectedIconTheme: const IconThemeData(size: 24.0),
      ),
    );
  }

  _iconosNavigation(IconData icono) {
    return BottomNavigationBarItem(
        icon: SizedBox(
          height: 6.0,
          child: Icon(icono),
        ),
        label: '');
  }
}
