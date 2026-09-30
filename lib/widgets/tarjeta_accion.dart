import 'package:flutter/material.dart';

class TarjetaAccion extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final String subtitulo;
  final VoidCallback onTap;

  const TarjetaAccion({
    super.key,
    required this.icono,
    required this.titulo,
    required this.subtitulo,
    required this.onTap,
  });

  static const verdeOscuro = Color(0xFF1F5F5B);
  static const verdeSuave = Color(0xFFD9EDE9);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: verdeSuave,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icono, color: verdeOscuro, size: 22),
              ),
              const SizedBox(height: 14),
              Text(
                titulo,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F1F1F),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitulo,
                style: const TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
