import 'package:flutter/material.dart';
import 'package:project_one/model/order_item_model.dart';
import 'package:project_one/screens/checkout/address_screen.dart';

class OrderSummaryScreen extends StatelessWidget {
  final double amount;
  final List<OrderItem> orderItems;
  final VoidCallback onConfirmOrder;

  const OrderSummaryScreen({
    super.key,
    required this.amount,
    required this.orderItems,
    required this.onConfirmOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildOrderSummaryCard(),
            const SizedBox(height: 20),
            _buildUserGuidance(),
            const Spacer(),
            _buildConfirmButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummaryCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Total Amount',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'NPR ${amount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 28, color: Colors.green),
            ),
            const SizedBox(height: 16),
            const Text(
              'Order Items',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...orderItems.map(
              (item) => ListTile(
                title: Text(item.name),
                leading: Image.asset(
                  item.imageUrl,
                  width: 100,
                  height: 100,
                ),
                subtitle: Text(
                    'Qty: ${item.quantity} - NPR ${item.price.toStringAsFixed(2)}'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserGuidance() {
    return const Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'To confirm your order, please make sure your payment method is selected and that your address is correct. You will receive a confirmation message shortly after placing your order.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navigate to AddressScreen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddressScreen(
              onAddressSubmitted: (address) {},
            ),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: const TextStyle(fontSize: 18),
      ),
      child: const Text('Confirm Order'),
    );
  }
}
