import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/pet_provider.dart';
import '../providers/owner_provider.dart';
import '../providers/appointment_provider.dart';
import '../providers/auth_provider.dart';
import 'login_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final username = authProvider.username;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          if (username != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 16,
                    child: Icon(Icons.person, size: 20),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    username,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) async {
              if (value == 'logout') {
                await authProvider.signOut();
                if (context.mounted) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                }
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 8),
                    Text('Sair'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Consumer3<PetProvider, OwnerProvider, AppointmentProvider>(
        builder: (context, petProvider, ownerProvider, appointmentProvider, _) {
          final todayAppointments = appointmentProvider.appointments.where((apt) {
            final now = DateTime.now();
            return apt.dateTime.year == now.year &&
                   apt.dateTime.month == now.month &&
                   apt.dateTime.day == now.day;
          }).toList();

          final pendingAppointments = appointmentProvider.appointments
              .where((apt) => apt.status == 'Agendada')
              .length;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bem-vindo ao Sistema Veterinário',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 24),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _StatCard(
                      title: 'Total de Pets',
                      value: '${petProvider.pets.length}',
                      icon: Icons.pets,
                      color: Colors.blue,
                    ),
                    _StatCard(
                      title: 'Clientes',
                      value: '${ownerProvider.owners.length}',
                      icon: Icons.people,
                      color: Colors.green,
                    ),
                    _StatCard(
                      title: 'Consultas Hoje',
                      value: '${todayAppointments.length}',
                      icon: Icons.calendar_today,
                      color: Colors.orange,
                    ),
                    _StatCard(
                      title: 'Pendentes',
                      value: '$pendingAppointments',
                      icon: Icons.pending_actions,
                      color: Colors.purple,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Consultas de Hoje',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                if (todayAppointments.isEmpty)
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: Text('Nenhuma consulta agendada para hoje'),
                      ),
                    ),
                  )
                else
                  ...todayAppointments.map((appointment) {
                    return FutureBuilder(
                      future: petProvider.getPet(appointment.petId),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const SizedBox();
                        final pet = snapshot.data!;
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Icon(
                                pet.species == 'Cachorro' ? Icons.pets : Icons.cruelty_free,
                              ),
                            ),
                            title: Text(pet.name),
                            subtitle: Text(
                              '${DateFormat('HH:mm').format(appointment.dateTime)} - ${appointment.type}',
                            ),
                            trailing: Chip(
                              label: Text(appointment.status),
                              backgroundColor: _getStatusColor(appointment.status),
                            ),
                          ),
                        );
                      },
                    );
                  }),
              ],
            ),
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Agendada':
        return Colors.blue.shade100;
      case 'Concluída':
        return Colors.green.shade100;
      case 'Cancelada':
        return Colors.red.shade100;
      default:
        return Colors.grey.shade100;
    }
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
