import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/turnos_provider.dart';
import 'confirmacion_turno_screen.dart';

class SeleccionHorarioScreen extends StatelessWidget {
  final String especialidad;
  const SeleccionHorarioScreen({super.key, required this.especialidad});

  @override
  Widget build(BuildContext context) {
    final especialistas =
        context.watch<TurnosProvider>().especialistasPorEspecialidad(especialidad);

    return Scaffold(
      appBar: AppBar(title: Text(especialidad)),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: especialistas.length,
        itemBuilder: (context, index) {
          final especialista = especialistas[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 14),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    especialista.nombre,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  especialista.horariosDisponibles.isEmpty
                      ? const Text('Sin horarios disponibles', style: TextStyle(color: Colors.grey))
                      : Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: especialista.horariosDisponibles.map((horario) {
                            return ActionChip(
                              label: Text(horario),
                              backgroundColor: const Color(0xFFEAF6F5),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ConfirmacionTurnoScreen(
                                      especialista: especialista,
                                      horario: horario,
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
