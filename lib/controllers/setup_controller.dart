import 'package:flutter/material.dart';

class SetupController extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController terminalIdController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  String? _selectedProvider;
  bool _isLoading = false;
  bool _locationVerified = false;

  static const List<String> posProviders = [
    'Moniepoint',
    'OPay',
    'Flutterwave',
    'Paystack',
    'PalmPay',
    'Kudi',
    'FirstMonie',
    'GTWorld',
  ];

  String? get selectedProvider => _selectedProvider;
  bool get isLoading => _isLoading;
  bool get locationVerified => _locationVerified;

  void setProvider(String? value) {
    _selectedProvider = value;
    notifyListeners();
  }

  void verifyLocation() async {
    if (locationController.text.isEmpty) return;
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 1200));
    _isLoading = false;
    _locationVerified = true;
    notifyListeners();
  }

  void proceed(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    _isLoading = false;
    notifyListeners();
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  String? validateBusinessName(String? value) {
    if (value == null || value.isEmpty) return 'Business name is required';
    return null;
  }

  String? validateProvider(String? value) {
    if (value == null || value.isEmpty) return 'Please select a POS provider';
    return null;
  }

  String? validateLocation(String? value) {
    if (value == null || value.isEmpty) return 'Shop location is required';
    return null;
  }

  @override
  void dispose() {
    businessNameController.dispose();
    terminalIdController.dispose();
    locationController.dispose();
    super.dispose();
  }
}
