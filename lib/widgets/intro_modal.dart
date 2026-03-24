import 'package:flutter/material.dart';
import '../theme.dart';
import 'glass_card.dart';
import 'gradient_button.dart';

class IntroModal extends StatefulWidget {
  final VoidCallback onFinish;
  const IntroModal({super.key, required this.onFinish});

  @override
  State<IntroModal> createState() => _IntroModalState();
}

class _IntroModalState extends State<IntroModal> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _slides = [
    {
      'title': 'Secure Your Legacy',
      'desc': 'Stardust Vault uses zero-knowledge encryption to protect your most sensitive data and digital assets.',
      'icon': '🛡️'
    },
    {
      'title': 'Digital Asset Management',
      'desc': 'Keep track of your real estate, banking, investments, and more in one unified, secure location.',
      'icon': '🏦'
    },
    {
      'title': 'Password Security',
      'desc': 'Generate and store strong, unique passwords for all your online accounts with military-grade protection.',
      'icon': '🔐'
    },
    {
      'title': 'Emergency Access',
      'desc': 'Ensure your heirs and trusted contacts can access your vault when it matters most, through automated protocols.',
      'icon': '🤝'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: GlassCard(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.close_rounded, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5)),
                    onPressed: widget.onFinish,
                  ),
                ],
              ),
              SizedBox(
                height: 300,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (idx) => setState(() => _currentPage = idx),
                  itemCount: _slides.length,
                  itemBuilder: (context, index) {
                    final slide = _slides[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(slide['icon']!, style: const TextStyle(fontSize: 64)),
                        const SizedBox(height: 24),
                        Text(
                          slide['title']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          slide['desc']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _slides.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? AppTheme.lavenderAccent
                          : AppTheme.lavenderAccent.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              GradientButton(
                text: _currentPage == _slides.length - 1 ? 'Get Started' : 'Next',
                onPressed: () {
                  if (_currentPage < _slides.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    widget.onFinish();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
