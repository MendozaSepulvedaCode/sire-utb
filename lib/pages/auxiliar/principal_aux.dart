import 'package:flutter/material.dart';
import 'package:uloginazure/providers/user_info_provider.dart';
import 'package:uloginazure/utils/colores_util.dart';
import 'package:uloginazure/widgets/principal_appbar_widget.dart';

class PrincipalAux extends StatefulWidget {
  const PrincipalAux({super.key});

  @override
  State<PrincipalAux> createState() => _PrincipalAuxState();
}

class _PrincipalAuxState extends State<PrincipalAux> {
  final UserProfileProvider _userProfileProvider = UserProfileProvider.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: barColor,
      appBar: AppbarPrincipal(
        userData: _userProfileProvider.decodedToken,
      ),
      body: const Center(
        child: Text("Auxiliar"),
      ),
    );
  }
}
