import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_controller.dart';
import '../../core/app_colors.dart';
import '../../core/auth_widgets.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
                key: auth.signupFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    AuthHeader(
                      icon: Icons.verified_user_rounded,
                      title: 'Create\nAccount.',
                      subtitle: 'Join thousands of POS agents already protected.',
                    ),
                    const SizedBox(height: 48),
                    AuthInputField(
                      controller: auth.fullNameController,
                      label: 'Full Name',
                      hint: 'Amaka Johnson',
                      keyboardType: TextInputType.name,
                      prefixIcon: Icons.person_outline_rounded,
                      validator: auth.validateFullName,
                    ),
                    const SizedBox(height: 20),
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
                      controller: auth.phoneController,
                      label: 'Phone Number',
                      hint: '080 0000 0000',
                      keyboardType: TextInputType.phone,
                      prefixIcon: Icons.phone_outlined,
                      validator: auth.validatePhone,
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
                    const SizedBox(height: 20),
                    AuthInputField(
                      controller: auth.confirmPasswordController,
                      label: 'Confirm Password',
                      hint: '••••••••',
                      obscureText: auth.obscureConfirmPassword,
                      prefixIcon: Icons.lock_outline_rounded,
                      validator: auth.validateConfirmPassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          auth.obscureConfirmPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.textSecondary,
                          size: 20,
                        ),
                        onPressed: auth.toggleConfirmPasswordVisibility,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _PasswordStrengthHint(),
                    const SizedBox(height: 40),
                    AuthPrimaryButton(
                      label: 'Create Account',
                      isLoading: auth.isLoading,
                      onTap: () => auth.signup(context),
                    ),
                    const SizedBox(height: 32),
                    AuthFooterLink(
                      question: 'Already have an account?',
                      actionText: 'Login',
                      onTap: () => Navigator.pushReplacementNamed(context, '/login'),
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

class _PasswordStrengthHint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.info_outline_rounded, color: AppColors.textSecondary, size: 14),
        const SizedBox(width: 8),
        Text(
          'Minimum 8 characters required',
          style: GoogleFonts.plusJakartaSans(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
