import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_controller.dart';
import '../../core/app_colors.dart';
import '../../core/auth_widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
          child: Consumer<AuthController>(
            builder: (context, auth, _) {
              return Form(
                key: auth.loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    AuthHeader(
                      icon: Icons.shield_rounded,
                      title: 'Welcome\nBack.',
                      subtitle: 'Login to continue protecting your POS business.',
                    ),
                    const SizedBox(height: 48),
                    AuthInputField(
                      controller: auth.emailController,
                      label: 'Email Address',
                      hint: 'amaka@gmail.com',
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.mail_outline_rounded,
                      validator: auth.validateEmail,
                    ),
                    const SizedBox(height: 20),
                    AuthInputField(
                      controller: auth.passwordController,
                      label: 'Password',
                      hint: '••••••••',
                      obscureText: auth.obscurePassword,
                      prefixIcon: Icons.lock_outline_rounded,
                      validator: auth.validatePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          auth.obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.textSecondary,
                          size: 20,
                        ),
                        onPressed: auth.togglePasswordVisibility,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/reset-password'),
                        child: Text(
                          'Forgot Password?',
                          style: GoogleFonts.plusJakartaSans(
                            color: AppColors.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    AuthPrimaryButton(
                      label: 'Login',
                      isLoading: auth.isLoading,
                      onTap: () => auth.login(context),
                    ),
                    const SizedBox(height: 32),
                    AuthFooterLink(
                      question: "Don't have an account?",
                      actionText: 'Sign Up',
                      onTap: () => Navigator.pushReplacementNamed(context, '/signup'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
