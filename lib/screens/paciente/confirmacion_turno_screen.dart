import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/especialista.dart';
import '../../providers/auth_provider.dart';
import '../../providers/turnos_provider.dart';
import 'home_paciente_screen.dart';

class ConfirmacionTurnoScreen extends StatelessWidget {
  final Especialista especialista;
  final String horario;

  const ConfirmacionTurnoScreen({
    super.key,
    required this.especialista,
    required this.horario,
  });

  @override
  Widget build(BuildContext context) {
    final usuario = context.read<AuthProvider>().usuarioActual!;

    return Scaffold(
      appBar: AppBar(title: const Text('Confirmar turno')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: const Color(0xFFEAF6F5),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _fila('Especialidad', especialista.especialidad),
                    _fila('Profesional', especialista.nombre),
                    _fila('Horario', horario),
                    _fila('Paciente', usuario.nombre),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),
            ElevatedButton(
              onPressed: () {
                context.read<TurnosProvider>().agregarTurno(
                      pacienteNombre: usuario.nombre,
                      especialista: especialista,
                      horario: horario,
                    );
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Turno confirmado'),
                    content: Text('Tu turno con ${especialista.nombre} a las $horario quedó confirmado.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (_) => const HomePacienteScreen()),
                            (route) => false,
                          );
                        },
                        child: const Text('Aceptar'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Confirmar turno'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fila(String label, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 110, child: Text(label, style: const TextStyle(color: Colors.grey))),
          Expanded(child: Text(valor, style: const TextStyle(fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }
}
