class PaymentMethod {
  final String id;
  final String name;
  final String logoAsset;
  final String description;
  final bool isEnabled;

  const PaymentMethod({
    required this.id,
    required this.name,
    required this.logoAsset,
    required this.description,
    this.isEnabled = true,
  });

  static List<PaymentMethod> getAvailableMethods() {
    return [
      const PaymentMethod(
        id: 'esewa',
        name: 'eSewa',
        logoAsset: 'assets/icons/esewa.png',
        description: 'Pay using eSewa mobile wallet',
      ),
      const PaymentMethod(
        id: 'fonepay',
        name: 'fonepay',
        logoAsset: 'assets/icons/fonepay.png',
        description: 'Pay using fonepay digital wallet',
      ),
      const PaymentMethod(
        id: 'cod',
        name: 'Cash on Delivery',
        logoAsset: 'assets/icons/cash_on_delivery.jpg',
        description: 'Pay when you receive your order',
      ),
    ];
  }
}
