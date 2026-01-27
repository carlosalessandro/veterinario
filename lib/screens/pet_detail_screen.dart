import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/pet.dart';
import '../providers/pet_provider.dart';
import '../providers/owner_provider.dart';
import '../providers/appointment_provider.dart';
import '../database/database_helper.dart';
import 'pet_form_screen.dart';
import 'vaccine_form_screen.dart';

class PetDetailScreen extends StatelessWidget {
  final Pet pet;

  const PetDetailScreen({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(pet.name),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PetFormScreen(pet: pet),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Confirmar exclusão'),
                    content: const Text('Deseja realmente excluir este pet?'),
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
                  await context.read<PetProvider>().deletePet(pet.id!);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                }
              },
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Informações', icon: Icon(Icons.info)),
              Tab(text: 'Consultas', icon: Icon(Icons.medical_services)),
              Tab(text: 'Vacinas', icon: Icon(Icons.vaccines)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _InfoTab(pet: pet),
            _AppointmentsTab(pet: pet),
            _VaccinesTab(pet: pet),
          ],
        ),
      ),
    );
  }
}

class _InfoTab extends StatelessWidget {
  final Pet pet;

  const _InfoTab({required this.pet});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    child: Icon(
                      pet.species == 'Cachorro' ? Icons.pets : Icons.cruelty_free,
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    pet.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${pet.species} - ${pet.breed}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InfoRow(icon: Icons.cake, label: 'Data de Nascimento', 
                      value: DateFormat('dd/MM/yyyy').format(pet.birthDate)),
                  const Divider(),
                  _InfoRow(icon: Icons.wc, label: 'Sexo', value: pet.gender),
                  const Divider(),
                  _InfoRow(icon: Icons.monitor_weight, label: 'Peso', value: '${pet.weight} kg'),
                  const Divider(),
                  _InfoRow(icon: Icons.palette, label: 'Cor', value: pet.color),
                  const Divider(),
                  FutureBuilder(
                    future: context.read<OwnerProvider>().getOwner(pet.ownerId),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return const SizedBox();
                      return _InfoRow(
                        icon: Icons.person,
                        label: 'Proprietário',
                        value: snapshot.data!.name,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AppointmentsTab extends StatelessWidget {
  final Pet pet;

  const _AppointmentsTab({required this.pet});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<AppointmentProvider>().getAppointmentsByPet(pet.id!),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final appointments = snapshot.data!;
        if (appointments.isEmpty) {
          return const Center(child: Text('Nenhuma consulta registrada'));
        }

        return ListView.builder(
          itemCount: appointments.length,
          itemBuilder: (context, index) {
            final appointment = appointments[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.medical_services),
                title: Text(appointment.type),
                subtitle: Text(
                  '${DateFormat('dd/MM/yyyy HH:mm').format(appointment.dateTime)}\n${appointment.status}',
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

class _VaccinesTab extends StatelessWidget {
  final Pet pet;

  const _VaccinesTab({required this.pet});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseHelper.instance.getVaccinesByPet(pet.id!),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final vaccines = snapshot.data!;
        
        return Column(
          children: [
            Expanded(
              child: vaccines.isEmpty
                  ? const Center(child: Text('Nenhuma vacina registrada'))
                  : ListView.builder(
                      itemCount: vaccines.length,
                      itemBuilder: (context, index) {
                        final vaccine = vaccines[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: ListTile(
                            leading: const Icon(Icons.vaccines),
                            title: Text(vaccine.name),
                            subtitle: Text(
                              'Aplicada em: ${DateFormat('dd/MM/yyyy').format(vaccine.applicationDate)}\n'
                              'Veterinário: ${vaccine.veterinarian}',
                            ),
                            isThreeLine: true,
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VaccineFormScreen(petId: pet.id!),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Adicionar Vacina'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[600]),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
