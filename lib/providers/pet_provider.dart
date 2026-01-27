import 'package:flutter/foundation.dart';
import '../models/pet.dart';
import '../database/database_helper.dart';

class PetProvider with ChangeNotifier {
  List<Pet> _pets = [];
  bool _isLoading = false;

  List<Pet> get pets => _pets;
  bool get isLoading => _isLoading;

  Future<void> loadPets() async {
    _isLoading = true;
    notifyListeners();
    
    _pets = await DatabaseHelper.instance.getAllPets();
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addPet(Pet pet) async {
    await DatabaseHelper.instance.createPet(pet);
    await loadPets();
  }

  Future<void> updatePet(Pet pet) async {
    await DatabaseHelper.instance.updatePet(pet);
    await loadPets();
  }

  Future<void> deletePet(int id) async {
    await DatabaseHelper.instance.deletePet(id);
    await loadPets();
  }

  Future<Pet?> getPet(int id) async {
    return await DatabaseHelper.instance.getPet(id);
  }

  Future<List<Pet>> getPetsByOwner(int ownerId) async {
    return await DatabaseHelper.instance.getPetsByOwner(ownerId);
  }
}
