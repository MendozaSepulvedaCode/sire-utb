import 'package:flutter/material.dart';
import 'package:uloginazure/providers/user_info_provider.dart';
import 'package:uloginazure/utils/colores_util.dart';
import 'package:uloginazure/widgets/principal_appbar_widget.dart';

class PrincipalEst extends StatefulWidget {
  const PrincipalEst({super.key});

  @override
  State<PrincipalEst> createState() => _PrincipalEstState();
}

class _PrincipalEstState extends State<PrincipalEst> {
  final UserProfileProvider _userProfileProvider = UserProfileProvider.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: barColor,
      appBar: AppbarPrincipal(
        userData: _userProfileProvider.userData,
      ),
      body: const Center(
        child: Text("Principal"),
      ),
    );
  }
}
