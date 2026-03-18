import 'package:flutter/material.dart';

/// A fully static background with a deep indigo gradient and subtle
/// radial glow spots — no animation, no ticker.
class StardustBackground extends StatelessWidget {
  final Widget child;
  const StardustBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ─── Base gradient: deep indigo → purple → indigo ───
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0A0A1A),
                Color(0xFF110E2E),
                Color(0xFF1A1040),
                Color(0xFF110E2E),
                Color(0xFF0A0A1A),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),

        // ─── Subtle glow spot: top-right (soft purple) ───
        Positioned(
          top: -80,
          right: -60,
          child: Container(
            width: 320,
            height: 320,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF7C4DFF).withValues(alpha: 0.12),
                  const Color(0xFF7C4DFF).withValues(alpha: 0.04),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),
        ),

        // ─── Subtle glow spot: center-left (deeper indigo) ───
        Positioned(
          top: MediaQuery.of(context).size.height * 0.4,
          left: -100,
          child: Container(
            width: 360,
            height: 360,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF6C63FF).withValues(alpha: 0.10),
                  const Color(0xFF6C63FF).withValues(alpha: 0.03),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),
        ),

        // ─── Subtle glow spot: bottom-right (warm purple) ───
        Positioned(
          bottom: -60,
          right: -40,
          child: Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF9C27B0).withValues(alpha: 0.08),
                  const Color(0xFF9C27B0).withValues(alpha: 0.02),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),
        ),

        // ─── Child content on top ───
        child,
      ],
    );
  }
}
