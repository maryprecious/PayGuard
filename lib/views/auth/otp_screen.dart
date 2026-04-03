import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_colors.dart';
import '../../core/auth_widgets.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  bool _isLoading = false;
  int _secondsRemaining = 59;
  bool _canResend = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _secondsRemaining = 59;
    _canResend = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        setState(() => _canResend = true);
        timer.cancel();
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  void _onOtpDigitChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    setState(() {});
  }

  String get _otpValue =>
      _controllers.map((c) => c.text).join();

  bool get _isOtpComplete => _otpValue.length == 6;

  void _verify() async {
    if (!_isOtpComplete) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _isLoading = false);
      Navigator.pushReplacementNamed(context, '/business-setup');
    }
  }

  void _resendCode() {
    if (!_canResend) return;
    for (final c in _controllers) {
      c.clear();
    }
    _focusNodes[0].requestFocus();
    _startTimer();
    setState(() {});
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
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
                icon: Icons.phonelink_lock_rounded,
                title: 'Verify\nYour Number.',
                subtitle: 'Enter the 6-digit code sent to your phone number.',
              ),
              const SizedBox(height: 56),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return _OtpBox(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    onChanged: (val) => _onOtpDigitChanged(val, index),
                  );
                }),
              ),
              const SizedBox(height: 40),
              _ResendSection(
                canResend: _canResend,
                secondsRemaining: _secondsRemaining,
                onResend: _resendCode,
              ),
              const SizedBox(height: 40),
              AuthPrimaryButton(
                label: 'Verify & Continue',
                isLoading: _isLoading,
                onTap: _isOtpComplete ? _verify : null,
                disabled: !_isOtpComplete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;

  const _OtpBox({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isFilled = controller.text.isNotEmpty;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 48,
      height: 58,
      decoration: BoxDecoration(
        color: isFilled ? AppColors.primary.withAlpha(30) : AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isFilled ? AppColors.primary : AppColors.glassBackground,
          width: isFilled ? 1.5 : 1,
        ),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: GoogleFonts.plusJakartaSans(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
        ),
        cursorColor: AppColors.primary,
      ),
    );
  }
}

class _ResendSection extends StatelessWidget {
  final bool canResend;
  final int secondsRemaining;
  final VoidCallback onResend;

  const _ResendSection({
    required this.canResend,
    required this.secondsRemaining,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Didn't receive the code? ",
          style: GoogleFonts.plusJakartaSans(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
        GestureDetector(
          onTap: canResend ? onResend : null,
          child: Text(
            canResend
                ? 'Resend'
                : 'Resend in 0:${secondsRemaining.toString().padLeft(2, '0')}',
            style: GoogleFonts.plusJakartaSans(
              color: canResend ? AppColors.primary : AppColors.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
