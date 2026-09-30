import 'package:flutter/material.dart';
import '../../models/turno.dart';

class DetalleTurnoScreen extends StatelessWidget {
  final Turno turno;
  const DetalleTurnoScreen({super.key, required this.turno});

  static const verdeOscuro = Color(0xFF1F5F5B);
  static const crema = Color(0xFFF5F1E8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: crema,
      appBar: AppBar(
        backgroundColor: crema,
        elevation: 0,
        foregroundColor: verdeOscuro,
        title: const Text(
          'Detalle del turno',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9EDE9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.event_available,
                      size: 32,
                      color: verdeOscuro,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    turno.especialidad,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F1F1F),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    turno.especialistaNombre,
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _fila('Fecha', _formatearFecha(turno.fecha)),
            _fila('Horario', '${turno.horario} hs'),
            _fila('Paciente', turno.pacienteNombre),
            _fila('Ubicación', 'Consultorio 3 — Piso 2'),
            _fila('Código', turno.id.toUpperCase()),
            const Spacer(),
            OutlinedButton.icon(
              icon: const Icon(Icons.cancel_outlined, color: Colors.red),
              label: const Text('Cancelar turno', style: TextStyle(color: Colors.red)),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('¿Cancelar turno?'),
                    content: const Text('Esta acción no se puede deshacer.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Volver'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Cancelación simulada (demo)')),
                          );
                        },
                        child: const Text('Sí, cancelar',
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _fila(String label, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(label, style: const TextStyle(color: Colors.grey)),
          ),
          Expanded(
            child: Text(
              valor,
              style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF1F1F1F)),
            ),
          ),
        ],
      ),
    );
  }

  String _formatearFecha(DateTime fecha) {
    const dias = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'];
    const meses = [
      'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
      'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre',
    ];
    return '${dias[fecha.weekday - 1]} ${fecha.day} de ${meses[fecha.month - 1]}';
  }
}
