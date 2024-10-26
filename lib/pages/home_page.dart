import 'package:flutter/material.dart';
import 'package:project_one/model/order_item_model.dart';
import 'package:project_one/screens/checkout/order_summary_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UI Demo for Checkout Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'This is a UI demo for the checkout screen.',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to OrderSummaryScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderSummaryScreen(
                      orderItems: [
                        OrderItem(
                          name: 'Straw Hat',
                          price: 3000,
                          quantity: 2,
                          imageUrl: 'assets/images/hat.jpg',
                        ),
                      ],
                      amount: 3000,
                      onConfirmOrder: () {
                        // Handle the order confirmation logic
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Order confirmed! Proceed to payment.'),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
              child: const Text('Start Checkout Flow'),
            ),
          ],
        ),
      ),
    );
  }
}
