import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/turnos_provider.dart';
import 'screens/onboarding_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const ClinicaApp());
}

class ClinicaApp extends StatelessWidget {
  const ClinicaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TurnosProvider()),
      ],
      child: MaterialApp(
        title: 'Clínica - Turnos',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: const OnboardingScreen(),
      ),
    );
  }
}
