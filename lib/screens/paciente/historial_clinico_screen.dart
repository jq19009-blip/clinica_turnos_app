import 'package:flutter/material.dart';
import '../../widgets/barra_navegacion_paciente.dart';

class HistorialClinicoScreen extends StatelessWidget {
  const HistorialClinicoScreen({super.key});

  static const verdeOscuro = Color(0xFF1F5F5B);
  static const verdeSuave = Color(0xFFD9EDE9);
  static const crema = Color(0xFFF5F1E8);

  final List<Map<String, String>> _visitas = const [
    {
      'fecha': 'Lunes 10 de agosto · 11:00 hs',
      'medico': 'Dra. Camila Ríos',
      'especialidad': 'Dermatología',
      'motivo': 'Control de lunar en espalda. Sin cambios significativos.',
    },
    {
      'fecha': 'Jueves 24 de julio · 09:30 hs',
      'medico': 'Dr. Alejandro Vega',
      'especialidad': 'Clínica Médica',
      'motivo': 'Chequeo general anual. Estudios de sangre dentro de parámetros.',
    },
    {
      'fecha': 'Martes 2 de julio · 15:00 hs',
      'medico': 'Dra. Valentina Moreno',
      'especialidad': 'Cardiología',
      'motivo': 'Electrocardiograma de rutina. Resultado normal.',
    },
    {
      'fecha': 'Viernes 14 de junio · 10:15 hs',
      'medico': 'Dra. Sofía Ibáñez',
      'especialidad': 'Pediatría',
      'motivo': 'Consulta por cuadro gripal leve. Tratamiento sintomático.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: crema,
      appBar: AppBar(
        backgroundColor: crema,
        elevation: 0,
        foregroundColor: verdeOscuro,
        title: const Text(
          'Historial clínico',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: _visitas.length,
        separatorBuilder: (_, __) => const SizedBox(height: 14),
        itemBuilder: (context, i) => _TarjetaVisita(visita: _visitas[i]),
      ),
      bottomNavigationBar: const BarraNavegacionPaciente(indiceActivo: 1),
    );
  }
}

class _TarjetaVisita extends StatelessWidget {
  final Map<String, String> visita;
  const _TarjetaVisita({required this.visita});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: HistorialClinicoScreen.verdeSuave,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.description_outlined,
                  color: HistorialClinicoScreen.verdeOscuro,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      visita['medico']!,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F1F1F),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      visita['especialidad']!,
                      style: const TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            visita['fecha']!,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black45,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            visita['motivo']!,
            style: const TextStyle(fontSize: 13, color: Color(0xFF1F1F1F), height: 1.4),
          ),
        ],
      ),
    );
  }
}
