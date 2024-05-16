import 'package:flutter/material.dart';
import 'package:uloginazure/models/api_services_model.dart';
import 'package:uloginazure/models/evento_model.dart';
import 'package:uloginazure/models/profesor_model.dart';
import 'package:uloginazure/providers/user_info_provider.dart';
import 'package:uloginazure/utils/colores_util.dart';
import 'package:uloginazure/widgets/principal_appbar_widget.dart';
import 'package:uloginazure/widgets/steps_widget.dart';
import 'package:uloginazure/widgets/tarjeta_profesor_widget.dart';

class PrincipalPrf extends StatefulWidget {
  const PrincipalPrf({super.key});

  @override
  State<PrincipalPrf> createState() => _PrincipalPrfState();
}

class _PrincipalPrfState extends State<PrincipalPrf> {
  List<Profesor> _listaProfesores = [];
  bool _isLoading = true;

  final UserProfileProvider _userProfileProvider = UserProfileProvider.instance;

  final _pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.5,
  );

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
  void initState() {
    super.initState();
    _fetchTodoList();
  }

  Future<void> _fetchTodoList() async {
    try {
      final todoList = await ApiService.fetchTodoList<Profesor>(
        context,
        url: 'https://coral-app-up4fv.ondigitalocean.app/profe/reserva_profe',
        method: 'get',
        fromJson: (json) => Profesor.fromJson(json),
      );

      setState(() {
        _listaProfesores = todoList;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching todo list: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

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
            _containerReservas(context),
          ],
        ),
      ),
    );
  }

  _containerReservas(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.only(top: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Aprobar estudiantes",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: colorLetras,
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          _isLoading
              ? const CircularProgressIndicator()
              : _infoReservas(context),
          const SizedBox(
            height: 15.0,
          ),
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

  _infoReservas(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height * 0.21,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _listaProfesores.length,
        itemBuilder: (BuildContext context, index) {
          return _eventoTarjeta(context, _listaProfesores[index]);
        },
        physics: const BouncingScrollPhysics(),
        padEnds: false,
      ),
    );
  }

  _eventoTarjeta(BuildContext context, Profesor profesor) {
    return GestureDetector(
      child: TarjetaProfesor(profesor: profesor),
      onTap: () {
        Navigator.pushNamed(context, 'event', arguments: profesor);
      },
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
