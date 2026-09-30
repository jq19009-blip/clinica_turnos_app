/// Formatea una fecha como "Lunes 25 de agosto".
String formatearFechaCorta(DateTime fecha) {
  const dias = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'];
  const meses = [
    'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
    'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre',
  ];
  return '${dias[fecha.weekday - 1]} ${fecha.day} de ${meses[fecha.month - 1]}';
}

/// Formatea una fecha como "Domingo 24 de agosto de 2026".
String formatearFechaLarga(DateTime fecha) {
  const dias = ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'];
  const meses = [
    'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
    'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre',
  ];
  return '${dias[fecha.weekday % 7]} ${fecha.day} de ${meses[fecha.month - 1]} de ${fecha.year}';
}

/// Formatea una fecha como "Mié 25 sep" (corta para listas).
String formatearFechaMuyCorta(DateTime fecha) {
  const dias = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
  const meses = [
    'ene', 'feb', 'mar', 'abr', 'may', 'jun',
    'jul', 'ago', 'sep', 'oct', 'nov', 'dic',
  ];
  return '${dias[fecha.weekday - 1]} ${fecha.day} ${meses[fecha.month - 1]}';
}
