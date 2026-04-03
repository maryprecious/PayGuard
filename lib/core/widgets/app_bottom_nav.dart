import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_colors.dart';

class AppBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  static const List<_NavItem> items = [
    _NavItem(icon: Icons.home_rounded, label: 'HOME'),
    _NavItem(icon: Icons.shield_rounded, label: 'VERIFY'),
    _NavItem(icon: Icons.history_rounded, label: 'HISTORY'),
    _NavItem(icon: Icons.settings_rounded, label: 'SETTINGS'),
    _NavItem(icon: Icons.person_rounded, label: 'PROFILE'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.glassBackground, width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final bool isActive = selectedIndex == index;
              final item = items[index];
              return GestureDetector(
                onTap: () => onTap(index),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.symmetric(
                    horizontal: isActive ? 16 : 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.primary.withAlpha(30)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                    border: isActive
                        ? Border.all(
                            color: AppColors.primary.withAlpha(60),
                            width: 1,
                          )
                        : null,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          item.icon,
                          key: ValueKey(isActive),
                          color: isActive
                              ? AppColors.primary
                              : AppColors.textSecondary,
                          size: 22,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.label,
                        style: GoogleFonts.plusJakartaSans(
                          color: isActive
                              ? AppColors.primary
                              : AppColors.textSecondary,
                          fontSize: 9,
                          fontWeight: isActive
                              ? FontWeight.w800
                              : FontWeight.w500,
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

class _NavItem {
  final IconData icon;
  final String label;

  const _NavItem({required this.icon, required this.label});
}
