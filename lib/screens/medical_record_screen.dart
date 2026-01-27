import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/medical_record.dart';
import '../models/appointment.dart';
import '../database/database_helper.dart';

class MedicalRecordScreen extends StatefulWidget {
  final Appointment appointment;

  const MedicalRecordScreen({super.key, required this.appointment});

  @override
  State<MedicalRecordScreen> createState() => _MedicalRecordScreenState();
}

class _MedicalRecordScreenState extends State<MedicalRecordScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _chiefComplaintController;
  late TextEditingController _anamnesisController;
  late TextEditingController _physicalExamController;
  late TextEditingController _temperatureController;
  late TextEditingController _heartRateController;
  late TextEditingController _respiratoryRateController;
  late TextEditingController _weightController;
  late TextEditingController _diagnosisController;
  late TextEditingController _treatmentController;
  late TextEditingController _prognosisController;
  late TextEditingController _observationsController;

  MedicalRecord? _existingRecord;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _chiefComplaintController = TextEditingController();
    _anamnesisController = TextEditingController();
    _physicalExamController = TextEditingController();
    _temperatureController = TextEditingController();
    _heartRateController = TextEditingController();
    _respiratoryRateController = TextEditingController();
    _weightController = TextEditingController();
    _diagnosisController = TextEditingController();
    _treatmentController = TextEditingController();
    _prognosisController = TextEditingController();
    _observationsController = TextEditingController();
    _loadExistingRecord();
  }

  Future<void> _loadExistingRecord() async {
    final record = await DatabaseHelper.instance.getMedicalRecordByAppointment(widget.appointment.id!);
    if (record != null) {
      setState(() {
        _existingRecord = record;
        _chiefComplaintController.text = record.chiefComplaint;
        _anamnesisController.text = record.anamnesis;
        _physicalExamController.text = record.physicalExam;
        _temperatureController.text = record.temperature ?? '';
        _heartRateController.text = record.heartRate ?? '';
        _respiratoryRateController.text = record.respiratoryRate ?? '';
        _weightController.text = record.weight ?? '';
        _diagnosisController.text = record.diagnosis;
        _treatmentController.text = record.treatment;
        _prognosisController.text = record.prognosis ?? '';
        _observationsController.text = record.observations ?? '';
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _chiefComplaintController.dispose();
    _anamnesisController.dispose();
    _physicalExamController.dispose();
    _temperatureController.dispose();
    _heartRateController.dispose();
    _respiratoryRateController.dispose();
    _weightController.dispose();
    _diagnosisController.dispose();
    _treatmentController.dispose();
    _prognosisController.dispose();
    _observationsController.dispose();
    super.dispose();
  }

  Future<void> _saveRecord() async {
    if (_formKey.currentState!.validate()) {
      final record = MedicalRecord(
        id: _existingRecord?.id,
        appointmentId: widget.appointment.id!,
        chiefComplaint: _chiefComplaintController.text,
        anamnesis: _anamnesisController.text,
        physicalExam: _physicalExamController.text,
        temperature: _temperatureController.text.isEmpty ? null : _temperatureController.text,
        heartRate: _heartRateController.text.isEmpty ? null : _heartRateController.text,
        respiratoryRate: _respiratoryRateController.text.isEmpty ? null : _respiratoryRateController.text,
        weight: _weightController.text.isEmpty ? null : _weightController.text,
        diagnosis: _diagnosisController.text,
        treatment: _treatmentController.text,
        prognosis: _prognosisController.text.isEmpty ? null : _prognosisController.text,
        observations: _observationsController.text.isEmpty ? null : _observationsController.text,
        createdAt: _existingRecord?.createdAt,
      );

      if (_existingRecord == null) {
        await DatabaseHelper.instance.createMedicalRecord(record);
      } else {
        await DatabaseHelper.instance.updateMedicalRecord(record);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Prontuário salvo com sucesso!')),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Prontuário Médico'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prontuário Médico'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveRecord,
            tooltip: 'Salvar',
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Consulta: ${widget.appointment.type}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy HH:mm').format(widget.appointment.dateTime),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Anamnese',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _chiefComplaintController,
              decoration: const InputDecoration(
                labelText: 'Queixa Principal',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.report_problem),
              ),
              maxLines: 2,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _anamnesisController,
              decoration: const InputDecoration(
                labelText: 'História Clínica',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.history),
                hintText: 'Histórico, sintomas, duração...',
              ),
              maxLines: 4,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            Text(
              'Exame Físico',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _temperatureController,
                    decoration: const InputDecoration(
                      labelText: 'Temperatura (°C)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.thermostat),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _heartRateController,
                    decoration: const InputDecoration(
                      labelText: 'FC (bpm)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.favorite),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _respiratoryRateController,
                    decoration: const InputDecoration(
                      labelText: 'FR (rpm)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.air),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _weightController,
                    decoration: const InputDecoration(
                      labelText: 'Peso (kg)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.monitor_weight),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _physicalExamController,
              decoration: const InputDecoration(
                labelText: 'Exame Físico Detalhado',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.medical_services),
                hintText: 'Inspeção, palpação, ausculta...',
              ),
              maxLines: 4,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            Text(
              'Diagnóstico e Tratamento',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _diagnosisController,
              decoration: const InputDecoration(
                labelText: 'Diagnóstico',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.assignment),
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _treatmentController,
              decoration: const InputDecoration(
                labelText: 'Tratamento',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.healing),
                hintText: 'Medicações, procedimentos...',
              ),
              maxLines: 4,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _prognosisController,
              decoration: const InputDecoration(
                labelText: 'Prognóstico (Opcional)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.trending_up),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _observationsController,
              decoration: const InputDecoration(
                labelText: 'Observações (Opcional)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.notes),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveRecord,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              child: const Text(
                'Salvar Prontuário',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
