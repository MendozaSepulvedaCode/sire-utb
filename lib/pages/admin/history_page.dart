import 'package:flutter/material.dart';
import 'package:uloginazure/models/evento_model.dart';
import 'package:uloginazure/utils/colores_util.dart';
import 'package:uloginazure/widgets/lista_historial_widget.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    final List<Evento> evento =
        ModalRoute.of(context)?.settings.arguments as List<Evento>;
    return Scaffold(
      backgroundColor: barColor,
      appBar: _appBarEvent(context, evento),
      body: _listaEventos(evento),
    );
  }

  _appBarEvent(BuildContext context, List<Evento> evento) {
    const estiloTitleEvent = TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: colorLetras,
        overflow: TextOverflow.ellipsis);
    return AppBar(
      title: const Text(
        "Historial de reservas",
        style: estiloTitleEvent,
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

  _listaEventos(List<Evento> evento) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: evento.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: ValueKey(evento[index].id.toString()),
            background: Container(
              color: colorRojo,
              child: const Icon(
                Icons.delete,
                color: colorBlanco,
              ),
            ),
            onDismissed: (direction) {
              _eliminarEvento(index, evento);
            },
            child: ListaHistorial(listaEvento: evento[index]),
          );
        },
      ),
    );
  }

  void _eliminarEvento(int index, List<Evento> evento) {
    setState(() {
      evento.removeAt(index);
    });
  }
}
