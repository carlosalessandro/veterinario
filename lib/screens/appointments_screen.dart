import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../providers/appointment_provider.dart';
import '../providers/pet_provider.dart';
import 'appointment_form_screen.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultas'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Consumer<AppointmentProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                calendarFormat: CalendarFormat.month,
                eventLoader: (day) {
                  return provider.getAppointmentsByDate(day);
                },
                calendarStyle: const CalendarStyle(
                  markersMaxCount: 3,
                  markerDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const Divider(),
              Expanded(
                child: _selectedDay != null
                    ? _buildAppointmentsList(provider, _selectedDay!)
                    : _buildAllAppointmentsList(provider),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AppointmentFormScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildAppointmentsList(AppointmentProvider provider, DateTime date) {
    final appointments = provider.getAppointmentsByDate(date);

    if (appointments.isEmpty) {
      return Center(
        child: Text(
          'Nenhuma consulta em ${DateFormat('dd/MM/yyyy').format(date)}',
        ),
      );
    }

    return ListView.builder(
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return FutureBuilder(
          future: context.read<PetProvider>().getPet(appointment.petId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const SizedBox();
            final pet = snapshot.data!;

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(
                    pet.species == 'Cachorro' ? Icons.pets : Icons.cruelty_free,
                  ),
                ),
                title: Text(pet.name),
                subtitle: Text(
                  '${DateFormat('HH:mm').format(appointment.dateTime)} - ${appointment.type}\n${appointment.status}',
                ),
                isThreeLine: true,
                trailing: PopupMenuButton(
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Text('Editar'),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text('Excluir'),
                    ),
                  ],
                  onSelected: (value) async {
                    if (value == 'delete') {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Confirmar exclusão'),
                          content: const Text('Deseja realmente excluir esta consulta?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Excluir'),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true && context.mounted) {
                        await context.read<AppointmentProvider>()
                            .deleteAppointment(appointment.id!);
                      }
                    } else if (value == 'edit') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppointmentFormScreen(
                            appointment: appointment,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildAllAppointmentsList(AppointmentProvider provider) {
    if (provider.appointments.isEmpty) {
      return const Center(child: Text('Nenhuma consulta agendada'));
    }

    return ListView.builder(
      itemCount: provider.appointments.length,
      itemBuilder: (context, index) {
        final appointment = provider.appointments[index];
        return FutureBuilder(
          future: context.read<PetProvider>().getPet(appointment.petId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const SizedBox();
            final pet = snapshot.data!;

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(
                    pet.species == 'Cachorro' ? Icons.pets : Icons.cruelty_free,
                  ),
                ),
                title: Text(pet.name),
                subtitle: Text(
                  '${DateFormat('dd/MM/yyyy HH:mm').format(appointment.dateTime)}\n${appointment.type} - ${appointment.status}',
                ),
                isThreeLine: true,
              ),
            );
          },
        );
      },
    );
  }
}
