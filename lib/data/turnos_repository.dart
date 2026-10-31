import '../models/especialista.dart';
import '../models/turno.dart';
import 'mock_data.dart';

class TurnosRepository {
  // En un futuro, acá iría la llamada a la base de datos real.
  // Por ahora, simulamos la latencia de red o disco con un pequeño delay.
  
  Future<List<Especialista>> obtenerEspecialistas() async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simula carga
    return MockData.especialistasIniciales();
  }

  Future<List<Turno>> obtenerTurnos() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return []; // Empieza vacío
  }
}
