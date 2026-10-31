import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/especialista.dart';
import '../../providers/turnos_provider.dart';
import '../../widgets/barra_navegacion_paciente.dart';
import 'confirmacion_turno_screen.dart';

class SeleccionHorarioScreen extends StatefulWidget {
  final String especialidad;
  const SeleccionHorarioScreen({super.key, required this.especialidad});

  @override
  State<SeleccionHorarioScreen> createState() => _SeleccionHorarioScreenState();
}

class _SeleccionHorarioScreenState extends State<SeleccionHorarioScreen> {
  static const verdeOscuro = Color(0xFF1F5F5B);
  static const verdeSuave = Color(0xFFD9EDE9);
  static const crema = Color(0xFFF5F1E8);

  DateTime _fechaSeleccionada = DateTime.now();
  Especialista? _especialistaSeleccionado;
  String? _horarioSeleccionado;

  @override
  Widget build(BuildContext context) {
    final especialistas =
        context.watch<TurnosProvider>().especialistasPorEspecialidad(widget.especialidad);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: crema,
        appBar: AppBar(
          backgroundColor: crema,
          elevation: 0,
          foregroundColor: verdeOscuro,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            widget.especialidad,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ---------- CALENDARIO ----------
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(8),
              child: CalendarDatePicker(
                initialDate: _fechaSeleccionada,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                onDateChanged: (fecha) {
                  setState(() {
                    _fechaSeleccionada = fecha;
                    _especialistaSeleccionado = null;
                    _horarioSeleccionado = null;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),

            // ---------- ESPECIALISTAS DISPONIBLES ESE DÍA ----------
            const Text(
              'Especialistas disponibles',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'serif',
                color: Color(0xFF1F1F1F),
              ),
            ),
            const SizedBox(height: 12),

            ...especialistas.map((e) {
              final atiende = context.read<TurnosProvider>().especialistaAtiende(e, _fechaSeleccionada);
              if (!atiende) return const SizedBox.shrink();

              final seleccionado = _especialistaSeleccionado?.id == e.id;
              final horariosLibres = context.read<TurnosProvider>().horariosLibres(e, _fechaSeleccionada);

              return Card(
                margin: const EdgeInsets.only(bottom: 14),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _especialistaSeleccionado = e;
                            _horarioSeleccionado = null;
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              seleccionado
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_unchecked,
                              color: verdeOscuro,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                e.nombre,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (seleccionado) ...[
                        const SizedBox(height: 12),
                        horariosLibres.isEmpty
                            ? const Text(
                                'Sin horarios disponibles ese día',
                                style: TextStyle(color: Colors.grey),
                              )
                            : Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: horariosLibres.map((horario) {
                                  final elegido = horario == _horarioSeleccionado;
                                  return ChoiceChip(
                                    label: Text(horario),
                                    selected: elegido,
                                    selectedColor: verdeSuave,
                                    labelStyle: TextStyle(
                                      color: elegido ? verdeOscuro : Colors.black87,
                                      fontWeight: elegido ? FontWeight.bold : FontWeight.normal,
                                    ),
                                    onSelected: (_) {
                                      setState(() => _horarioSeleccionado = horario);
                                    },
                                  );
                                }).toList(),
                              ),
                      ],
                    ],
                  ),
                ),
              );
            }),

            if (especialistas.every((e) =>
                !context.read<TurnosProvider>().especialistaAtiende(e, _fechaSeleccionada)))
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'No hay especialistas disponibles ese día. Probá con otra fecha.',
                  style: TextStyle(color: Colors.black54),
                ),
              ),

            const SizedBox(height: 24),

            // ---------- BOTÓN CONTINUAR ----------
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: verdeOscuro,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: (_especialistaSeleccionado != null && _horarioSeleccionado != null)
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ConfirmacionTurnoScreen(
                            especialista: _especialistaSeleccionado!,
                            fecha: _fechaSeleccionada,
                            horario: _horarioSeleccionado!,
                          ),
                        ),
                      );
                    }
                  : null,
              child: const Text(
                'Continuar',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BarraNavegacionPaciente(indiceActivo: 0),
      ),
    );
  }
}

