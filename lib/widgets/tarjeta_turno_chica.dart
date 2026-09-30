import 'package:flutter/material.dart';
import '../models/turno.dart';
import '../utils/formato_fecha.dart';
import 'badge_estado.dart';

class TarjetaTurnoChica extends StatelessWidget {
  final Turno turno;
  const TarjetaTurnoChica({super.key, required this.turno});

  static const verdeOscuro = Color(0xFF1F5F5B);
  static const verdeSuave = Color(0xFFD9EDE9);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: verdeSuave,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.person_outline,
              color: verdeOscuro,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  turno.especialistaNombre,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F1F1F),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  turno.especialidad,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(height: 4),
                Text(
                  '${formatearFechaCorta(turno.fecha)} · ${turno.horario} hs',
                  style: const TextStyle(fontSize: 11, color: Colors.black45),
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
