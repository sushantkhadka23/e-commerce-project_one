import 'package:flutter/material.dart';
import 'package:project_one/model/address_model.dart';
import 'package:project_one/screens/checkout/payment_screen.dart';
import 'package:project_one/widgets/address_form.dart';

class AddressScreen extends StatefulWidget {
  final Address? initialAddress;
  final Function(Address) onAddressSubmitted;

  const AddressScreen({
    super.key,
    this.initialAddress,
    required this.onAddressSubmitted,
  });
  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Address'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: AddressForm(
                    formKey: _formKey,
                    initialAddress: widget.initialAddress,
                    onSubmit: _handleAddressSubmit,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isLoading ? null : _handleContinue,
                child: _isLoading
                    ? const CircularProgressIndicator.adaptive()
                    : const Text('Continue to Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleAddressSubmit(Address address) async {
    setState(() => _isLoading = true);
    try {
      // Simulate API call to validate address
      await Future.delayed(const Duration(milliseconds: 500));
      // Call the onAddressSubmitted function
      widget.onAddressSubmitted(address);
    } catch (e) {
      _showErrorSnackbar('Error: ${e.toString()}');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _handleContinue() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      _navigateToPaymentScreen();
    }
  }

  void _navigateToPaymentScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(
          amount: 3000.00,
          onPaymentSuccess: (paymentMethod) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Payment successful with: $paymentMethod')),
            );
          },
          onPaymentCancel: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Payment cancelled')),
            );
          },
        ),
      ),
    );
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
