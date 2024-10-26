import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_one/model/address_model.dart';
import 'package:project_one/utils/validators.dart';

class AddressForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Address? initialAddress;
  final Function(Address) onSubmit;

  const AddressForm({
    super.key,
    required this.formKey,
    this.initialAddress,
    required this.onSubmit,
  });

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _districtController;
  late final TextEditingController _cityController;
  late final TextEditingController _streetController;
  late final TextEditingController _landmarkController;

  String? _selectedProvince;

  final List<String> _provinces = [
    'Province 1',
    'Madhesh',
    'Bagmati',
    'Gandaki',
    'Lumbini',
    'Karnali',
    'Sudurpaschim',
  ];

  @override
  void initState() {
    super.initState();
    _fullNameController =
        TextEditingController(text: widget.initialAddress?.fullName);
    _phoneController =
        TextEditingController(text: widget.initialAddress?.phone);
    _districtController =
        TextEditingController(text: widget.initialAddress?.district);
    _cityController = TextEditingController(text: widget.initialAddress?.city);
    _streetController =
        TextEditingController(text: widget.initialAddress?.streetAddress);
    _landmarkController =
        TextEditingController(text: widget.initialAddress?.landmark);
    _selectedProvince = widget.initialAddress?.province;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _districtController.dispose();
    _cityController.dispose();
    _streetController.dispose();
    _landmarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFullNameField(),
          const SizedBox(height: 16),
          _buildPhoneField(),
          const SizedBox(height: 16),
          _buildProvinceDropdown(),
          const SizedBox(height: 16),
          _buildDistrictField(),
          const SizedBox(height: 16),
          _buildCityField(),
          const SizedBox(height: 16),
          _buildStreetField(),
          const SizedBox(height: 16),
          _buildLandmarkField(),
        ],
      ),
    );
  }

  Widget _buildFullNameField() {
    return TextFormField(
      controller: _fullNameController,
      decoration: const InputDecoration(
        labelText: 'Full Name',
        hintText: 'Enter your full name',
        prefixIcon: Icon(Icons.person),
      ),
      textInputAction: TextInputAction.next,
      validator: Validators.required('Full name is required'),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget _buildPhoneField() {
    return TextFormField(
      controller: _phoneController,
      decoration: const InputDecoration(
        labelText: 'Phone Number',
        hintText: '98XXXXXXXX',
        prefixIcon: Icon(Icons.phone),
      ),
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
      validator: Validators.phone,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget _buildProvinceDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedProvince,
      decoration: const InputDecoration(
        labelText: 'Province',
        prefixIcon: Icon(Icons.location_city),
      ),
      items: _provinces.map((String province) {
        return DropdownMenuItem<String>(
          value: province,
          child: Text(province),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedProvince = newValue;
        });
      },
      validator: Validators.required('Please select a province'),
    );
  }

  Widget _buildDistrictField() {
    return TextFormField(
      controller: _districtController,
      decoration: const InputDecoration(
        labelText: 'District',
        hintText: 'Enter your district',
        prefixIcon: Icon(Icons.location_on),
      ),
      textInputAction: TextInputAction.next,
      validator: Validators.required('District is required'),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget _buildCityField() {
    return TextFormField(
      controller: _cityController,
      decoration: const InputDecoration(
        labelText: 'City/Municipality',
        hintText: 'Enter your city or municipality',
        prefixIcon: Icon(Icons.location_city),
      ),
      textInputAction: TextInputAction.next,
      validator: Validators.required('City is required'),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget _buildStreetField() {
    return TextFormField(
      controller: _streetController,
      decoration: const InputDecoration(
        labelText: 'Street Address',
        hintText: 'Enter your street address',
        prefixIcon: Icon(Icons.home),
      ),
      textInputAction: TextInputAction.next,
      validator: Validators.required('Street address is required'),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget _buildLandmarkField() {
    return TextFormField(
      controller: _landmarkController,
      decoration: const InputDecoration(
        labelText: 'Landmark (Optional)',
        hintText: 'Enter a nearby landmark',
        prefixIcon: Icon(Icons.place),
      ),
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => _submitForm(),
    );
  }

  void _submitForm() {
    if (widget.formKey.currentState?.validate() ?? false) {
      final address = Address(
        fullName: _fullNameController.text,
        phone: _phoneController.text,
        province: _selectedProvince!,
        district: _districtController.text,
        city: _cityController.text,
        streetAddress: _streetController.text,
        landmark: _landmarkController.text,
      );
      widget.onSubmit(address);
    }
  }
}
