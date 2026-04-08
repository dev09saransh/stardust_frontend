import 'package:flutter/material.dart';
import '../theme.dart';

class SuccessAnimationOverlay extends StatefulWidget {
  final VoidCallback onFinished;
  const SuccessAnimationOverlay({super.key, required this.onFinished});

  static void show(BuildContext context) {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry? overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => SuccessAnimationOverlay(
        onFinished: () {
          overlayEntry?.remove();
        },
      ),
    );

    overlayState.insert(overlayEntry);
  }

  @override
  State<SuccessAnimationOverlay> createState() => _SuccessAnimationOverlayState();
}

class _SuccessAnimationOverlayState extends State<SuccessAnimationOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  bool _isLocked = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.2), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 60),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
    );

    _controller.forward();

    // Trigger lock animation after 500ms
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() => _isLocked = true);
      }
    });

    // Auto-dismiss after 2.5 seconds
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        widget.onFinished();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.8),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.lavenderAccent.withOpacity(0.1),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.lavenderAccent.withOpacity(0.3),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: Icon(
                    _isLocked ? Icons.lock_rounded : Icons.lock_open_rounded,
                    key: ValueKey(_isLocked),
                    size: 80,
                    color: AppTheme.platinum,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            FadeTransition(
              opacity: _fadeAnimation,
              child: const Text(
                'Your data is protected',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.platinum,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
