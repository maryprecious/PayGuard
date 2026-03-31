import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/onboarding_controller.dart';
import '../../core/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Consumer<OnboardingController>(
        builder: (context, controller, child) {
            return Stack(
              children: [
                PageView(
                  controller: controller.pageController,
                  onPageChanged: controller.setPage,
                  children: [
                    _buildPageOne(),
                    _buildPageTwo(),
                    _buildPageThree(),
                  ],
                ),
                Positioned(
                  top: 50,
                  right: 20,
                  child: TextButton(
                    onPressed: () => controller.skip(context),
                    child: Text(
                      'SKIP',
                      style: GoogleFonts.plusJakartaSans(
                        color: AppColors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 50,
                  left: 20,
                  right: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: List.generate(3, (index) {
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.only(right: 8),
                                height: 4,
                                width: controller.currentPage == index ? 24 : 8,
                                decoration: BoxDecoration(
                                  color: controller.currentPage == index
                                      ? AppColors.indicatorActive
                                      : AppColors.indicatorInactive,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 24),
                          _buildFooterText(controller.currentPage),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => controller.nextPage(context),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      );
  }

  Widget _buildFooterText(int page) {
    String step = "STEP 0${page + 1} / 03";
    String label = "";
    if (page == 0) label = "Identity Verification";
    if (page == 1) label = "Security Module";
    if (page == 2) label = "Global Risk Database";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildPageOne() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildShieldGraphic(),
          const SizedBox(height: 64),
          _buildTitle('Protect Your\nPOS Business.'),
          const SizedBox(height: 24),
          _buildSubtitle(
            'Verify bank transfers before releasing cash to avoid losses from fake alerts.',
          ),
        ],
      ),
    );
  }

  Widget _buildPageTwo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSecurityGraphic(),
          const SizedBox(height: 64),
          _buildTitle('Detect\nSuspicious\nTransactions.'),
          const SizedBox(height: 24),
          _buildSubtitle(
            'Check accounts that have been reported for fraud using our AI-driven risk engine.',
          ),
        ],
      ),
    );
  }

  Widget _buildPageThree() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNetworkGraphic(),
          const SizedBox(height: 64),
          _buildTitle('Stay Ahead of\nFraudsters.'),
          const SizedBox(height: 24),
          _buildSubtitle(
            'Get alerts about risky accounts used across POS networks through community intelligence.',
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.plusJakartaSans(
        color: Colors.white,
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.1,
      ),
    );
  }

  Widget _buildSubtitle(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.plusJakartaSans(
        color: AppColors.textSecondary,
        fontSize: 16,
        height: 1.6,
      ),
    );
  }

  Widget _buildShieldGraphic() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha(20),
            shape: BoxShape.circle,
          ),
        ),
        const Icon(Icons.shield_rounded, color: AppColors.primary, size: 100),
        const Positioned(
          top: 30,
          right: 30,
          child: _Badge(text: 'ACTIVE'),
        ),
      ],
    );
  }

  Widget _buildSecurityGraphic() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.red.withAlpha(20),
            shape: BoxShape.circle,
          ),
        ),
        const Icon(Icons.security_rounded, color: Colors.blueAccent, size: 100),
        const Positioned(
          top: 10,
          right: 10,
          child: _Badge(text: 'HIGH RISK', color: Colors.redAccent),
        ),
        const Positioned(
          bottom: 20,
          left: 10,
          child: _Badge(text: 'AI ENGINE ACTIVE', color: Colors.blue),
        ),
      ],
    );
  }

  Widget _buildNetworkGraphic() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha(20),
            shape: BoxShape.circle,
          ),
        ),
        const Icon(Icons.hub_rounded, color: AppColors.primary, size: 100),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;
  final Color color;

  const _Badge({required this.text, this.color = AppColors.primary});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(40),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withAlpha(80), width: 1),
      ),
      child: Text(
        text,
        style: GoogleFonts.plusJakartaSans(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
