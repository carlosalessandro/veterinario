import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/payment_provider.dart';
import '../providers/appointment_provider.dart';
import '../providers/service_provider.dart';
import '../models/payment.dart';
import '../models/appointment.dart';
import '../models/service.dart';

class PaymentFormScreen extends StatefulWidget {
  final Payment? payment;

  const PaymentFormScreen({super.key, this.payment});

  @override
  State<PaymentFormScreen> createState() => _PaymentFormScreenState();
}

class _PaymentFormScreenState extends State<PaymentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _amountController;
  late TextEditingController _notesController;
  
  Appointment? _selectedAppointment;
  Service? _selectedService;
  String _selectedPaymentMethod = 'cash';
  String _selectedStatus = 'paid';
  DateTime _paymentDate = DateTime.now();

  final List<Map<String, String>> _paymentMethods = [
    {'value': 'cash', 'label': 'Dinheiro'},
    {'value': 'credit', 'label': 'Cartão de Crédito'},
    {'value': 'debit', 'label': 'Cartão de Débito'},
    {'value': 'pix', 'label': 'PIX'},
  ];

  final List<Map<String, String>> _statuses = [
    {'value': 'paid', 'label': 'Pago'},
    {'value': 'pending', 'label': 'Pendente'},
    {'value': 'cancelled', 'label': 'Cancelado'},
  ];

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(text: widget.payment?.amount.toString() ?? '');
    _notesController = TextEditingController(text: widget.payment?.notes ?? '');
    
    if (widget.payment != null) {
      _selectedPaymentMethod = widget.payment!.paymentMethod;
      _selectedStatus = widget.payment!.status;
      _paymentDate = widget.payment!.paymentDate;
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _savePayment() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedAppointment == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, selecione uma consulta')),
        );
        return;
      }

      final payment = Payment(
        id: widget.payment?.id,
        appointmentId: _selectedAppointment!.id!,
        serviceId: _selectedService?.id,
        amount: double.parse(_amountController.text),
        paymentMethod: _selectedPaymentMethod,
        status: _selectedStatus,
        paymentDate: _paymentDate,
        notes: _notesController.text.isEmpty ? null : _notesController.text,
        createdAt: widget.payment?.createdAt,
      );

      if (widget.payment == null) {
        await context.read<PaymentProvider>().addPayment(payment);
      } else {
        await context.read<PaymentProvider>().updatePayment(payment);
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
        title: Text(widget.payment == null ? 'Novo Pagamento' : 'Editar Pagamento'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Consumer<AppointmentProvider>(
              builder: (context, provider, child) {
                return DropdownButtonFormField<Appointment>(
                  decoration: const InputDecoration(
                    labelText: 'Consulta',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.medical_services),
                  ),
                  items: provider.appointments.map((appointment) {
                    return DropdownMenuItem(
                      value: appointment,
                      child: Text('${appointment.type} - ${DateFormat('dd/MM/yyyy').format(appointment.dateTime)}'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedAppointment = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor, selecione uma consulta';
                    }
                    return null;
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            Consumer<ServiceProvider>(
              builder: (context, provider, child) {
                return DropdownButtonFormField<Service>(
                  decoration: const InputDecoration(
                    labelText: 'Serviço (Opcional)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.list),
                  ),
                  items: provider.services.map((service) {
                    return DropdownMenuItem(
                      value: service,
                      child: Text('${service.name} - ${NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(service.price)}'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedService = value;
                      if (value != null) {
                        _amountController.text = value.price.toString();
                      }
                    });
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Valor (R\$)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o valor';
                }
                if (double.tryParse(value) == null) {
                  return 'Valor inválido';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _selectedPaymentMethod,
              decoration: const InputDecoration(
                labelText: 'Forma de Pagamento',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.payment),
              ),
              items: _paymentMethods.map((method) {
                return DropdownMenuItem(
                  value: method['value'],
                  child: Text(method['label']!),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _selectedStatus,
              decoration: const InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.info),
              ),
              items: _statuses.map((status) {
                return DropdownMenuItem(
                  value: status['value'],
                  child: Text(status['label']!),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Observações',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.notes),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _savePayment,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              child: Text(
                widget.payment == null ? 'Registrar' : 'Salvar',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
