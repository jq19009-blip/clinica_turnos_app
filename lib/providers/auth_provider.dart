import 'package:flutter/foundation.dart';
import '../data/mock_data.dart';
import '../models/usuario.dart';

class AuthProvider extends ChangeNotifier {
  final List<Usuario> _usuarios = MockData.usuariosIniciales();
  Usuario? _usuarioActual;

  Usuario? get usuarioActual => _usuarioActual;

  String? login(String email, String password) {
    final coincidencias = _usuarios.where(
      (u) => u.email.toLowerCase() == email.toLowerCase() && u.password == password,
    );
    if (coincidencias.isEmpty) {
      return 'Email o contraseña incorrectos';
    }
    _usuarioActual = coincidencias.first;
    notifyListeners();
    return null;
  }

  String? registrarPaciente({
    required String nombre,
    required String apellido,
    required String dni,
    required String telefono,
    required String email,
    required String password,
  }) {
    final yaExiste = _usuarios.any((u) => u.email.toLowerCase() == email.toLowerCase());
    if (yaExiste) {
      return 'Ya existe una cuenta con ese email';
    }
    final nuevo = Usuario(
      id: 'p-${DateTime.now().millisecondsSinceEpoch}',
      nombre: nombre,
      apellido: apellido,
      dni: dni,
      telefono: telefono,
      email: email,
      password: password,
      rol: RolUsuario.paciente,
    );
    _usuarios.add(nuevo);
    _usuarioActual = nuevo;
    notifyListeners();
    return null;
  }

  void actualizarPerfil(Usuario actualizado) {
    final index = _usuarios.indexWhere((u) => u.id == actualizado.id);
    if (index != -1) {
      _usuarios[index] = actualizado;
      _usuarioActual = actualizado;
      notifyListeners();
    }
  }

  void logout() {
    _usuarioActual = null;
    notifyListeners();
  }
}
