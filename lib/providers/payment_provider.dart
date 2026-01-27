import 'package:flutter/foundation.dart';
import '../models/payment.dart';
import '../database/database_helper.dart';

class PaymentProvider with ChangeNotifier {
  List<Payment> _payments = [];
  bool _isLoading = false;

  List<Payment> get payments => _payments;
  bool get isLoading => _isLoading;

  Future<void> loadPayments() async {
    _isLoading = true;
    notifyListeners();
    
    _payments = await DatabaseHelper.instance.getAllPayments();
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addPayment(Payment payment) async {
    await DatabaseHelper.instance.createPayment(payment);
    await loadPayments();
  }

  Future<void> updatePayment(Payment payment) async {
    await DatabaseHelper.instance.updatePayment(payment);
    await loadPayments();
  }

  Future<void> deletePayment(int id) async {
    await DatabaseHelper.instance.deletePayment(id);
    await loadPayments();
  }

  Future<Payment?> getPayment(int id) async {
    return await DatabaseHelper.instance.getPayment(id);
  }

  Future<List<Payment>> getPaymentsByAppointment(int appointmentId) async {
    return await DatabaseHelper.instance.getPaymentsByAppointment(appointmentId);
  }

  List<Payment> getPaymentsByDate(DateTime date) {
    return _payments.where((payment) {
      return payment.paymentDate.year == date.year &&
             payment.paymentDate.month == date.month &&
             payment.paymentDate.day == date.day;
    }).toList();
  }

  List<Payment> getPaymentsByStatus(String status) {
    return _payments.where((payment) => payment.status == status).toList();
  }

  double getTotalByDate(DateTime date) {
    final paymentsOfDay = getPaymentsByDate(date);
    return paymentsOfDay
        .where((p) => p.status == 'paid')
        .fold(0.0, (sum, payment) => sum + payment.amount);
  }

  Future<double> getTotalRevenue({DateTime? startDate, DateTime? endDate}) async {
    return await DatabaseHelper.instance.getTotalRevenue(
      startDate: startDate,
      endDate: endDate,
    );
  }

  Future<Map<String, double>> getRevenueByPaymentMethod({DateTime? startDate, DateTime? endDate}) async {
    return await DatabaseHelper.instance.getRevenueByPaymentMethod(
      startDate: startDate,
      endDate: endDate,
    );
  }
}
