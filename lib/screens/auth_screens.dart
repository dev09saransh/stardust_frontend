import 'package:flutter/material.dart';
import '../widgets/stardust_background.dart';
import '../widgets/glass_card.dart';
import '../widgets/gradient_button.dart';
import '../widgets/glowing_text.dart';
import '../theme.dart';

// ─── Unified Auth Screen ───
class AuthScreen extends StatefulWidget {
  final int initialIndex;
  const AuthScreen({super.key, this.initialIndex = 0});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _signUpStep = 1; // 1: Identity, 2: Security

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StardustBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Column(
                  children: [
                    _logo(),
                    const SizedBox(height: 32),
                    GlassCard(
                      padding: const EdgeInsets.all(0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _tabBar(),
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: SizedBox(
                              height: 400,
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  _signInTab(),
                                  _signUpTab(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(
                        context, 
                        '/dashboard', 
                        arguments: {'isGuest': true, 'isLogin': true}
                      ),
                      child: Text('Continue as Guest →',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
                              fontSize: 14)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _logo() {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppTheme.buttonGradient,
        boxShadow: [
          BoxShadow(
            color: AppTheme.lavenderAccent.withValues(alpha: 0.3),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: const Icon(Icons.shield_rounded, size: 32, color: Colors.white),
    );
  }

  Widget _tabBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        indicatorColor: AppTheme.lavenderAccent,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Theme.of(context).colorScheme.onSurface,
        unselectedLabelColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
        tabs: const [
          Tab(text: 'Sign In'),
          Tab(text: 'Create Account'),
        ],
      ),
    );
  }

  Widget _signInTab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const TextField(decoration: InputDecoration(labelText: 'Email Address')),
        const SizedBox(height: 16),
        const TextField(decoration: InputDecoration(labelText: 'Password'), obscureText: true),
        const SizedBox(height: 24),
        GradientButton(
          text: 'Sign In',
          onPressed: () => Navigator.pushNamed(
            context, 
            '/otp-verification',
            arguments: {'isLogin': true},
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/forgot-password'),
              child: const Text('Lost Access?', style: TextStyle(color: AppTheme.lavenderAccent, fontSize: 13)),
            ),
            const Text(' | ', style: TextStyle(color: Colors.grey, fontSize: 12)),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/recover-account'),
              child: const Text('Emergency Recovery', style: TextStyle(color: AppTheme.lavenderAccent, fontSize: 13)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _signUpTab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            _stepIndicator(1, 'Identity'),
            const Expanded(child: Divider(indent: 8, endIndent: 8)),
            _stepIndicator(2, 'Security'),
          ],
        ),
        const SizedBox(height: 32),
        if (_signUpStep == 1) ...[
          const TextField(decoration: InputDecoration(labelText: 'Full Name')),
          const SizedBox(height: 16),
          const TextField(decoration: InputDecoration(labelText: 'Email Address')),
          const SizedBox(height: 24),
          GradientButton(
            text: 'Continue',
            onPressed: () => setState(() => _signUpStep = 2),
          ),
        ] else ...[
          const TextField(decoration: InputDecoration(labelText: 'Password'), obscureText: true),
          const SizedBox(height: 16),
          const TextField(decoration: InputDecoration(labelText: 'Confirm Password'), obscureText: true),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => setState(() => _signUpStep = 1),
                  child: const Text('Back'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GradientButton(
                  text: 'Create',
                  onPressed: () => Navigator.pushNamed(
                    context, 
                    '/otp-verification',
                    arguments: {'isLogin': false},
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _stepIndicator(int step, String label) {
    bool active = _signUpStep >= step;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? AppTheme.lavenderAccent : Colors.transparent,
            border: Border.all(color: active ? AppTheme.lavenderAccent : Colors.grey.withValues(alpha: 0.5)),
          ),
          child: Center(
            child: Text(
              step.toString(),
              style: TextStyle(
                fontSize: 12,
                color: active ? Colors.white : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: active ? Theme.of(context).colorScheme.onSurface : Colors.grey,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

// Forgot Password and Recover Account screens remain as they are linked from AuthScreen

// ─── Forgot Password ───
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StardustBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  children: [
                    _backButton(context),
                    const SizedBox(height: 16),
                    Text('Forgot Password',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w300,
                            color: AppTheme.platinum,
                            letterSpacing: 1)),
                    const SizedBox(height: 8),
                    Text('Enter your email to receive a reset link',
                        style: TextStyle(
                            color: AppTheme.silverMist.withValues(alpha: 0.5),
                            fontSize: 14)),
                    const SizedBox(height: 32),
                    GlassCard(
                      child: Column(children: [
                        TextField(
                            decoration:
                                const InputDecoration(labelText: 'Email')),
                        const SizedBox(height: 24),
                        GradientButton(
                          text: 'Reset Password',
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Password reset link sent to your email!'),
                              ),
                            );
                          },
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Recover Account ───
class RecoverAccountScreen extends StatelessWidget {
  const RecoverAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StardustBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  children: [
                    _backButton(context),
                    const SizedBox(height: 16),
                    Text('Recover Account',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w300,
                            color: AppTheme.platinum,
                            letterSpacing: 1)),
                    const SizedBox(height: 8),
                    Text('Enter your email or recovery identifier',
                        style: TextStyle(
                            color: AppTheme.silverMist.withValues(alpha: 0.5),
                            fontSize: 14)),
                    const SizedBox(height: 32),
                    GlassCard(
                      child: Column(children: [
                        TextField(
                            decoration: const InputDecoration(
                                labelText: 'Email / Recovery ID')),
                        const SizedBox(height: 24),
                        GradientButton(
                          text: 'Recover',
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Recovery instructions sent! Check your inbox.'),
                              ),
                            );
                          },
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── OTP Verification ───
class OTPVerificationScreen extends StatefulWidget {
  final bool isLogin;
  const OTPVerificationScreen({super.key, this.isLogin = true});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  // ... existing code ...
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty && index < 3) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StardustBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  children: [
                    _backButton(context),
                    const SizedBox(height: 16),
                    Text('Verification',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w300,
                            color: AppTheme.platinum,
                            letterSpacing: 1)),
                    const SizedBox(height: 8),
                    Text('Enter the 4-digit code sent to your email',
                        style: TextStyle(
                            color: AppTheme.silverMist.withValues(alpha: 0.5),
                            fontSize: 14)),
                    const SizedBox(height: 32),
                    GlassCard(
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            4,
                            (index) => SizedBox(
                              width: 60,
                              child: TextField(
                                controller: _controllers[index],
                                focusNode: _focusNodes[index],
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.platinum),
                                decoration: InputDecoration(
                                  counterText: '',
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 16),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: AppTheme.lavenderAccent,
                                        width: 2),
                                  ),
                                ),
                                onChanged: (v) => _onChanged(v, index),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        GradientButton(
                          text: 'Verify',
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context, 
                              '/dashboard',
                              arguments: {'isGuest': false, 'isLogin': widget.isLogin},
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {},
                          child: Text('Resend Code',
                              style: TextStyle(
                                  color: AppTheme.lavenderAccent,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Shared helpers ───
Widget _backButton(BuildContext context) {
  return Align(
    alignment: Alignment.centerLeft,
    child: IconButton(
      icon: Icon(Icons.arrow_back_ios_rounded, color: AppTheme.silverMist),
      onPressed: () => Navigator.pop(context),
    ),
  );
}

class _OutlineButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  const _OutlineButton(
      {required this.text, required this.icon, required this.onPressed});

  @override
  State<_OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<_OutlineButton> {
  bool _hov = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hov = true),
      onExit: (_) => setState(() => _hov = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: _hov
                    ? AppTheme.lavenderAccent
                    : Colors.white.withValues(alpha: 0.15),
                width: 1.5),
            color: _hov
                ? Colors.white.withValues(alpha: 0.04)
                : Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, color: AppTheme.silverMist, size: 20),
              const SizedBox(width: 8),
              Text(widget.text,
                  style: TextStyle(
                      color: AppTheme.silverMist,
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
            ],
          ),
        ),
      ),
    );
  }
}
