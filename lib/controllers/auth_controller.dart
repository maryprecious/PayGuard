import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> resetFormKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController resetEmailController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _resetEmailSent = false;

  bool get isLoading => _isLoading;
  bool get obscurePassword => _obscurePassword;
  bool get obscureConfirmPassword => _obscureConfirmPassword;
  bool get resetEmailSent => _resetEmailSent;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }

  void login(BuildContext context) async {
    if (!loginFormKey.currentState!.validate()) return;
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    _isLoading = false;
    notifyListeners();
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  void signup(BuildContext context) async {
    if (!signupFormKey.currentState!.validate()) return;
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    _isLoading = false;
    notifyListeners();
    if (context.mounted) {
      Navigator.pushNamed(context, '/otp');
    }
  }

  void sendResetLink(BuildContext context) async {
    if (!resetFormKey.currentState!.validate()) return;
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    _isLoading = false;
    _resetEmailSent = true;
    notifyListeners();
  }

  void resetResetState() {
    _resetEmailSent = false;
    resetEmailController.clear();
    notifyListeners();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email address';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Password must be at least 8 characters';
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != passwordController.text) return 'Passwords do not match';
    return null;
  }

  String? validateFullName(String? value) {
    if (value == null || value.isEmpty) return 'Full name is required';
    if (value.trim().split(' ').length < 2) return 'Enter your full name';
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Phone number is required';
    if (value.length < 10) return 'Enter a valid phone number';
    return null;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    fullNameController.dispose();
    phoneController.dispose();
    resetEmailController.dispose();
    super.dispose();
  }
}
