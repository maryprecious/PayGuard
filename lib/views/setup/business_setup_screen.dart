import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../controllers/setup_controller.dart';
import '../../core/app_colors.dart';

class BusinessSetupScreen extends StatelessWidget {
  const BusinessSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _TopBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
              child: Consumer<SetupController>(
                builder: (context, setup, _) {
                  return Form(
                    key: setup.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 32),
                        _PhaseLabel(),
                        const SizedBox(height: 16),
                        _HeaderSection(),
                        const SizedBox(height: 24),
                        _LiveBadge(),
                        const SizedBox(height: 36),
                        _FormCard(setup: setup),
                        const SizedBox(height: 32),
                        _ContinueButton(setup: setup),
                        const SizedBox(height: 16),
                        _LegalText(),
                        const SizedBox(height: 28),
                        _TrustBadges(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          _BottomNav(),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withAlpha(30),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.shield_rounded, color: AppColors.primary, size: 18),
                ),
                const SizedBox(width: 10),
                Text(
                  'PayGuard',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.glassBackground),
              ),
              child: const Icon(Icons.more_vert_rounded, color: Colors.white, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhaseLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'ONBOARDING PHASE 02',
      style: GoogleFonts.plusJakartaSans(
        color: AppColors.primary,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Business\nSetup.',
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.w800,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Provide your business details to establish secure merchant connectivity across the PayGuard network.',
          style: GoogleFonts.plusJakartaSans(
            color: AppColors.textSecondary,
            fontSize: 14,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

class _LiveBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withAlpha(60)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFF00C48C),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'LIVE ENCRYPTION ACTIVE',
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _FormCard extends StatelessWidget {
  final SetupController setup;

  const _FormCard({required this.setup});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.glassBackground),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SetupField(
            label: 'BUSINESS NAME',
            child: TextFormField(
              controller: setup.businessNameController,
              validator: setup.validateBusinessName,
              style: GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 15),
              cursorColor: AppColors.primary,
              decoration: _fieldDecoration(
                hint: 'e.g. Apex Global Solutions',
                icon: Icons.storefront_outlined,
              ),
            ),
          ),
          const SizedBox(height: 20),
          _SetupField(
            label: 'POS PROVIDER',
            child: DropdownButtonFormField<String>(
              value: setup.selectedProvider,
              validator: setup.validateProvider,
              dropdownColor: const Color(0xFF0F1824),
              icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textSecondary),
              style: GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 15),
              hint: Text(
                'Select Provider',
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.textSecondary.withAlpha(150),
                  fontSize: 15,
                ),
              ),
              decoration: _fieldDecoration(hint: '', icon: null),
              items: SetupController.posProviders.map((p) {
                return DropdownMenuItem(
                  value: p,
                  child: Text(p, style: GoogleFonts.plusJakartaSans(color: Colors.white)),
                );
              }).toList(),
              onChanged: setup.setProvider,
            ),
          ),
          const SizedBox(height: 20),
          _SetupField(
            label: 'TERMINAL ID',
            optional: true,
            child: TextFormField(
              controller: setup.terminalIdController,
              style: GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 15),
              cursorColor: AppColors.primary,
              decoration: _fieldDecoration(
                hint: 'PG-9920-X',
                icon: Icons.point_of_sale_outlined,
              ),
            ),
          ),
          const SizedBox(height: 20),
          _SetupField(
            label: 'SHOP LOCATION',
            child: Column(
              children: [
                TextFormField(
                  controller: setup.locationController,
                  validator: setup.validateLocation,
                  style: GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 15),
                  cursorColor: AppColors.primary,
                  onChanged: (_) {
                    if (setup.locationVerified) {
                      setup.verifyLocation();
                    }
                  },
                  onFieldSubmitted: (_) => setup.verifyLocation(),
                  decoration: _fieldDecoration(
                    hint: 'Search address...',
                    icon: Icons.location_on_outlined,
                  ),
                ),
                const SizedBox(height: 12),
                _MapPreview(verified: setup.locationVerified),
              ],
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _fieldDecoration({required String hint, required IconData? icon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.plusJakartaSans(
        color: AppColors.textSecondary.withAlpha(120),
        fontSize: 15,
      ),
      suffixIcon: icon != null
          ? Icon(icon, color: AppColors.textSecondary, size: 20)
          : null,
      filled: true,
      fillColor: AppColors.background,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.glassBackground),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.glassBackground),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
      ),
      errorStyle: GoogleFonts.plusJakartaSans(color: Colors.redAccent, fontSize: 12),
    );
  }
}

