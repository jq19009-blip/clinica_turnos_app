import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registro_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static const verdeOscuro = Color(0xFF1F5F5B);
  static const verdeMedio = Color(0xFF2C7A73);
  static const crema = Color(0xFFF5F1E8);
  static const cremaSuave = Color(0xFFEDE7DA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: crema,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // ---------- TOP VERDE ----------
            Expanded(
              flex: 6,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: verdeOscuro,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  ),
                ),
                child: Stack(
                  children: [
                    // círculos decorativos
                    Positioned(
                      top: 40,
                      right: -60,
                      child: _circulo(180, verdeMedio.withValues(alpha: 0.35)),
                    ),
                    Positioned(
                      top: 140,
                      right: 20,
                      child: _circulo(90, verdeMedio.withValues(alpha: 0.5)),
                    ),
                    Positioned(
                      bottom: -40,
                      left: -30,
                      child: _circulo(140, verdeMedio.withValues(alpha: 0.25)),
                    ),

                    // contenido
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(28, 16, 28, 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // logo
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: crema.withValues(alpha: 0.6), width: 1.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(Icons.favorite_border, color: crema, size: 18),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'CLINICAMED',
                                  style: TextStyle(
                                    color: crema,
                                    fontSize: 12,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Text(
                              'Tu salud,\nen tus manos.',
                              style: TextStyle(
                                color: crema,
                                fontSize: 36,
                                height: 1.1,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'serif',
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Gestioná tus turnos, consultá tus estudios y conectá con los mejores especialistas — todo desde un solo lugar.',
                              style: TextStyle(
                                color: crema.withValues(alpha: 0.85),
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ---------- BOTTOM CREMA ----------
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(28, 28, 28, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bienvenido/a',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F1F1F),
                        fontFamily: 'serif',
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      '¿Cómo querés continuar?',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: verdeOscuro,
                          foregroundColor: crema,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const LoginScreen()),
                          );
                        },
                        child: const Text(
                          'Ingresar con mi cuenta',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: verdeOscuro,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: const BorderSide(color: verdeOscuro, width: 1.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const RegistroScreen()),
                          );
                        },
                        child: const Text(
                          'Registrarme por primera vez',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Center(
                      child: Text(
                        '¿Tenés un turno sin cuenta? Buscá tu turno aquí',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: verdeOscuro.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circulo(double tamano, Color color) {
  return Container(
    width: tamano,
    height: tamano,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
