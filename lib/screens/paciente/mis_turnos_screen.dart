import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/turno.dart';
import '../../providers/auth_provider.dart';
import '../../providers/turnos_provider.dart';
import '../../utils/formato_fecha.dart';
import '../../widgets/badge_estado.dart';
import 'detalle_turno_screen.dart';

class MisTurnosScreen extends StatelessWidget {
  const MisTurnosScreen({super.key});

  static const verdeOscuro = Color(0xFF1F5F5B);
  static const crema = Color(0xFFF5F1E8);
  static const rojoTexto = Color(0xFFC0392B);

  @override
  Widget build(BuildContext context) {
    final usuario = context.watch<AuthProvider>().usuarioActual!;
    final turnos = context.watch<TurnosProvider>().turnosDePaciente(usuario.nombreCompleto);

    final proximos =
        turnos.where((t) => t.estado != EstadoTurno.cancelado).toList();
    final historial =
        turnos.where((t) => t.estado == EstadoTurno.cancelado).toList();

    return Scaffold(
      backgroundColor: crema,
      appBar: AppBar(
        backgroundColor: crema,
        elevation: 0,
        foregroundColor: verdeOscuro,
        title: const Text(
          'Mis turnos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: proximos.isEmpty && historial.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Todavía no tenés turnos agendados.\nTocá "+ Sacar nuevo turno" para empezar.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
              children: [
                if (proximos.isNotEmpty) ...[
                  const _TituloSeccion('PRÓXIMOS'),
                  const SizedBox(height: 12),
                  ...proximos.map((t) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _TarjetaTurno(turno: t),
                      )),
                ],
                if (historial.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  const _TituloSeccion('HISTORIAL'),
                  const SizedBox(height: 12),
                  ...historial.map((t) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _TarjetaHistorial(turno: t),
                      )),
                ],
              ],
            ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: SizedBox(
            height: 54,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: verdeOscuro,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text(
                '+ Sacar nuevo turno',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// TÍTULO DE SECCIÓN
// ============================================================
class _TituloSeccion extends StatelessWidget {
  final String texto;
  const _TituloSeccion(this.texto);

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        letterSpacing: 3,
        color: MisTurnosScreen.verdeOscuro,
        fontFamily: 'serif',
      ),
    );
  }
}

// ============================================================
// TARJETA DE TURNO PRÓXIMO
// ============================================================
class _TarjetaTurno extends StatelessWidget {
  final Turno turno;
  const _TarjetaTurno({required this.turno});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      turno.especialistaNombre,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F1F1F),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      turno.especialidad,
                      style: const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              BadgeEstado(estado: turno.estado),
            ],
          ),
          const SizedBox(height: 16),
          _CajaInfo(
            label: 'Fecha y hora',
            valor: '${formatearFechaCorta(turno.fecha)} · ${turno.horario} hs',
          ),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: () => _confirmarCancelacion(context, turno),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Text(
                'Cancelar turno',
                style: TextStyle(
                  color: MisTurnosScreen.rojoTexto,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmarCancelacion(BuildContext context, Turno turno) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('¿Cancelar turno?'),
        content: Text(
          'Vas a cancelar el turno con ${turno.especialistaNombre} '
          'el ${formatearFechaCorta(turno.fecha)} a las ${turno.horario}.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Volver'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cancelación simulada (demo)'),
                ),
              );
            },
            child: const Text('Sí, cancelar',
                style: TextStyle(color: MisTurnosScreen.rojoTexto)),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// TARJETA DE HISTORIAL
// ============================================================
class _TarjetaHistorial extends StatelessWidget {
  final Turno turno;
  const _TarjetaHistorial({required this.turno});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12, width: 0.5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  turno.especialistaNombre,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F1F1F),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  turno.especialidad,
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                ),
                const SizedBox(height: 4),
                Text(
                  '${formatearFechaCorta(turno.fecha)} · ${turno.horario} hs',
                  style: const TextStyle(fontSize: 12, color: Colors.black45),
                ),
              ],
            ),
          ),
          BadgeEstado(estado: turno.estado),
        ],
      ),
    );
  }
}

// ============================================================
// CAJA INTERNA GRIS
// ============================================================
class _CajaInfo extends StatelessWidget {
  final String label;
  final String valor;
  const _CajaInfo({required this.label, required this.valor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF1EFE9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
          const SizedBox(height: 4),
          Text(
            valor,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F1F1F),
            ),
          ),
        ],
      ),
    );
  }
}

