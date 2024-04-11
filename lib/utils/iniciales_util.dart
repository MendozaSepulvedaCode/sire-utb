String obtenerIniciales(String input) {
  List<String> palabras = input.split(' ');

  List<String> iniciales = palabras.map((palabra) {
    if (palabra.trim().isEmpty) {
      return '';
    }
    return palabra[0];
  }).toList();

  return iniciales.join('');
}
