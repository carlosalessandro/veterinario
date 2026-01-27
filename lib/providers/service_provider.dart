import 'package:flutter/foundation.dart';
import '../models/service.dart';
import '../database/database_helper.dart';

class ServiceProvider with ChangeNotifier {
  List<Service> _services = [];
  bool _isLoading = false;

  List<Service> get services => _services;
  bool get isLoading => _isLoading;

  Future<void> loadServices() async {
    _isLoading = true;
    notifyListeners();
    
    _services = await DatabaseHelper.instance.getAllServices();
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addService(Service service) async {
    await DatabaseHelper.instance.createService(service);
    await loadServices();
  }

  Future<void> updateService(Service service) async {
    await DatabaseHelper.instance.updateService(service);
    await loadServices();
  }

  Future<void> deleteService(int id) async {
    await DatabaseHelper.instance.deleteService(id);
    await loadServices();
  }

  Future<Service?> getService(int id) async {
    return await DatabaseHelper.instance.getService(id);
  }

  List<Service> getServicesByCategory(String category) {
    return _services.where((service) => service.category == category).toList();
  }
}
