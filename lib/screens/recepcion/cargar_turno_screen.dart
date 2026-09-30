import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/especialista.dart';
import '../../providers/turnos_provider.dart';

class CargarTurnoScreen extends StatefulWidget {
  const CargarTurnoScreen({super.key});

  @override
  State<CargarTurnoScreen> createState() => _CargarTurnoScreenState();
}

class _CargarTurnoScreenState extends State<CargarTurnoScreen> {
  final _nombreCtrl = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    final turnosProvider = context.watch<TurnosProvider>();
    final especialidades = turnosProvider.especialidades;
    final especialistas = _especialidadSeleccionada == null
        ? <Especialista>[]
        : turnosProvider.especialistasPorEspecialidad(_especialidadSeleccionada!);

    return Scaffold(
      appBar: AppBar(title: const Text('Cargar turno para un paciente')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            TextField(
              controller: _nombreCtrl,
              decoration: const InputDecoration(labelText: 'Nombre del paciente'),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
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
            const SizedBox(height: 16),
            if (_especialidadSeleccionada != null)
              DropdownButtonFormField<Especialista>(
                initialValue: _especialistaSeleccionado,
                decoration: const InputDecoration(labelText: 'Profesional'),
                items: especialistas
                    .map((e) => DropdownMenuItem(value: e, child: Text(e.nombre)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _especialistaSeleccionado = value;
                    _horarioSeleccionado = null;
                  });
                },
              ),
            const SizedBox(height: 16),
            if (_especialistaSeleccionado != null)
              _especialistaSeleccionado!.horariosDisponibles.isEmpty
                  ? const Text('Sin horarios disponibles', style: TextStyle(color: Colors.grey))
                  : Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _especialistaSeleccionado!.horariosDisponibles.map((horario) {
                        final seleccionado = horario == _horarioSeleccionado;
                        return ChoiceChip(
                          label: Text(horario),
                          selected: seleccionado,
                          onSelected: (_) => setState(() => _horarioSeleccionado = horario),
                        );
                      }).toList(),
                    ),
            const SizedBox(height: 28),
            ElevatedButton(
              onPressed: _puedeConfirmar()
                  ? () {
                      turnosProvider.agregarTurno(
                        pacienteNombre: _nombreCtrl.text.trim(),
                        especialista: _especialistaSeleccionado!,
                        horario: _horarioSeleccionado!,
                      );
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Turno cargado correctamente')),
                      );
                    }
                  : null,
              child: const Text('Cargar turno'),
            ),
          ],
        ),
      ),
    );
  }
}
