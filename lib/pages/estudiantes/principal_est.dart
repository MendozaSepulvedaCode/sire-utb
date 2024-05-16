import 'package:flutter/material.dart';
import 'package:uloginazure/models/evento_model.dart';
import 'package:uloginazure/providers/user_info_provider.dart';
import 'package:uloginazure/utils/colores_util.dart';
import 'package:uloginazure/widgets/principal_appbar_widget.dart';
import 'package:uloginazure/widgets/steps_widget.dart';

class PrincipalEst extends StatefulWidget {
  const PrincipalEst({super.key});

  @override
  State<PrincipalEst> createState() => _PrincipalEstState();
}

class _PrincipalEstState extends State<PrincipalEst> {
  final UserProfileProvider _userProfileProvider = UserProfileProvider.instance;

  final List<Evento> listaEventos = List.generate(10, (index) {
    return Evento(
      id: index + 1,
      icono: Icons.event,
      aula: 'A2 - 502',
      horaInicio: DateTime(2024, 04, 06, 11, 30),
      horaFin: DateTime(2024, 04, 06, 12, 30),
      nombrePersona: "Jose Mendoza $index",
      descripcionEvento:
          "Quiero reservar este salon para estudiar calculo Quiero reservar este salon para estudiar calculo Quiero reservar este salon para estudiar calculo Quiero reservar este salon para estudiar calculo ",
      fechaReserva: DateTime(2024, 04, 06, 12, 30),
    );
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: barColor,
      appBar: AppbarPrincipal(
        userData: _userProfileProvider.decodedToken,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _containerEstudiantesReservas(),
          ],
        ),
      ),
    );
  }

  _containerEstudiantesReservas() {
    return Container(
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.only(top: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Mis reservas",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: colorLetras,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          _reservasPendientes(),
        ],
      ),
    );
  }

  _reservasPendientes() {
    return Column(
      children: listaEventos.map((evento) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: Steps(evento),
        );
      }).toList(),
    );
  }
}
