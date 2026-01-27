import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../models/pet.dart';
import '../models/pet_photo.dart';
import '../database/database_helper.dart';

class PetGalleryScreen extends StatefulWidget {
  final Pet pet;

  const PetGalleryScreen({super.key, required this.pet});

  @override
  State<PetGalleryScreen> createState() => _PetGalleryScreenState();
}

class _PetGalleryScreenState extends State<PetGalleryScreen> {
  List<PetPhoto> _photos = [];
  bool _isLoading = true;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadPhotos();
  }

  Future<void> _loadPhotos() async {
    setState(() {
      _isLoading = true;
    });
    final photos = await DatabaseHelper.instance.getPhotosByPet(widget.pet.id!);
    setState(() {
      _photos = photos;
      _isLoading = false;
    });
  }

  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 85,
    );

    if (photo != null) {
      await _savePhoto(photo.path);
    }
  }

  Future<void> _pickFromGallery() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 85,
    );

    if (photo != null) {
      await _savePhoto(photo.path);
    }
  }

  Future<void> _savePhoto(String path) async {
    final photo = PetPhoto(
      petId: widget.pet.id!,
      photoPath: path,
      category: 'other',
    );

    await DatabaseHelper.instance.createPetPhoto(photo);
    await _loadPhotos();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Foto adicionada com sucesso!')),
      );
    }
  }

  Future<void> _deletePhoto(PetPhoto photo) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: const Text('Deseja realmente excluir esta foto?'),
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

    if (confirm == true) {
      await DatabaseHelper.instance.deletePetPhoto(photo.id!);
      // Tentar deletar o arquivo físico
      try {
        final file = File(photo.photoPath);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (e) {
        // Ignorar erro se não conseguir deletar o arquivo
      }
      await _loadPhotos();
    }
  }

  void _showPhotoOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Tirar Foto'),
              onTap: () {
                Navigator.pop(context);
                _takePhoto();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Escolher da Galeria'),
              onTap: () {
                Navigator.pop(context);
                _pickFromGallery();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fotos de ${widget.pet.name}'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _photos.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.photo_library, size: 80, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        'Nenhuma foto adicionada',
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _showPhotoOptions,
                        icon: const Icon(Icons.add_a_photo),
                        label: const Text('Adicionar Foto'),
                      ),
                    ],
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: _photos.length,
                  itemBuilder: (context, index) {
                    final photo = _photos[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => _PhotoViewScreen(photo: photo),
                          ),
                        );
                      },
                      onLongPress: () => _deletePhoto(photo),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(photo.photoPath),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.broken_image, size: 40),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showPhotoOptions,
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}

class _PhotoViewScreen extends StatelessWidget {
  final PetPhoto photo;

  const _PhotoViewScreen({required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat('dd/MM/yyyy').format(photo.photoDate)),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: InteractiveViewer(
          child: Image.file(
            File(photo.photoPath),
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Icon(Icons.broken_image, size: 80, color: Colors.white),
              );
            },
          ),
        ),
      ),
    );
  }
}
