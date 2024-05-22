import 'package:flutter/material.dart';
import 'package:uloginazure/models/auxiliar_model.dart';
import 'package:uloginazure/utils/colores_util.dart';
import 'package:uloginazure/utils/fechas_util.dart';

class AsignarAux extends StatefulWidget {
  const AsignarAux({super.key});

  @override
  State<AsignarAux> createState() => _AsignarAuxState();
}

class _AsignarAuxState extends State<AsignarAux> {
  DateTime _diaSeleccionado = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  final List<String> _blockOptions = [
    'Bloque 1',
    'Bloque 2',
    'Bloque 3',
  ];

  String _selectedBlock = 'Bloque 1';
  @override
  Widget build(BuildContext context) {
    final Auxiliar auxiliar =
        ModalRoute.of(context)?.settings.arguments as Auxiliar;

    return Scaffold(
      backgroundColor: barColor,
      appBar: AppBar(
        backgroundColor: barColor,
        centerTitle: true,
        title: const Text(
          "Perfil",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Row(children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            iconSize: 20.0,
            color: colorLetras,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ]),
      ),
      body: _containerAuxAssign(context, auxiliar),
    );
  }

  _containerAuxAssign(BuildContext context, Auxiliar auxiliar) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.85,
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _profileContent(context, auxiliar),
            _infoAux(context, auxiliar),
            _asignarAux(context, auxiliar),
            _botonAsignar(),
          ],
        ),
      ),
    );
  }

  _profileContent(BuildContext context, Auxiliar auxiliar) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.28,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 100.0,
            child: Image.network(auxiliar.fotoPerfil),
          ),
          Text(
            auxiliar.nombreAux,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: colorLetras,
              fontSize: 16.0,
            ),
          ),
          const Text(
            "Auxiliar",
            style: TextStyle(color: primaryColor),
          ),
          const Divider(
            height: 1.0,
            color: colorGris,
          ),
        ],
      ),
    );
  }

  _infoAux(BuildContext context, Auxiliar auxiliar) {
    const estiloNumeros = TextStyle(
        fontSize: 15.0, fontWeight: FontWeight.bold, color: colorLetras);
    const estiloLetras = TextStyle(
        fontSize: 12.0, fontWeight: FontWeight.normal, color: colorGris);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 1,
            height: 50.0,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "3",
                      style: estiloNumeros,
                    ),
                    Text(
                      "Bloques",
                      style: estiloLetras,
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "40",
                      style: estiloNumeros,
                    ),
                    Text(
                      "Asignaciones",
                      style: estiloLetras,
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "27.5",
                      style: estiloNumeros,
                    ),
                    Text(
                      "Horas",
                      style: estiloLetras,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _asignarAux(BuildContext context, Auxiliar auxiliar) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.33,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: primaryColor),
                child: GestureDetector(
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _diaSeleccionado,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(DateTime.now().year + 1),
                    );
                    if (pickedDate != null && pickedDate != _diaSeleccionado) {
                      setState(() {
                        _diaSeleccionado = pickedDate;
                      });
                    }
                  },
                  child: SizedBox(
                    width: 80.0,
                    child: Text(
                      getDay(_diaSeleccionado),
                      style: const TextStyle(color: colorBlanco),
                    ),
                  ),
                ),
              ),
              const Text(
                'Día',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: primaryColor,
                ),
                child: DropdownButton(
                  value: _selectedBlock,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedBlock = newValue!;
                    });
                  },
                  items: _blockOptions
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(color: colorBlanco),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Bloque:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _botonAsignar() {
    const estiloLetras = TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.w500, color: colorBlanco);
    return Center(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
        ),
        child: const Text(
          "Asignar",
          style: estiloLetras,
        ),
      ),
    );
  }
}