class _SetupField extends StatelessWidget {
  final String label;
  final Widget child;
  final bool optional;

  const _SetupField({
    required this.label,
    required this.child,
    this.optional = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                color: AppColors.textSecondary,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
              ),
            ),
            if (optional) ...[
              const SizedBox(width: 8),
              Text(
                '(OPTIONAL)',
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.textSecondary.withAlpha(100),
                  fontSize: 10,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}

class _MapPreview extends StatelessWidget {
  final bool verified;

  const _MapPreview({required this.verified});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.glassBackground),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            painter: _GridPainter(),
            size: const Size(double.infinity, 110),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(40),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.location_pin, color: AppColors.primary, size: 22),
              ),
            ],
          ),
          if (verified)
            Positioned(
              bottom: 10,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFF00C48C).withAlpha(30),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF00C48C).withAlpha(80)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle_rounded, color: Color(0xFF00C48C), size: 12),
                    const SizedBox(width: 6),
                    Text(
                      'VERIFIED COORDINATES',
                      style: GoogleFonts.plusJakartaSans(
                        color: const Color(0xFF00C48C),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.glassBackground.withAlpha(80)
      ..strokeWidth = 0.5;

    const spacing = 20.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter oldDelegate) => false;
}

class _ContinueButton extends StatelessWidget {
  final SetupController setup;

  const _ContinueButton({required this.setup});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: setup.isLoading ? null : () => setup.proceed(context),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: 58,
        decoration: BoxDecoration(
          gradient: setup.isLoading
              ? null
              : const LinearGradient(
                  colors: [Color(0xFF2555FF), Color(0xFF1A3FD4)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          color: setup.isLoading ? AppColors.surface : null,
          borderRadius: BorderRadius.circular(16),
          boxShadow: setup.isLoading
              ? []
              : [
                  BoxShadow(
                    color: AppColors.primary.withAlpha(80),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
        ),
        child: Center(
          child: setup.isLoading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Continue to Dashboard',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
                  ],
                ),
        ),
      ),
    );
  }
}

class _LegalText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: GoogleFonts.plusJakartaSans(
          color: AppColors.textSecondary,
          fontSize: 12,
          height: 1.6,
        ),
        children: const [
          TextSpan(text: 'By continuing, you agree to our '),
          TextSpan(
            text: 'Merchant Security Protocols',
            style: TextStyle(
              color: AppColors.primary,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primary,
            ),
          ),
          TextSpan(text: '.'),
        ],
      ),
    );
  }
}

class _TrustBadges extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _TrustCard(
            icon: Icons.verified_rounded,
            title: 'INSTANT\nVERIFICATION',
            subtitle: 'All business terminal IDs are cross-referenced with global banking.',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _TrustCard(
            icon: Icons.shield_rounded,
            title: 'END-TO-END\nENCRYPTION',
            subtitle: 'All business credentials stored using AES-256.',
          ),
        ),
      ],
    );
  }
}

class _TrustCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _TrustCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.glassBackground),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 22),
          const SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: GoogleFonts.plusJakartaSans(
              color: AppColors.textSecondary,
              fontSize: 11,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.glassBackground)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            _NavItem(icon: Icons.shield_outlined, label: 'SECURE', active: true),
            _NavItem(icon: Icons.bar_chart_rounded, label: 'ACTIVITY'),
            _NavItem(icon: Icons.account_balance_wallet_outlined, label: 'VAULT'),
            _NavItem(icon: Icons.settings_outlined, label: 'SETTINGS'),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;

  const _NavItem({required this.icon, required this.label, this.active = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: active ? AppColors.primary : AppColors.textSecondary, size: 22),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            color: active ? AppColors.primary : AppColors.textSecondary,
            fontSize: 9,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }
}
