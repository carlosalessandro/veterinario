import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/vaccine.dart';
import '../database/database_helper.dart';

class VaccineFormScreen extends StatefulWidget {
  final int petId;

  const VaccineFormScreen({super.key, required this.petId});

  @override
  State<VaccineFormScreen> createState() => _VaccineFormScreenState();
}

class _VaccineFormScreenState extends State<VaccineFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _batchController;
  late TextEditingController _veterinarianController;
  late TextEditingController _notesController;
  
  DateTime _applicationDate = DateTime.now();
  DateTime? _nextDoseDate;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _batchController = TextEditingController();
    _veterinarianController = TextEditingController();
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _batchController.dispose();
    _veterinarianController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isNextDose) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isNextDose ? (_nextDoseDate ?? DateTime.now()) : _applicationDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isNextDose) {
          _nextDoseDate = picked;
        } else {
          _applicationDate = picked;
        }
      });
    }
  }

  Future<void> _saveVaccine() async {
    if (_formKey.currentState!.validate()) {
      final vaccine = Vaccine(
        petId: widget.petId,
        name: _nameController.text,
        applicationDate: _applicationDate,
        nextDoseDate: _nextDoseDate,
        batch: _batchController.text,
        veterinarian: _veterinarianController.text,
        notes: _notesController.text.isEmpty ? null : _notesController.text,
      );

      await DatabaseHelper.instance.createVaccine(vaccine);

      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Vacina'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nome da Vacina',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.vaccines),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o nome da vacina';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Data de Aplicação'),
              subtitle: Text(DateFormat('dd/MM/yyyy').format(_applicationDate)),
              leading: const Icon(Icons.calendar_today),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: BorderSide(color: Colors.grey[400]!),
              ),
              onTap: () => _selectDate(context, false),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Próxima Dose (Opcional)'),
              subtitle: Text(
                _nextDoseDate != null 
                    ? DateFormat('dd/MM/yyyy').format(_nextDoseDate!)
                    : 'Não definida',
              ),
              leading: const Icon(Icons.event),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: BorderSide(color: Colors.grey[400]!),
              ),
              onTap: () => _selectDate(context, true),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _batchController,
              decoration: const InputDecoration(
                labelText: 'Lote',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.qr_code),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o lote';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _veterinarianController,
              decoration: const InputDecoration(
                labelText: 'Veterinário',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.medical_services),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o nome do veterinário';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Observações (Opcional)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.notes),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveVaccine,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              child: const Text(
                'Salvar Vacina',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
