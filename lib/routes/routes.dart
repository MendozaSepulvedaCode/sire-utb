import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uloginazure/pages/admin/contactanos_settings.dart';
import 'package:uloginazure/pages/admin/event_page.dart';
import 'package:uloginazure/pages/admin/history_page.dart';
import 'package:uloginazure/pages/admin/home_page.dart';
import 'package:uloginazure/pages/admin/inital_route_page.dart';
import 'package:uloginazure/pages/admin/navigation_page.dart';
import 'package:uloginazure/pages/admin/profile_page.dart';
import 'package:uloginazure/pages/admin/settings_page.dart';
import 'package:uloginazure/pages/login/login_page.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    'initial': (context) => const InitialRoute(),
    'home': (context) => const HomePage(),
    'event': (context) => const EventPage(),
    'history': (context) => const HistoryPage(),
    'navigation': (context) => const NavigationPage(),
    'profile': (context) => const ProfilePage(),
    'settings': (context) => const SettingsPage(),
    'contacto': (context) => const ContactoPage(),
    'login': (context) => const LoginPage(),
  };
}
