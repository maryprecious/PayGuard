import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pay_guard/views/onboarding/onboarding_screen.dart';
import 'package:pay_guard/views/home/home_page.dart';
import 'package:pay_guard/views/auth/login_screen.dart';
import 'package:pay_guard/views/auth/signup_screen.dart';
import 'package:pay_guard/views/auth/otp_screen.dart';
import 'package:pay_guard/views/auth/reset_password_screen.dart';
import 'package:pay_guard/views/setup/business_setup_screen.dart';
import 'package:pay_guard/controllers/onboarding_controller.dart';
import 'package:pay_guard/controllers/auth_controller.dart';
import 'package:pay_guard/controllers/setup_controller.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnboardingController()),
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => SetupController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PayGuard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2555FF)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const OnboardingScreen(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(builder: (_) => const LoginScreen());
          case '/signup':
            return MaterialPageRoute(builder: (_) => const SignupScreen());
          case '/otp':
            return MaterialPageRoute(builder: (_) => const OtpScreen());
          case '/business-setup':
            return MaterialPageRoute(builder: (_) => const BusinessSetupScreen());
          case '/reset-password':
            return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
          case '/home':
            return MaterialPageRoute(builder: (_) => const HomePage());
          default:
            return MaterialPageRoute(builder: (_) => const OnboardingScreen());
        }
      },
    );
  }
}
