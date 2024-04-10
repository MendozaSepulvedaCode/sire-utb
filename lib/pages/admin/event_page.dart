import 'package:flutter/material.dart';
import 'package:uloginazure/models/evento_model.dart';
import 'package:uloginazure/utils/colores_util.dart';
import 'package:uloginazure/utils/fechas_util.dart';
import 'package:uloginazure/widgets/input_widget.dart';

class EventPage extends StatelessWidget {
  const EventPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Evento evento = ModalRoute.of(context)?.settings.arguments as Evento;
    return Scaffold(
      backgroundColor: barColor,
      appBar: _appBarEvent(context, evento),
      body: _containerInfoEvent(evento),
    );
  }

  _appBarEvent(BuildContext context, Evento evento) {
    const estiloTitleEvent = TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: colorLetras,
        overflow: TextOverflow.ellipsis);
    return AppBar(
      title: Text(
        "Reserva #${evento.id - 1}",
        style: estiloTitleEvent,
        overflow: TextOverflow.ellipsis,
      ),
      backgroundColor: barColor,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        iconSize: 20.0,
        color: colorLetras,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  _containerInfoEvent(Evento evento) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            _camposReserva(evento),
            _campoDescripcion(evento),
            _campoHorario(evento),
            _botonesAccion(),
          ],
        ),
      ),
    );
  }

  _camposReserva(Evento evento) {
    return Column(
      children: [
        InputLabel(contenidoCampo: evento.nombrePersona, label: "Nombre"),
        InputLabel(
            contenidoCampo:
                "${getDay(evento.fechaReserva)}, ${evento.fechaReserva.day.toString()} de ${getMonth(evento.fechaReserva)}, ${evento.fechaReserva.year.toString()}",
            label: "Fecha"),
        InputLabel(contenidoCampo: evento.aula, label: "Aula"),
      ],
    );
  }

  _campoDescripcion(Evento evento) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Asunto de la reserva",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold, color: colorLetras),
        ),
        const SizedBox(height: 7.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: colorBlanco,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: TextFormField(
            initialValue: evento.descripcionEvento,
            maxLines: null,
            enabled: false,
            style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.normal,
                color: colorLetras),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              isDense: true,
            ),
          ),
        ),
        const SizedBox(height: 15.0),
      ],
    );
  }

  _campoHorario(Evento evento) {
    const estiloHoras =
        TextStyle(fontWeight: FontWeight.bold, color: colorLetras);
    return SizedBox(
      width: double.infinity,
      height: 100.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Hora inicio",
                style: estiloHoras,
              ),
              SizedBox(width: 80.0),
              Text(
                "Hora final",
                style: estiloHoras,
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 12.0),
                    hintText: evento.horaInicio.hour.toString(),
                    filled: true,
                    fillColor: colorBlanco,
                    hintStyle: const TextStyle(
                        color: colorLetras,
                        fontWeight: FontWeight.normal,
                        fontSize: 15.0),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 12.0),
                    hintText: evento.horaFin.hour.toString(),
                    filled: true,
                    fillColor: colorBlanco,
                    hintStyle: const TextStyle(
                        color: colorLetras,
                        fontWeight: FontWeight.normal,
                        fontSize: 15.0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _botonesAccion() {
    const estiloLetras = TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.w500, color: colorBlanco);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
          ),
          child: const Text(
            "Confirmar",
            style: estiloLetras,
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: colorRojo,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
          ),
          child: const Text(
            "Rechazar",
            style: estiloLetras,
          ),
        ),
      ],
    );
  }
}
