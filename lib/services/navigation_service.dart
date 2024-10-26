import 'package:flutter/material.dart';
import 'package:project_one/model/payment_method_model.dart';
import '../screens/checkout/payment_screen.dart';
import '../screens/checkout/order_summary_screen.dart';
import '../screens/checkout/order_confirmation_screen.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<void> navigateToPaymentScreen(
    double amount,
    Function(String) onPaymentSuccess,
    VoidCallback onPaymentCancel,
  ) async {
    await navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => PaymentScreen(
          amount: amount,
          onPaymentSuccess: onPaymentSuccess,
          onPaymentCancel: onPaymentCancel,
        ),
      ),
    );
  }

  static Future<void> navigateToOrderSummaryScreen(
    double amount,
    PaymentMethod selectedPaymentMethod,
    VoidCallback onConfirmOrder,
  ) async {
    await navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => OrderSummaryScreen(
          orderItems: const [],
          amount: amount,
          onConfirmOrder: onConfirmOrder,
        ),
      ),
    );
  }

  static Future<void> navigateToOrderConfirmationScreen() async {
    await navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => const OrderConfirmationScreen(),
      ),
    );
  }
}
