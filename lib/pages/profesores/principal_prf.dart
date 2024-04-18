import 'package:flutter/material.dart';
import 'package:uloginazure/providers/user_info_provider.dart';
import 'package:uloginazure/utils/colores_util.dart';
import 'package:uloginazure/widgets/principal_appbar_widget.dart';

class PrincipalPrf extends StatefulWidget {
  const PrincipalPrf({super.key});

  @override
  State<PrincipalPrf> createState() => _PrincipalPrfState();
}

class _PrincipalPrfState extends State<PrincipalPrf> {
  final UserProfileProvider _userProfileProvider = UserProfileProvider.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: barColor,
      appBar: AppbarPrincipal(
        userData: _userProfileProvider.userData,
      ),
      body: const Center(
        child: Text("Profesor"),
      ),
    );
  }
}
