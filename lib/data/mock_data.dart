import '../models/especialista.dart';
import '../models/usuario.dart';

class MockData {
  static List<Especialista> especialistasIniciales() {
    return [
      Especialista(
        id: 'e1',
        nombre: 'Dra. Laura Gómez',
        especialidad: 'Clínico General',
        diasAtencion: [1, 3, 5], // lunes, miércoles, viernes
        horariosDisponibles: ['09:00', '09:30', '10:00', '10:30', '11:00'],
      ),
      Especialista(
        id: 'e2',
        nombre: 'Dr. Martín Pérez',
        especialidad: 'Clínico General',
        diasAtencion: [2, 4], // martes, jueves
        horariosDisponibles: ['14:00', '14:30', '15:00', '15:30'],
      ),
      Especialista(
        id: 'e3',
        nombre: 'Dra. Sofía Ibáñez',
        especialidad: 'Pediatría',
        diasAtencion: [1, 2, 3, 4, 5], // lunes a viernes
        horariosDisponibles: ['09:00', '09:30', '10:00'],
      ),
      Especialista(
        id: 'e4',
        nombre: 'Dr. Diego Salas',
        especialidad: 'Cardiología',
        diasAtencion: [1, 4], // lunes y jueves
        horariosDisponibles: ['10:00', '10:30', '11:00', '11:30'],
      ),
      Especialista(
        id: 'e5',
        nombre: 'Dra. Carla Ríos',
        especialidad: 'Dermatología',
        diasAtencion: [2, 5], // martes y viernes
        horariosDisponibles: ['13:00', '13:30', '14:00'],
      ),
    ];
  }

  static List<Usuario> usuariosIniciales() {
    return [
      Usuario(
        id: 'u-recepcion',
        nombre: 'Recepción',
        apellido: '',
        dni: '-',
        telefono: '-',
        email: 'recepcion@clinica.com',
        password: '1234',
        rol: RolUsuario.recepcion,
      ),
      Usuario(
        id: 'u-martin',
        nombre: 'Martín',
        apellido: 'Gutiérrez',
        dni: '123',
        telefono: '+54 11 5523-4410',
        email: 'martin.gutierrez@email.com',
        password: '1234',
        rol: RolUsuario.paciente,
        fechaNacimiento: '14/03/1985',
        obraSocial: 'OSDE',
        numeroAfiliado: '4412-8821',
      ),
    ];
  }
}
