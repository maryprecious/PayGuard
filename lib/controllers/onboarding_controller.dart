import 'package:flutter/material.dart';

class OnboardingController extends ChangeNotifier {
  final PageController pageController = PageController();
  int _currentPage = 0;

  int get currentPage => _currentPage;

  void setPage(int index) {
    _currentPage = index;
    notifyListeners();
  }

  void nextPage(BuildContext context) {
    if (_currentPage < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void skip(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
