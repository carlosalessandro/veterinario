import 'package:flutter/foundation.dart';
import '../models/owner.dart';
import '../database/database_helper.dart';

class OwnerProvider with ChangeNotifier {
  List<Owner> _owners = [];
  bool _isLoading = false;

  List<Owner> get owners => _owners;
  bool get isLoading => _isLoading;

  Future<void> loadOwners() async {
    _isLoading = true;
    notifyListeners();
    
    _owners = await DatabaseHelper.instance.getAllOwners();
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addOwner(Owner owner) async {
    await DatabaseHelper.instance.createOwner(owner);
    await loadOwners();
  }

  Future<void> updateOwner(Owner owner) async {
    await DatabaseHelper.instance.updateOwner(owner);
    await loadOwners();
  }

  Future<void> deleteOwner(int id) async {
    await DatabaseHelper.instance.deleteOwner(id);
    await loadOwners();
  }

  Future<Owner?> getOwner(int id) async {
    return await DatabaseHelper.instance.getOwner(id);
  }
}
