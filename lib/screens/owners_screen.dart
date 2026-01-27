import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/owner_provider.dart';
import 'owner_form_screen.dart';
import 'owner_detail_screen.dart';

class OwnersScreen extends StatelessWidget {
  const OwnersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Consumer<OwnerProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.owners.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhum cliente cadastrado',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: provider.owners.length,
            itemBuilder: (context, index) {
              final owner = provider.owners[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(owner.name[0].toUpperCase()),
                  ),
                  title: Text(owner.name),
                  subtitle: Text('${owner.phone}\n${owner.email}'),
                  isThreeLine: true,
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OwnerDetailScreen(owner: owner),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OwnerFormScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
