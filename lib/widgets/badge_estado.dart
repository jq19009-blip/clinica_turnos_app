import 'package:flutter/material.dart';
import '../models/turno.dart';

class BadgeEstado extends StatelessWidget {
  final EstadoTurno estado;
  const BadgeEstado({super.key, required this.estado});

  static const verdeSuave = Color(0xFFD9EDE9);
  static const verdeOscuro = Color(0xFF1F5F5B);
  static const amarilloSuave = Color(0xFFFDF3D6);
  static const amarilloTexto = Color(0xFFB78103);
  static const rojoSuave = Color(0xFFFBE4E4);
  static const rojoTexto = Color(0xFFC0392B);

  @override
  Widget build(BuildContext context) {
    late final Color fondo;
    late final Color texto;
    late final String label;

    switch (estado) {
      case EstadoTurno.confirmado:
        fondo = verdeSuave;
        texto = verdeOscuro;
        label = 'Confirmado';
        break;
      case EstadoTurno.pendiente:
        fondo = amarilloSuave;
        texto = amarilloTexto;
        label = 'Pendiente';
        break;
      case EstadoTurno.cancelado:
        fondo = rojoSuave;
        texto = rojoTexto;
        label = 'Cancelado';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: fondo,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: texto,
        ),
      ),
    );
  }
}
