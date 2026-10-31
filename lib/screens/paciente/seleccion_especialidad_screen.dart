import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/turnos_provider.dart';
import '../../widgets/barra_navegacion_paciente.dart';
import 'home_paciente_screen.dart';
import 'seleccion_horario_screen.dart';

class SeleccionEspecialidadScreen extends StatelessWidget {
  const SeleccionEspecialidadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final especialidades = context.watch<TurnosProvider>().especialidades;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePacienteScreen()),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomePacienteScreen()),
              );
            },
          ),
          title: const Text('Elegí una especialidad'),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: especialidades.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final especialidad = especialidades[index];
            return Card(
              child: ListTile(
                leading: const Icon(Icons.medical_services_outlined, color: Color(0xFF028090)),
                title: Text(especialidad),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SeleccionHorarioScreen(especialidad: especialidad),
                    ),
                  );
                },
              ),
            );
          },
        ),
        bottomNavigationBar: const BarraNavegacionPaciente(indiceActivo: 0),
      ),
    );
  }
}
