import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/usuario.dart';
import '../providers/auth_provider.dart';
import 'paciente/home_paciente_screen.dart';
import 'recepcion/home_recepcion_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  String? _error;

  void _ingresar() {
    final auth = context.read<AuthProvider>();
    final error = auth.login(_emailCtrl.text.trim(), _passCtrl.text.trim());
    if (error != null) {
      setState(() => _error = error);
      return;
    }
    final rol = auth.usuarioActual!.rol;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            rol == RolUsuario.recepcion ? const HomeRecepcionScreen() : const HomePacienteScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color(0xFF0B2E33),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.local_hospital, size: 56, color: Color(0xFF028090)),
              const SizedBox(height: 12),
              const Text(
                'Clínica Salud+',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF0B2E33)),
              ),
              const SizedBox(height: 4),
              const Text(
                'Ingresá para sacar o gestionar turnos',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _passCtrl,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
              if (_error != null) ...[
                const SizedBox(height: 10),
                Text(_error!, style: const TextStyle(color: Colors.red)),
              ],
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _ingresar,
                child: const Text('Ingresar'),
              ),
              const SizedBox(height: 24),
              const Text(
                'Cuenta de prueba:\nmartin.gutierrez@email.com / 1234\nrecepcion@clinica.com / 1234',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
