class Address {
  final String fullName;
  final String phone;
  final String province;
  final String district;
  final String city;
  final String streetAddress;
  final String landmark;

  Address({
    required this.fullName,
    required this.phone,
    required this.province,
    required this.district,
    required this.city,
    required this.streetAddress,
    required this.landmark,
  });

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'phone': phone,
      'province': province,
      'district': district,
      'city': city,
      'street_address': streetAddress,
      'landmark': landmark,
    };
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      fullName: json['full_name'] as String,
      phone: json['phone'] as String,
      province: json['province'] as String,
      district: json['district'] as String,
      city: json['city'] as String,
      streetAddress: json['street_address'] as String,
      landmark: json['landmark'] as String,
    );
  }
}
