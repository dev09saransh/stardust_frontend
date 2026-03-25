import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class FloatingGlassNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const FloatingGlassNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    final items = [
      {'icon': Icons.dashboard_rounded, 'label': 'Home'},
      {'icon': Icons.account_balance_wallet_rounded, 'label': 'Assets'},
      {'icon': Icons.qr_code_scanner_rounded, 'label': 'Scan'},
      {'icon': Icons.settings_rounded, 'label': 'Settings'},
    ];

    return FadeInUp(
      duration: const Duration(milliseconds: 800),
      child: Container(
        margin: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withValues(alpha: isDark ? 0.2 : 0.1),
              blurRadius: 20,
              spreadRadius: -5,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: isDark 
                    ? Colors.white.withValues(alpha: 0.08) 
                    : Colors.white.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(35),
                border: Border.all(
                  color: Colors.white.withValues(alpha: isDark ? 0.1 : 0.5),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(items.length, (index) {
                  final isSelected = currentIndex == index;
                  final item = items[index];

                  return Expanded(
                    child: InkWell(
                      onTap: () => onTap(index),
                      borderRadius: BorderRadius.circular(35),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedScale(
                            scale: isSelected ? 1.2 : 1.0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOutBack,
                            child: Icon(
                              item['icon'] as IconData,
                              color: isSelected 
                                  ? colorScheme.primary 
                                  : colorScheme.onSurface.withValues(alpha: 0.5),
                              size: 26,
                            ),
                          ),
                          if (isSelected)
                            FadeIn(
                              duration: const Duration(milliseconds: 200),
                              child: Text(
                                item['label'] as String,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  color: colorScheme.primary,
                                ),
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
        ),
      ),
    );
  }
}
