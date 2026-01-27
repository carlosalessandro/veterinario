import 'package:flutter/foundation.dart';
import '../models/appointment.dart';
import '../database/database_helper.dart';

class AppointmentProvider with ChangeNotifier {
  List<Appointment> _appointments = [];
  bool _isLoading = false;

  List<Appointment> get appointments => _appointments;
  bool get isLoading => _isLoading;

  Future<void> loadAppointments() async {
    _isLoading = true;
    notifyListeners();
    
    _appointments = await DatabaseHelper.instance.getAllAppointments();
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addAppointment(Appointment appointment) async {
    await DatabaseHelper.instance.createAppointment(appointment);
    await loadAppointments();
  }

  Future<void> updateAppointment(Appointment appointment) async {
    await DatabaseHelper.instance.updateAppointment(appointment);
    await loadAppointments();
  }

  Future<void> deleteAppointment(int id) async {
    await DatabaseHelper.instance.deleteAppointment(id);
    await loadAppointments();
  }

  Future<List<Appointment>> getAppointmentsByPet(int petId) async {
    return await DatabaseHelper.instance.getAppointmentsByPet(petId);
  }

  List<Appointment> getAppointmentsByDate(DateTime date) {
    return _appointments.where((appointment) {
      return appointment.dateTime.year == date.year &&
             appointment.dateTime.month == date.month &&
             appointment.dateTime.day == date.day;
    }).toList();
  }
}
