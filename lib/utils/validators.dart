class Validators {
  static String? Function(String?) required(String message) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return message;
      }
      return null;
    };
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (value.length != 10) {
      return 'Phone number must be 10 digits';
    }
    if (!RegExp(r'^98\d{8}$').hasMatch(value)) {
      return 'Invalid phone number';
    }
    return null;
  }
}
