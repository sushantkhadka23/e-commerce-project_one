import 'dart:convert';
import 'package:http/http.dart' as http;

class OrderService {
  final String baseUrl;

  OrderService(this.baseUrl);

  Future<String> placeOrder(
    double amount,
    String paymentMethod,
  ) async {
    final url = Uri.parse('$baseUrl/orders');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'amount': amount,
        'paymentMethod': paymentMethod,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['orderId'] ?? 'Order ID not available';
    } else {
      throw Exception('Failed to place order');
    }
  }
}
