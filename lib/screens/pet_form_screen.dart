import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/pet_provider.dart';
import '../providers/owner_provider.dart';
import '../models/pet.dart';
import '../models/owner.dart';

class PetFormScreen extends StatefulWidget {
  final Pet? pet;

  const PetFormScreen({super.key, this.pet});

  @override
  State<PetFormScreen> createState() => _PetFormScreenState();
}

class _PetFormScreenState extends State<PetFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _breedController;
  late TextEditingController _weightController;
  late TextEditingController _colorController;
  
  String _selectedSpecies = 'Cachorro';
  String _selectedGender = 'Macho';
  DateTime _birthDate = DateTime.now();
  Owner? _selectedOwner;

  final List<String> _species = ['Cachorro', 'Gato', 'Pássaro', 'Coelho', 'Outro'];
  final List<String> _genders = ['Macho', 'Fêmea'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.pet?.name ?? '');
    _breedController = TextEditingController(text: widget.pet?.breed ?? '');
    _weightController = TextEditingController(text: widget.pet?.weight.toString() ?? '');
    _colorController = TextEditingController(text: widget.pet?.color ?? '');
    
    if (widget.pet != null) {
      _selectedSpecies = widget.pet!.species;
      _selectedGender = widget.pet!.gender;
      _birthDate = widget.pet!.birthDate;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _breedController.dispose();
    _weightController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _birthDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _birthDate) {
      setState(() {
        _birthDate = picked;
      });
    }
  }

  Future<void> _savePet() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedOwner == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, selecione um cliente')),
        );
        return;
      }

      final pet = Pet(
        id: widget.pet?.id,
        name: _nameController.text,
        species: _selectedSpecies,
        breed: _breedController.text,
        birthDate: _birthDate,
        gender: _selectedGender,
        weight: double.parse(_weightController.text),
        color: _colorController.text,
        ownerId: _selectedOwner!.id!,
        createdAt: widget.pet?.createdAt,
      );

      if (widget.pet == null) {
        await context.read<PetProvider>().addPet(pet);
      } else {
        await context.read<PetProvider>().updatePet(pet);
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
        title: Text(widget.pet == null ? 'Novo Pet' : 'Editar Pet'),
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
                labelText: 'Nome',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.pets),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o nome';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _selectedSpecies,
              decoration: const InputDecoration(
                labelText: 'Espécie',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category),
              ),
              items: _species.map((species) {
                return DropdownMenuItem(value: species, child: Text(species));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedSpecies = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _breedController,
              decoration: const InputDecoration(
                labelText: 'Raça',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.info),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira a raça';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _selectedGender,
              decoration: const InputDecoration(
                labelText: 'Sexo',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.wc),
              ),
              items: _genders.map((gender) {
                return DropdownMenuItem(value: gender, child: Text(gender));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedGender = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Data de Nascimento'),
              subtitle: Text(DateFormat('dd/MM/yyyy').format(_birthDate)),
              leading: const Icon(Icons.calendar_today),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: BorderSide(color: Colors.grey[400]!),
              ),
              onTap: () => _selectDate(context),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _weightController,
              decoration: const InputDecoration(
                labelText: 'Peso (kg)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.monitor_weight),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o peso';
                }
                if (double.tryParse(value) == null) {
                  return 'Peso inválido';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _colorController,
              decoration: const InputDecoration(
                labelText: 'Cor',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.palette),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira a cor';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Consumer<OwnerProvider>(
              builder: (context, provider, child) {
                return DropdownButtonFormField<Owner>(
                  decoration: const InputDecoration(
                    labelText: 'Cliente',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  items: provider.owners.map((owner) {
                    return DropdownMenuItem(
                      value: owner,
                      child: Text(owner.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedOwner = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor, selecione um cliente';
                    }
                    return null;
                  },
                );
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _savePet,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              child: Text(
                widget.pet == null ? 'Cadastrar' : 'Salvar',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
