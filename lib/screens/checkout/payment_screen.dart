import 'package:flutter/material.dart';
import 'package:project_one/model/payment_method_model.dart';
import 'package:project_one/screens/checkout/payment_method_card.dart';
import 'package:project_one/services/payment_service.dart';

class PaymentScreen extends StatefulWidget {
  final double amount;
  final Function(String) onPaymentSuccess;
  final VoidCallback onPaymentCancel;

  const PaymentScreen({
    super.key,
    required this.amount,
    required this.onPaymentSuccess,
    required this.onPaymentCancel,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final PaymentService _paymentService = PaymentService();
  String? _selectedPaymentMethod;
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Payment Method'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildAmountCard(),
                    const SizedBox(height: 16),
                    _buildPaymentMethods(),
                  ],
                ),
              ),
            ),
            _buildBottomButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Amount to Pay',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Rs. ${widget.amount.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Text(
            'Available Payment Methods',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        ...PaymentMethod.getAvailableMethods().map((method) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: PaymentMethodCard(
              method: method,
              isSelected: _selectedPaymentMethod == method.id,
              onSelected: (selected) {
                setState(() {
                  _selectedPaymentMethod = selected ? method.id : null;
                });
              },
            ),
          );
        }),
      ],
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      onPressed: _selectedPaymentMethod == null || _isProcessing
          ? null
          : _handlePayment,
      child: _isProcessing
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(
              _getPaymentButtonText(),
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
    );
  }

  String _getPaymentButtonText() {
    switch (_selectedPaymentMethod) {
      case 'esewa':
        return 'Pay with eSewa';
      case 'fonepay':
        return 'Pay with fonepay';
      case 'cod':
        return 'Confirm Cash on Delivery';
      default:
        return 'Select Payment Method';
    }
  }

  Future<void> _handlePayment() async {
    setState(() => _isProcessing = true);

    try {
      switch (_selectedPaymentMethod) {
        case 'esewa':
          await _paymentService.processEsewaPayment(
            amount: widget.amount,
            onSuccess: widget.onPaymentSuccess,
            onFailure: _handlePaymentFailure,
          );
          break;
        case 'fonepay':
          await _paymentService.processFonepayPayment(
            amount: widget.amount,
            onSuccess: widget.onPaymentSuccess,
            onFailure: _handlePaymentFailure,
          );
          break;
        case 'connectips':
          await _paymentService.processConnectIPSPayment(
            amount: widget.amount,
            onSuccess: widget.onPaymentSuccess,
            onFailure: _handlePaymentFailure,
          );
          break;
        case 'cod':
          await _processCashOnDelivery();
          break;
      }
    } catch (e) {
      _handlePaymentFailure(e.toString());
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  Future<void> _processCashOnDelivery() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Cash on Delivery'),
        content: const Text(
          'By selecting Cash on Delivery, you agree to pay the full amount when your order is delivered.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      widget.onPaymentSuccess('cod');
    }
  }

  void _handlePaymentFailure(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment failed: $error'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }
}
