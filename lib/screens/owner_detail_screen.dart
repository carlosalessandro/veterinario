import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/owner.dart';
import '../providers/owner_provider.dart';
import '../providers/pet_provider.dart';
import 'owner_form_screen.dart';
import 'pet_detail_screen.dart';

class OwnerDetailScreen extends StatelessWidget {
  final Owner owner;

  const OwnerDetailScreen({super.key, required this.owner});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(owner.name),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OwnerFormScreen(owner: owner),
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
                  content: const Text('Deseja realmente excluir este cliente?'),
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
                await context.read<OwnerProvider>().deleteOwner(owner.id!);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _InfoRow(icon: Icons.person, label: 'Nome', value: owner.name),
                    const Divider(),
                    _InfoRow(icon: Icons.email, label: 'Email', value: owner.email),
                    const Divider(),
                    _InfoRow(icon: Icons.phone, label: 'Telefone', value: owner.phone),
                    const Divider(),
                    _InfoRow(icon: Icons.badge, label: 'CPF', value: owner.cpf),
                    const Divider(),
                    _InfoRow(icon: Icons.home, label: 'Endereço', value: owner.address),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Pets',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            FutureBuilder(
              future: context.read<PetProvider>().getPetsByOwner(owner.id!),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final pets = snapshot.data!;
                if (pets.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: Text('Nenhum pet cadastrado')),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: pets.length,
                  itemBuilder: (context, index) {
                    final pet = pets[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Icon(
                            pet.species == 'Cachorro' ? Icons.pets : Icons.cruelty_free,
                          ),
                        ),
                        title: Text(pet.name),
                        subtitle: Text('${pet.species} - ${pet.breed}'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PetDetailScreen(pet: pet),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
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
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
