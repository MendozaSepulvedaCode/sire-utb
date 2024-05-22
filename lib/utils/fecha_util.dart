String parseDateTime(DateTime dateTime) {
  try {
    if (dateTime.toIso8601String().endsWith("000Z")) {
      final meses = [
        'Enero',
        'Febrero',
        'Marzo',
        'Abril',
        'Mayo',
        'Junio',
        'Julio',
        'Agosto',
        'Septiembre',
        'Octubre',
        'Noviembre',
        'Diciembre'
      ];

      final mesIndex = dateTime.month - 1;
      final diaMes = dateTime.day;

      final horaString = dateTime.toIso8601String().substring(11, 16);

      return "$diaMes de ${meses[mesIndex]} - $horaString";
    } else {
      return dateTime.toIso8601String();
    }
  } catch (e) {
    return dateTime.toIso8601String();
  }
}

String extractTextAfterED(String input) {
  int index = input.indexOf("ED");
  if (index == -1) {
    index = input.indexOf("EDMB");
    if (index != -1) {
      return input.substring(index + 4);
    }
  } else {
    return input.substring(index + 2);
  }
  return "";
}
