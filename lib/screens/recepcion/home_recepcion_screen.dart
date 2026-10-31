import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/turno.dart';
import '../../providers/auth_provider.dart';
import '../../providers/turnos_provider.dart';
import '../../utils/formato_fecha.dart';
import '../login_screen.dart';
import 'alta_paciente_screen.dart';
import 'cargar_turno_screen.dart';

class HomeRecepcionScreen extends StatelessWidget {
  const HomeRecepcionScreen({super.key});

  static const verdeOscuro = Color(0xFF1F5F5B);
  static const verdeSuave = Color(0xFFD9EDE9);
  static const crema = Color(0xFFF5F1E8);

  @override
  Widget build(BuildContext context) {
    final agrupados =
        context.watch<TurnosProvider>().turnosProximosPorEspecialidad();

    return Scaffold(
      backgroundColor: crema,
      appBar: AppBar(
        backgroundColor: verdeOscuro,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Agenda de recepción',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_alt),
            tooltip: 'Alta de paciente',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AltaPacienteScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () {
              context.read<AuthProvider>().logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: agrupados.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'No hay turnos cargados.\nTocá "+ Cargar turno" para agregar uno.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
              children: [
                ...agrupados.entries.map((entry) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _TituloEspecialidad(
                        especialidad: entry.key,
                        cantidad: entry.value.length,
                      ),
                      const SizedBox(height: 10),
                      ...entry.value.map((t) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: _TarjetaTurnoRecepcion(turno: t),
                          )),
                      const SizedBox(height: 20),
                    ],
                  );
                }),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: verdeOscuro,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CargarTurnoScreen()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Cargar turno'),
      ),
    );
  }
}


class _TituloEspecialidad extends StatelessWidget {
  final String especialidad;
  final int cantidad;
  const _TituloEspecialidad({required this.especialidad, required this.cantidad});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          especialidad.toUpperCase(),
          style: const TextStyle(
            fontSize: 13,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
            color: HomeRecepcionScreen.verdeOscuro,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: HomeRecepcionScreen.verdeSuave,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            '$cantidad',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: HomeRecepcionScreen.verdeOscuro,
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// TARJETA DE TURNO PARA RECEPCIÓN
// ============================================================
class _TarjetaTurnoRecepcion extends StatelessWidget {
  final Turno turno;
  const _TarjetaTurnoRecepcion({required this.turno});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: HomeRecepcionScreen.verdeSuave,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(
              turno.horario,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: HomeRecepcionScreen.verdeOscuro,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  turno.pacienteNombre,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F1F1F),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  turno.especialistaNombre,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(height: 4),
                Text(
                  formatearFechaMuyCorta(turno.fecha),
                  style: const TextStyle(fontSize: 11, color: Colors.black45),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
