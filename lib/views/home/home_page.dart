import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  int _selectedNav = 0;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.85, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TopBar(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        _GreetingSection(),
                        const SizedBox(height: 24),
                        _VerifyCard(pulseAnimation: _pulseAnimation),
                        const SizedBox(height: 20),
                        _QuickActionsRow(),
                        const SizedBox(height: 24),
                        _StatsRow(),
                        const SizedBox(height: 28),
                        _AlertsSection(),
                        const SizedBox(height: 24),
                        _PrecinctCard(),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _BottomNav(
            selected: _selectedNav,
            onTap: (i) => setState(() => _selectedNav = i),
          ),
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
        padding: const EdgeInsets.fromLTRB(24, 16, 20, 16),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surface,
                border: Border.all(color: AppColors.primary.withAlpha(80), width: 2),
              ),
              child: const Icon(Icons.person_rounded, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 12),
            Text(
              'PayGuard',
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            _IconButton(
              icon: Icons.settings_outlined,
              onTap: () {},
            ),
            const SizedBox(width: 8),
            Stack(
              clipBehavior: Clip.none,
              children: [
                _IconButton(
                  icon: Icons.notifications_outlined,
                  onTap: () {},
                ),
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '3',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _IconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.glassBackground),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}

class _GreetingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, Marcus',
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFF00C48C),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'SYSTEM STATUS: SECURE',
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF00C48C),
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(width: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.redAccent.withAlpha(25),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.redAccent.withAlpha(60)),
              ),
              child: Text(
                '3 new alerts today',
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.redAccent,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _VerifyCard extends StatelessWidget {
  final Animation<double> pulseAnimation;

  const _VerifyCard({required this.pulseAnimation});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        height: 160,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF2555FF), Color(0xFF0E35C4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withAlpha(100),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              right: -20,
              bottom: -20,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(10),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              right: 20,
              top: -30,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(8),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: pulseAnimation,
                  builder: (context, child) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Transform.scale(
                          scale: pulseAnimation.value,
                          child: Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(20),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.shield_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 14),
                Text(
                  'Verify Transaction',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Tap to initiate secure POS scan',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white.withAlpha(180),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickAction(
            icon: Icons.qr_code_scanner_rounded,
            label: 'Scan',
            onTap: () {},
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickAction(
            icon: Icons.manage_search_rounded,
            label: 'Check Account',
            onTap: () {},
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickAction(
            icon: Icons.flag_rounded,
            label: 'Report Fraud',
            color: Colors.redAccent,
            onTap: () {},
          ),
        ),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withAlpha(50)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            label: 'TRANS. VERIFIED',
            value: '142',
            icon: Icons.check_circle_rounded,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            label: 'FRAUD BLOCKED',
            value: '08',
            icon: Icons.block_rounded,
            color: Colors.redAccent,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withAlpha(60)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withAlpha(25),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(height: 16),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              color: AppColors.textSecondary,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _AlertsSection extends StatelessWidget {
  static const List<Map<String, dynamic>> _alerts = [
    {
      'account': 'Account ending 2231',
      'detail': 'Reported 4 times today in this zone.',
      'tag': 'HIGH RISK',
      'tagColor': Colors.redAccent,
      'icon': Icons.warning_amber_rounded,
      'iconColor': Colors.orange,
    },
    {
      'account': 'Merchant Node #772',
      'detail': 'Unusual micro-transaction velocity detected.',
      'tag': 'MONITORING',
      'tagColor': Color(0xFF00C48C),
      'icon': Icons.location_on_outlined,
      'iconColor': Color(0xFF00C48C),
    },
    {
      'account': 'Account ending 8812',
      'detail': 'Flagged for credential mismatch at Terminal A.',
      'tag': 'HIGH RISK',
      'tagColor': Colors.redAccent,
      'icon': Icons.shield_outlined,
      'iconColor': Colors.orange,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Risk Alerts',
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.glassBackground),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Color(0xFF00C48C),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'LIVE FEED',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ..._alerts.map((alert) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _AlertCard(alert: alert),
            )),
      ],
    );
  }
}

class _AlertCard extends StatelessWidget {
  final Map<String, dynamic> alert;

  const _AlertCard({required this.alert});

  @override
  Widget build(BuildContext context) {
    final Color tagColor = alert['tagColor'] as Color;
    final Color iconColor = alert['iconColor'] as Color;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.glassBackground),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withAlpha(25),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(alert['icon'] as IconData, color: iconColor, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alert['account'] as String,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  alert['detail'] as String,
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: tagColor.withAlpha(25),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: tagColor.withAlpha(80)),
            ),
            child: Text(
              alert['tag'] as String,
              style: GoogleFonts.plusJakartaSans(
                color: tagColor,
                fontSize: 9,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrecinctCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.glassBackground),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox.expand(
              child: CustomPaint(painter: _MapGridPainter()),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  AppColors.surface.withAlpha(230),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ACTIVE PRECINCT',
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColors.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'District 12: Downtown Sector',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(30),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.primary.withAlpha(80)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.radar_rounded, color: AppColors.primary, size: 12),
                  const SizedBox(width: 5),
                  Text(
                    'SCANNING',
                    style: GoogleFonts.plusJakartaSans(
                      color: AppColors.primary,
                      fontSize: 9,
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

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = AppColors.glassBackground.withAlpha(60)
      ..strokeWidth = 0.6;

    const spacing = 22.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }

    final dotPaint = Paint()..color = AppColors.primary.withAlpha(120);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.4), 6, dotPaint);

    final ringPaint = Paint()
      ..color = AppColors.primary.withAlpha(40)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.4), 18, ringPaint);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.4), 34, ringPaint..color = AppColors.primary.withAlpha(20));
  }

  @override
  bool shouldRepaint(_MapGridPainter oldDelegate) => false;
}

class _BottomNav extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onTap;

  const _BottomNav({required this.selected, required this.onTap});

  static const _items = [
    {'icon': Icons.home_rounded, 'label': 'HOME'},
    {'icon': Icons.shield_rounded, 'label': 'VERIFY'},
    {'icon': Icons.history_rounded, 'label': 'HISTORY'},
    {'icon': Icons.settings_rounded, 'label': 'SETTINGS'},
    {'icon': Icons.person_rounded, 'label': 'PROFILE'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.glassBackground)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (i) {
              final bool isActive = selected == i;
              final IconData icon = _items[i]['icon'] as IconData;
              final String label = _items[i]['label'] as String;
              return GestureDetector(
                onTap: () => onTap(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.primary.withAlpha(25) : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        icon,
                        color: isActive ? AppColors.primary : AppColors.textSecondary,
                        size: 22,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        label,
                        style: GoogleFonts.plusJakartaSans(
                          color: isActive ? AppColors.primary : AppColors.textSecondary,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
