enum EstadoTurno { confirmado, pendiente, cancelado }

class Turno {
  final String id;
  final String pacienteNombre;
  final String especialistaId;
  final String especialistaNombre;
  final String especialidad;
  final DateTime fecha;
  final String horario;
  final EstadoTurno estado;

  Turno({
    required this.id,
    required this.pacienteNombre,
    required this.especialistaId,
    required this.especialistaNombre,
    required this.especialidad,
    required this.fecha,
    required this.horario,
    this.estado = EstadoTurno.confirmado,
  });

  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pacienteNombre': pacienteNombre,
      'especialistaId': especialistaId,
      'especialistaNombre': especialistaNombre,
      'especialidad': especialidad,
      'fecha': fecha.toIso8601String(),
      'horario': horario,
      'estado': estado.name,
    };
  }

  /// Deserialización: De Mapa a Objeto (para leer de DB)
  factory Turno.fromObject(Map<String, dynamic> map) {
    return Turno(
      id: map['id'],
      pacienteNombre: map['pacienteNombre'],
      especialistaId: map['especialistaId'],
      especialistaNombre: map['especialistaNombre'],
      especialidad: map['especialidad'],
      fecha: DateTime.parse(map['fecha']),
      horario: map['horario'],
      estado: EstadoTurno.values.byName(map['estado']),
    );
  }
}
