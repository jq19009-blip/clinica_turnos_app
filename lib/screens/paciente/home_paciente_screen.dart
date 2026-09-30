import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/turno.dart';
import '../../providers/auth_provider.dart';
import '../../providers/turnos_provider.dart';
import '../../utils/formato_fecha.dart';
import '../../widgets/barra_navegacion_paciente.dart';
import '../../widgets/tarjeta_accion.dart';
import '../../widgets/tarjeta_turno_chica.dart';
import 'historial_clinico_screen.dart';
import 'mis_turnos_screen.dart';
import 'perfil_paciente_screen.dart';

class HomePacienteScreen extends StatelessWidget {
  const HomePacienteScreen({super.key});

  static const verdeOscuro = Color(0xFF1F5F5B);
  static const crema = Color(0xFFF5F1E8);

  @override
  Widget build(BuildContext context) {
    final usuario = context.watch<AuthProvider>().usuarioActual!;
    final todosLosTurnos =
        context.watch<TurnosProvider>().turnosDePaciente(usuario.nombreCompleto);
    final proximos = todosLosTurnos
        .where((t) => t.estado != EstadoTurno.cancelado)
        .take(3)
        .toList();

    return Scaffold(
      backgroundColor: crema,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          children: [
            // ---------- SALUDO + AVATAR ----------
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hola, ${usuario.nombre}',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'serif',
                          color: Color(0xFF1F1F1F),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        formatearFechaLarga(DateTime.now()),
                        style: const TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PerfilPacienteScreen(),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 22,
                    backgroundColor: verdeOscuro,
                    child: Text(
                      usuario.iniciales,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ---------- MIS TURNOS ----------
            TarjetaAccion(
              icono: Icons.event_note_outlined,
              titulo: 'Mis turnos',
              subtitulo:
                  'Revisá tus próximos turnos y el historial de consultas',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MisTurnosScreen()),
                );
              },
            ),
            const SizedBox(height: 14),

            // ---------- HISTORIAL CLÍNICO ----------
            TarjetaAccion(
              icono: Icons.description_outlined,
              titulo: 'Historial clínico',
              subtitulo: 'Consultá tus visitas anteriores y diagnósticos',
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HistorialClinicoScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 30),

            // ---------- PRÓXIMOS TURNOS ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Próximos turnos',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'serif',
                    color: Color(0xFF1F1F1F),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const MisTurnosScreen()),
                    );
                  },
                  child: const Text(
                    'Ver todos',
                    style: TextStyle(color: verdeOscuro, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),

            if (proximos.isEmpty)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  'No tenés turnos próximos. Tocá "Sacar turno" abajo para agendar uno.',
                  style: TextStyle(color: Colors.black54),
                ),
              )
            else
              ...proximos.map((t) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: TarjetaTurnoChica(turno: t),
                  )),
          ],
        ),
      ),
      bottomNavigationBar: const BarraNavegacionPaciente(indiceActivo: 0),
    );
  }
}
