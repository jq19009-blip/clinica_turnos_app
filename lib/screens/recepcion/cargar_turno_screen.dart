import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/especialista.dart';
import '../../providers/turnos_provider.dart';
import '../../utils/formato_fecha.dart';

class CargarTurnoScreen extends StatefulWidget {
  const CargarTurnoScreen({super.key});

  @override
  State<CargarTurnoScreen> createState() => _CargarTurnoScreenState();
}

class _CargarTurnoScreenState extends State<CargarTurnoScreen> {
  static const verdeOscuro = Color(0xFF1F5F5B);
  static const verdeSuave = Color(0xFFD9EDE9);

  final _nombreCtrl = TextEditingController();
  
  DateTime _fechaSeleccionada = DateTime.now();
  String? _especialidadSeleccionada;
  Especialista? _especialistaSeleccionado;
  String? _horarioSeleccionado;

  @override
  void dispose() {
    _nombreCtrl.dispose();
    super.dispose();
  }

  bool _puedeConfirmar() {
    return _nombreCtrl.text.trim().isNotEmpty &&
        _especialistaSeleccionado != null &&
        _horarioSeleccionado != null;
  }

  Future<void> _elegirFecha() async {
    final fecha = await showDatePicker(
      context: context,
      initialDate: _fechaSeleccionada,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: verdeOscuro,
              onPrimary: Colors.white,
              onSurface: Color(0xFF1F1F1F),
            ),
          ),
          child: child!,
        );
      },
    );
    if (fecha != null) {
      setState(() {
        _fechaSeleccionada = fecha;
        _horarioSeleccionado = null; // se resetea al cambiar el día
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final turnosProvider = context.watch<TurnosProvider>();
    final especialidades = turnosProvider.especialidades;

    // Si hay especialidad elegida, filtramos los que atienden ESE día
    final especialistasDelDia = _especialidadSeleccionada == null
        ? <Especialista>[]
        : turnosProvider
            .especialistasPorEspecialidad(_especialidadSeleccionada!)
            .where((e) => turnosProvider.especialistaAtiende(e, _fechaSeleccionada))
            .toList();

    // Horarios libres del especialista elegido en la fecha elegida
    final horariosLibres = _especialistaSeleccionado == null
        ? <String>[]
        : turnosProvider.horariosLibres(_especialistaSeleccionado!, _fechaSeleccionada);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: verdeOscuro,
        foregroundColor: Colors.white,
        title: const Text('Cargar turno'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            // 1. NOMBRE DEL PACIENTE
            TextField(
              controller: _nombreCtrl,
              decoration: const InputDecoration(labelText: 'Nombre del paciente'),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 20),

            // 2. FECHA
            const Text(
              'Fecha del turno',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: _elegirFecha,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 18, color: verdeOscuro),
                    const SizedBox(width: 10),
                    Text(
                      formatearFechaCorta(_fechaSeleccionada),
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_drop_down, color: Colors.black54),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 3. ESPECIALIDAD
            DropdownButtonFormField<String>(
              initialValue: _especialidadSeleccionada,
              decoration: const InputDecoration(labelText: 'Especialidad'),
              items: especialidades
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _especialidadSeleccionada = value;
                  _especialistaSeleccionado = null;
                  _horarioSeleccionado = null;
                });
              },
            ),
            const SizedBox(height: 20),

            // 4. PROFESIONAL (solo los que atienden ese día)
            if (_especialidadSeleccionada != null) ...[
              if (especialistasDelDia.isEmpty)
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'No hay profesionales de esta especialidad que atiendan ese día. Probá con otra fecha.',
                    style: TextStyle(color: Colors.red, fontSize: 13),
                  ),
                )
              else
                DropdownButtonFormField<Especialista>(
                  initialValue: _especialistaSeleccionado,
                  decoration: const InputDecoration(labelText: 'Profesional'),
                  items: especialistasDelDia
                      .map((e) => DropdownMenuItem(value: e, child: Text(e.nombre)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _especialistaSeleccionado = value;
                      _horarioSeleccionado = null;
                    });
                  },
                ),
            ],
            const SizedBox(height: 20),

            // 5. HORARIOS LIBRES
            if (_especialistaSeleccionado != null) ...[
              const Text(
                'Horarios disponibles',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 10),
              horariosLibres.isEmpty
                  ? const Text(
                      'Sin horarios disponibles para este día.',
                      style: TextStyle(color: Colors.grey),
                    )
                  : Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: horariosLibres.map((horario) {
                        final seleccionado = horario == _horarioSeleccionado;
                        return ChoiceChip(
                          label: Text(horario),
                          selected: seleccionado,
                          selectedColor: verdeSuave,
                          labelStyle: TextStyle(
                            color: seleccionado ? verdeOscuro : Colors.black87,
                            fontWeight: seleccionado ? FontWeight.bold : FontWeight.normal,
                          ),
                          onSelected: (_) {
                            setState(() => _horarioSeleccionado = horario);
                          },
                        );
                      }).toList(),
                    ),
            ],
            const SizedBox(height: 40),

            // 6. BOTÓN CONFIRMAR
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: verdeOscuro,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: _puedeConfirmar()
                  ? () {
                      turnosProvider.agregarTurnoEnFecha(
                        pacienteNombre: _nombreCtrl.text.trim(),
                        especialista: _especialistaSeleccionado!,
                        fecha: _fechaSeleccionada,
                        horario: _horarioSeleccionado!,
                      );
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Turno cargado correctamente')),
                      );
                    }
                  : null,
              child: const Text(
                'Cargar turno',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
