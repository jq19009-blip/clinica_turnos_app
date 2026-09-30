 enum RolUsuario { paciente, recepcion }

class Usuario {
  final String id;
  final String nombre;
  final String apellido;
  final String dni;
  final String telefono;
  final String email;
  final String password;
  final RolUsuario rol;
  final String? fechaNacimiento;
  final String? obraSocial;
  final String? numeroAfiliado;

  Usuario({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.dni,
    required this.telefono,
    required this.email,
    required this.password,
    required this.rol,
    this.fechaNacimiento,
    this.obraSocial,
    this.numeroAfiliado,
  });

  /// Nombre completo armado.
  String get nombreCompleto => '$nombre $apellido'.trim();

  /// Iniciales para el avatar (ej: "MG").
  String get iniciales {
    final n = nombre.isNotEmpty ? nombre[0] : '';
    final a = apellido.isNotEmpty ? apellido[0] : '';
    return '$n$a'.toUpperCase();
  }

  /// Devuelve una copia con algunos campos modificados.
  Usuario copyWith({
    String? nombre,
    String? apellido,
    String? telefono,
    String? email,
    String? fechaNacimiento,
    String? obraSocial,
    String? numeroAfiliado,
  }) {
    return Usuario(
      id: id,
      nombre: nombre ?? this.nombre,
      apellido: apellido ?? this.apellido,
      dni: dni,
      telefono: telefono ?? this.telefono,
      email: email ?? this.email,
      password: password,
      rol: rol,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      obraSocial: obraSocial ?? this.obraSocial,
      numeroAfiliado: numeroAfiliado ?? this.numeroAfiliado,
    );
  }
}