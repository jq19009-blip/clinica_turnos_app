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
}
