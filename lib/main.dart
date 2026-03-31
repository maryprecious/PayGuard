import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pay_guard/views/onboarding/onboarding_screen.dart';
import 'package:pay_guard/views/home/home_page.dart';
import 'package:pay_guard/controllers/onboarding_controller.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnboardingController()),
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
      home: OnboardingScreen(),
      routes: {
        "/home": (context) => HomePage(),
      },
    );
  }
}
