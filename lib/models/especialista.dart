class Especialista {
  final String id;
  final String nombre;
  final String especialidad;
  final List<int> diasAtencion;
  final List<String> horariosDisponibles;

  Especialista({
    required this.id,
    required this.nombre,
    required this.especialidad,
    required this.diasAtencion,
    required this.horariosDisponibles,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'especialidad': especialidad,
      // Convertimos la lista de enteros a un String separado por comas
      'diasAtencion': diasAtencion.join(','), 
      'horariosDisponibles': horariosDisponibles.join(','),
    };
  }

  factory Especialista.fromObject(Map<String, dynamic> map) {
    return Especialista(
      id: map['id'],
      nombre: map['nombre'],
      especialidad: map['especialidad'],
      diasAtencion: (map['diasAtencion'] as String).split(',').map(int.parse).toList(),
      horariosDisponibles: (map['horariosDisponibles'] as String).split(','),
    );
  }
}

