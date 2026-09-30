import 'package:flutter/material.dart';

class AltaPacienteScreen extends StatefulWidget {
  const AltaPacienteScreen({super.key});

  @override
  State<AltaPacienteScreen> createState() => _AltaPacienteScreenState();
}

class _AltaPacienteScreenState extends State<AltaPacienteScreen> {
  static const verdeOscuro = Color(0xFF1F5F5B);
  static const crema = Color(0xFFF5F1E8);

  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _apellidoCtrl = TextEditingController();
  final _dniCtrl = TextEditingController();
  final _telefonoCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _obraSocialCtrl = TextEditingController();

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _apellidoCtrl.dispose();
    _dniCtrl.dispose();
    _telefonoCtrl.dispose();
    _emailCtrl.dispose();
    _obraSocialCtrl.dispose();
    super.dispose();
  }

  void _darDeAlta() {
    if (!_formKey.currentState!.validate()) return;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Paciente dado de alta'),
        content: Text(
          '${_nombreCtrl.text.trim()} ${_apellidoCtrl.text.trim()} '
          'fue registrado/a correctamente.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: crema,
      appBar: AppBar(
        backgroundColor: verdeOscuro,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Alta de paciente',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Datos del paciente',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F1F1F),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nombreCtrl,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (v) => (v == null || v.isEmpty) ? 'Requerido' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _apellidoCtrl,
                decoration: const InputDecoration(labelText: 'Apellido'),
                validator: (v) => (v == null || v.isEmpty) ? 'Requerido' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _dniCtrl,
                decoration: const InputDecoration(labelText: 'DNI'),
                keyboardType: TextInputType.number,
                validator: (v) => (v == null || v.isEmpty) ? 'Requerido' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _telefonoCtrl,
                decoration: const InputDecoration(labelText: 'Teléfono'),
                keyboardType: TextInputType.phone,
                validator: (v) => (v == null || v.isEmpty) ? 'Requerido' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (v) => (v == null || v.isEmpty) ? 'Requerido' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _obraSocialCtrl,
                decoration: const InputDecoration(labelText: 'Obra social (opcional)'),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: verdeOscuro,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _darDeAlta,
                  child: const Text(
                    'Dar de alta',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
