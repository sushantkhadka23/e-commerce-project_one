class PaymentService {
  Future<void> processEsewaPayment({
    required double amount,
    required Function(String) onSuccess,
    required Function(String) onFailure,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      onSuccess('esewa-ref-${DateTime.now().millisecondsSinceEpoch}');
    } catch (e) {
      onFailure(e.toString());
    }
  }

  Future<void> processFonepayPayment({
    required double amount,
    required Function(String) onSuccess,
    required Function(String) onFailure,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      onSuccess('khalti-ref-${DateTime.now().millisecondsSinceEpoch}');
    } catch (e) {
      onFailure(e.toString());
    }
  }

  Future<void> processConnectIPSPayment({
    required double amount,
    required Function(String) onSuccess,
    required Function(String) onFailure,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      onSuccess('connectips-ref-${DateTime.now().millisecondsSinceEpoch}');
    } catch (e) {
      onFailure(e.toString());
    }
  }
}
