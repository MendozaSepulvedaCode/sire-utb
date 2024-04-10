import 'dart:math';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:uloginazure/models/evento_model.dart';
import 'package:uloginazure/utils/colores_util.dart';
import 'package:uloginazure/utils/fechas_util.dart';
import 'package:uloginazure/widgets/lista_historial_widget.dart';
import 'package:uloginazure/widgets/tarjeta_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDay = DateTime.now();

  final _pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.5,
  );

  final _pageControllerList = PageController(
    initialPage: 0,
    viewportFraction: 0.2,
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: barColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            _colorFondoRedondeado(),
            Column(
              children: [
                const SizedBox(height: 10.0),
                _timelineCalendar(),
                const SizedBox(height: 10.0),
                _reservasContainer(context, listaEventos),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _appBar() {
    const estiloBienvenida = TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.bold, color: colorBeige);

    const estiloNombre = TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.bold, color: colorBlanco);

    return AppBar(
      backgroundColor: primaryColor,
      toolbarHeight: 60.0,
      leading: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: const CircleAvatar(
            backgroundImage: NetworkImage(
                "https://global.discourse-cdn.com/infiniteflight/original/4X/d/b/b/dbb59d269fb6cba4be04411e0eefa31a61c32cf4.jpeg"),
          ),
        ),
      ),
      title: const SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hola,",
              style: estiloBienvenida,
            ),
            Text(
              "Jose Mendoza",
              style: estiloNombre,
            )
          ],
        ),
      ),
      actions: [
        SafeArea(
          child: Container(
            margin: const EdgeInsets.only(right: 10.0),
            height: 40.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: colorBlanco,
            ),
            child: IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {},
                color: primaryColor),
          ),
        )
      ],
    );
  }

  _timelineCalendar() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: DatePicker(
        DateTime.now(),
        height: 90.0,
        initialSelectedDate: DateTime.now(),
        selectionColor: colorBlanco,
        selectedTextColor: primaryColor,
        dayTextStyle: const TextStyle(
            color: colorBlanco, fontSize: 11.0, fontWeight: FontWeight.bold),
        monthTextStyle: const TextStyle(
            color: colorBlanco, fontSize: 11.0, fontWeight: FontWeight.bold),
        dateTextStyle: const TextStyle(
            color: colorBlanco, fontSize: 24.0, fontWeight: FontWeight.bold),
        locale: 'es_Es',
        onDateChange: (date) {
          setState(() {
            _selectedDay = date;
          });
        },
      ),
    );
  }

  _reservasContainer(BuildContext context, List<Evento> listaEvento) {
    String dayNow = getDay(_selectedDay);
    const tamanoDia = TextStyle(
        fontSize: 15.0, fontWeight: FontWeight.bold, color: colorLetras);

    const tamanoInkWell = TextStyle(
        fontSize: 12.0, fontWeight: FontWeight.normal, color: primaryColor);

    return Container(
      margin: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Pendientes ${dayNow.toString()}",
                style: tamanoDia,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
                color: colorLetras,
                iconSize: 22.0,
              ),
            ],
          ),
          const SizedBox(height: 5.0),
          _infoReservas(context),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Historial ",
                style: tamanoDia,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'history',
                      arguments: listaEvento);
                },
                child: const Text(
                  "Ver todos",
                  style: tamanoInkWell,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          _listaHistorial(context),
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
        itemCount: listaEventos.length,
        itemBuilder: (BuildContext context, index) {
          return _eventoTarjeta(context, listaEventos[index]);
        },
        physics: const BouncingScrollPhysics(),
        padEnds: false,
      ),
    );
  }

  _eventoTarjeta(BuildContext context, Evento listaEvento) {
    return GestureDetector(
      child: TarjetaEvento(listaEvento: listaEvento),
      onTap: () {
        Navigator.pushNamed(context, 'event', arguments: listaEvento);
      },
    );
  }

  _listaHistorial(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 350.0,
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: _pageControllerList,
        itemCount: min(8, listaEventos.length),
        itemBuilder: (BuildContext context, index) {
          if (index >= 0 && index < listaEventos.length) {
            return Dismissible(
              key: ValueKey<int>(listaEventos[index].id),
              background: Container(
                color: colorRojo,
                child: const Icon(
                  Icons.delete,
                  color: colorBlanco,
                ),
              ),
              onDismissed: (direction) {
                setState(() {
                  listaEventos.removeAt(index);
                });
              },
              child: _listaEventoHistorial(context, listaEventos[index]),
            );
          } else {
            return Container();
          }
        },
        padEnds: false,
      ),
    );
  }

  _listaEventoHistorial(BuildContext context, Evento listaEvento) {
    return GestureDetector(
      child: SizedBox(
        child: ListaHistorial(listaEvento: listaEvento),
      ),
      onTap: () {
        Navigator.pushNamed(context, 'history', arguments: listaEvento);
      },
    );
  }

  _colorFondoRedondeado() {
    return Positioned(
      top: -5,
      left: 0,
      right: 0,
      child: Container(
        width: double.infinity,
        height: 140.0,
        decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
      ),
    );
  }
}
