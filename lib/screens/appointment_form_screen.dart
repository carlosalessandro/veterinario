import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/appointment_provider.dart';
import '../providers/pet_provider.dart';
import '../models/appointment.dart';
import '../models/pet.dart';

class AppointmentFormScreen extends StatefulWidget {
  final Appointment? appointment;

  const AppointmentFormScreen({super.key, this.appointment});

  @override
  State<AppointmentFormScreen> createState() => _AppointmentFormScreenState();
}

class _AppointmentFormScreenState extends State<AppointmentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _notesController;
  late TextEditingController _diagnosisController;
  late TextEditingController _treatmentController;
  
  Pet? _selectedPet;
  String _selectedType = 'Consulta';
  String _selectedStatus = 'Agendada';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  final List<String> _types = [
    'Consulta',
    'Vacinação',
    'Cirurgia',
    'Exame',
    'Retorno',
    'Emergência',
  ];

  final List<String> _statuses = [
    'Agendada',
    'Confirmada',
    'Em Atendimento',
    'Concluída',
    'Cancelada',
  ];

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController(text: widget.appointment?.notes ?? '');
    _diagnosisController = TextEditingController(text: widget.appointment?.diagnosis ?? '');
    _treatmentController = TextEditingController(text: widget.appointment?.treatment ?? '');
    
    if (widget.appointment != null) {
      _selectedType = widget.appointment!.type;
      _selectedStatus = widget.appointment!.status;
      _selectedDate = widget.appointment!.dateTime;
      _selectedTime = TimeOfDay.fromDateTime(widget.appointment!.dateTime);
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    _diagnosisController.dispose();
    _treatmentController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _saveAppointment() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedPet == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, selecione um pet')),
        );
        return;
      }

      final dateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      final appointment = Appointment(
        id: widget.appointment?.id,
        petId: _selectedPet!.id!,
        dateTime: dateTime,
        type: _selectedType,
        status: _selectedStatus,
        notes: _notesController.text.isEmpty ? null : _notesController.text,
        diagnosis: _diagnosisController.text.isEmpty ? null : _diagnosisController.text,
        treatment: _treatmentController.text.isEmpty ? null : _treatmentController.text,
        createdAt: widget.appointment?.createdAt,
      );

      if (widget.appointment == null) {
        await context.read<AppointmentProvider>().addAppointment(appointment);
      } else {
        await context.read<AppointmentProvider>().updateAppointment(appointment);
      }

      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appointment == null ? 'Nova Consulta' : 'Editar Consulta'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Consumer<PetProvider>(
              builder: (context, provider, child) {
                return DropdownButtonFormField<Pet>(
                  decoration: const InputDecoration(
                    labelText: 'Pet',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.pets),
                  ),
                  items: provider.pets.map((pet) {
                    return DropdownMenuItem(
                      value: pet,
                      child: Text(pet.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPet = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor, selecione um pet';
                    }
                    return null;
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _selectedType,
              decoration: const InputDecoration(
                labelText: 'Tipo de Consulta',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.medical_services),
              ),
              items: _types.map((type) {
                return DropdownMenuItem(value: type, child: Text(type));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedType = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _selectedStatus,
              decoration: const InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.info),
              ),
              items: _statuses.map((status) {
                return DropdownMenuItem(value: status, child: Text(status));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('Data'),
                    subtitle: Text(DateFormat('dd/MM/yyyy').format(_selectedDate)),
                    leading: const Icon(Icons.calendar_today),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                      side: BorderSide(color: Colors.grey[400]!),
                    ),
                    onTap: () => _selectDate(context),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ListTile(
                    title: const Text('Hora'),
                    subtitle: Text(_selectedTime.format(context)),
                    leading: const Icon(Icons.access_time),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                      side: BorderSide(color: Colors.grey[400]!),
                    ),
                    onTap: () => _selectTime(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Observações',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.notes),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _diagnosisController,
              decoration: const InputDecoration(
                labelText: 'Diagnóstico',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _treatmentController,
              decoration: const InputDecoration(
                labelText: 'Tratamento',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.healing),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveAppointment,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              child: Text(
                widget.appointment == null ? 'Agendar' : 'Salvar',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
