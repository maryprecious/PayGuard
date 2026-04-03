import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_controller.dart';
import '../../core/app_colors.dart';
import '../../core/auth_widgets.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
          child: Consumer<AuthController>(
            builder: (context, auth, _) {
              if (auth.resetEmailSent) {
                return _ResetSuccessView(
                  onBackToLogin: () {
                    auth.resetResetState();
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                );
              }

              return Form(
                key: auth.resetFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.glassBackground),
                        ),
                        child: const Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    AuthHeader(
                      icon: Icons.key_rounded,
                      title: 'Reset\nPassword.',
                      subtitle: 'Enter your email and we\'ll send you a reset link.',
                    ),
                    const SizedBox(height: 48),
                    AuthInputField(
                      controller: auth.resetEmailController,
                      label: 'Email Address',
                      hint: 'you@example.com',
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.mail_outline_rounded,
                      validator: auth.validateEmail,
                    ),
                    const SizedBox(height: 40),
                    AuthPrimaryButton(
                      label: 'Send Reset Link',
                      isLoading: auth.isLoading,
                      onTap: () => auth.sendResetLink(context),
                    ),
                    const SizedBox(height: 32),
                    AuthFooterLink(
                      question: 'Remembered your password?',
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

class _ResetSuccessView extends StatelessWidget {
  final VoidCallback onBackToLogin;

  const _ResetSuccessView({required this.onBackToLogin});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 80),
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: const Color(0xFF00C48C).withAlpha(25),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.mark_email_read_rounded,
            color: Color(0xFF00C48C),
            size: 48,
          ),
        ),
        const SizedBox(height: 40),
        Text(
          'Check Your Email',
          textAlign: TextAlign.center,
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'We\'ve sent a password reset link to your\nemail address. Check your inbox.',
          textAlign: TextAlign.center,
          style: GoogleFonts.plusJakartaSans(
            color: AppColors.textSecondary,
            fontSize: 15,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 60),
        AuthPrimaryButton(
          label: 'Back to Login',
          isLoading: false,
          onTap: onBackToLogin,
        ),
      ],
    );
  }
}
