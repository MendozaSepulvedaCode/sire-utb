class Profesor {
  final String idReserva;
  final String aula;
  final String estado;
  final int tipoReserva;
  final String motivo;
  final String estudiante;
  final String materia;

  Profesor({
    required this.idReserva,
    required this.aula,
    required this.estado,
    required this.tipoReserva,
    required this.motivo,
    required this.estudiante,
    required this.materia,
  });

  factory Profesor.fromJson(Map<String, dynamic> json) {
    return Profesor(
      idReserva: json['ID_Reserva'],
      aula: json['Aula'],
      estado: json['Estado'],
      tipoReserva: json['Tipo de reserva'],
      motivo: json['Motivo'],
      estudiante: json['Estudiante'],
      materia: json['Materia'],
    );
  }
}
