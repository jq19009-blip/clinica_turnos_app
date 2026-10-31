import 'package:flutter/material.dart';
import '../screens/paciente/home_paciente_screen.dart';
import '../screens/paciente/seleccion_especialidad_screen.dart';
import '../screens/paciente/historial_clinico_screen.dart';
import '../screens/paciente/perfil_paciente_screen.dart';

class BarraNavegacionPaciente extends StatelessWidget {
  final int indiceActivo;
  const BarraNavegacionPaciente({super.key, required this.indiceActivo});

  static const verdeOscuro = Color(0xFF1F5F5B);
  static const gris = Color(0xFF9E9E9E);

  void _navegar(BuildContext context, int indice) {
    if (indice == indiceActivo) return;

    Widget destino;
    switch (indice) {
      case 0:
        destino = const SeleccionEspecialidadScreen();
        break;
      case 1:
        destino = const HistorialClinicoScreen();
        break;
      case 2:
        destino = const PerfilPacienteScreen();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => destino),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE0E0E0), width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ItemBarra(
                icono: Icons.add_circle_outline,
                etiqueta: 'Sacar turno',
                activo: indiceActivo == 0,
                onTap: () => _navegar(context, 0),
              ),
              _ItemBarra(
                icono: Icons.description_outlined,
                etiqueta: 'Historial',
                activo: indiceActivo == 1,
                onTap: () => _navegar(context, 1),
              ),
              _ItemBarra(
                icono: Icons.person_outline,
                etiqueta: 'Perfil',
                activo: indiceActivo == 2,
                onTap: () => _navegar(context, 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemBarra extends StatelessWidget {
  final IconData icono;
  final String etiqueta;
  final bool activo;
  final VoidCallback onTap;

  const _ItemBarra({
    required this.icono,
    required this.etiqueta,
    required this.activo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = activo ? BarraNavegacionPaciente.verdeOscuro : BarraNavegacionPaciente.gris;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                decoration: activo
                    ? BoxDecoration(
                        color: BarraNavegacionPaciente.verdeOscuro.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      )
                    : null,
                child: Icon(icono, color: color, size: 24),
              ),
              const SizedBox(height: 2),
              Text(
                etiqueta,
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: activo ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
