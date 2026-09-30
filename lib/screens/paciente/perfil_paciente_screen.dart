import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/barra_navegacion_paciente.dart';
import '../login_screen.dart';

class PerfilPacienteScreen extends StatefulWidget {
  const PerfilPacienteScreen({super.key});

  @override
  State<PerfilPacienteScreen> createState() => _PerfilPacienteScreenState();
}

class _PerfilPacienteScreenState extends State<PerfilPacienteScreen> {
  static const verdeOscuro = Color(0xFF1F5F5B);
  static const crema = Color(0xFFF5F1E8);

  bool _modoEdicion = false;

  late TextEditingController _nombreCtrl;
  late TextEditingController _apellidoCtrl;
  late TextEditingController _dniCtrl;
  late TextEditingController _telefonoCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _fechaNacCtrl;
  late TextEditingController _obraSocialCtrl;
  late TextEditingController _numAfiliadoCtrl;

  @override
  void initState() {
    super.initState();
    final u = context.read<AuthProvider>().usuarioActual!;
    _nombreCtrl = TextEditingController(text: u.nombre);
    _apellidoCtrl = TextEditingController(text: u.apellido);
    _dniCtrl = TextEditingController(text: u.dni);
    _telefonoCtrl = TextEditingController(text: u.telefono);
    _emailCtrl = TextEditingController(text: u.email);
    _fechaNacCtrl = TextEditingController(text: u.fechaNacimiento ?? '');
    _obraSocialCtrl = TextEditingController(text: u.obraSocial ?? '');
    _numAfiliadoCtrl = TextEditingController(text: u.numeroAfiliado ?? '');
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _apellidoCtrl.dispose();
    _dniCtrl.dispose();
    _telefonoCtrl.dispose();
    _emailCtrl.dispose();
    _fechaNacCtrl.dispose();
    _obraSocialCtrl.dispose();
    _numAfiliadoCtrl.dispose();
    super.dispose();
  }

  void _guardar() {
    final auth = context.read<AuthProvider>();
    final actual = auth.usuarioActual!;
    final actualizado = actual.copyWith(
      nombre: _nombreCtrl.text.trim(),
      apellido: _apellidoCtrl.text.trim(),
      telefono: _telefonoCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      fechaNacimiento: _fechaNacCtrl.text.trim(),
      obraSocial: _obraSocialCtrl.text.trim(),
      numeroAfiliado: _numAfiliadoCtrl.text.trim(),
    );
    auth.actualizarPerfil(actualizado);
    setState(() => _modoEdicion = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Perfil actualizado')),
    );
  }

  void _cancelarEdicion() {
    final u = context.read<AuthProvider>().usuarioActual!;
    _nombreCtrl.text = u.nombre;
    _apellidoCtrl.text = u.apellido;
    _telefonoCtrl.text = u.telefono;
    _emailCtrl.text = u.email;
    _fechaNacCtrl.text = u.fechaNacimiento ?? '';
    _obraSocialCtrl.text = u.obraSocial ?? '';
    _numAfiliadoCtrl.text = u.numeroAfiliado ?? '';
    setState(() => _modoEdicion = false);
  }

  void _cerrarSesion() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('¿Cerrar sesión?'),
        content: const Text('Vas a salir de tu cuenta.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AuthProvider>().logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            child: const Text('Cerrar sesión', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final usuario = context.watch<AuthProvider>().usuarioActual!;

    return Scaffold(
      backgroundColor: crema,
      appBar: AppBar(
        backgroundColor: verdeOscuro,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Mi perfil',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Text(
                usuario.iniciales,
                style: const TextStyle(
                  color: verdeOscuro,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: verdeOscuro,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    usuario.iniciales,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        usuario.nombreCompleto,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F1F1F),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'DNI ${usuario.dni}',
                        style: const TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        usuario.email,
                        style: const TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _seccion('DATOS PERSONALES'),
          const SizedBox(height: 10),
          _campo('Nombre *', _nombreCtrl, habilitado: _modoEdicion),
          const SizedBox(height: 12),
          _campo('Apellido *', _apellidoCtrl, habilitado: _modoEdicion),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _campo('DNI', _dniCtrl, habilitado: false)),
              const SizedBox(width: 12),
              Expanded(child: _campo('Fecha de nacimiento', _fechaNacCtrl, habilitado: _modoEdicion)),
            ],
          ),
          const SizedBox(height: 24),
          _seccion('CONTACTO'),
          const SizedBox(height: 10),
          _campo('Email *', _emailCtrl, habilitado: _modoEdicion, keyboardType: TextInputType.emailAddress),
          const SizedBox(height: 12),
          _campo('Teléfono', _telefonoCtrl, habilitado: _modoEdicion, keyboardType: TextInputType.phone),
          const SizedBox(height: 24),
          _seccion('COBERTURA MÉDICA'),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _campo('Obra social / Prepaga', _obraSocialCtrl, habilitado: _modoEdicion)),
              const SizedBox(width: 12),
              Expanded(child: _campo('N° afiliado', _numAfiliadoCtrl, habilitado: _modoEdicion)),
            ],
          ),
          const SizedBox(height: 30),
          if (_modoEdicion) ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: verdeOscuro,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _guardar,
                child: const Text('Guardar cambios', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: verdeOscuro,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: verdeOscuro),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _cancelarEdicion,
                child: const Text('Cancelar'),
              ),
            ),
          ] else ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: verdeOscuro,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Editar perfil', style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () => setState(() => _modoEdicion = true),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.logout),
                label: const Text('Cerrar sesión', style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: _cerrarSesion,
              ),
            ),
          ],
          const SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: const BarraNavegacionPaciente(indiceActivo: 2),
    );
  }

  Widget _seccion(String texto) {
    return Text(
      texto,
      style: const TextStyle(
        fontSize: 12,
        letterSpacing: 2,
        fontWeight: FontWeight.bold,
        color: verdeOscuro,
      ),
    );
  }

  Widget _campo(
    String label,
    TextEditingController ctrl, {
    bool habilitado = true,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF1F1F1F)),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: ctrl,
          enabled: habilitado,
          keyboardType: keyboardType,
          style: TextStyle(
            color: habilitado ? const Color(0xFF1F1F1F) : Colors.black45,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: habilitado ? Colors.white : const Color(0xFFF1EFE9),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: verdeOscuro, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
