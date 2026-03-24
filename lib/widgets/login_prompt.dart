import 'package:flutter/material.dart';

class LoginRequiredPrompt extends StatelessWidget {
  const LoginRequiredPrompt({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const LoginRequiredPrompt(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('Access Restricted'),
      content: const Text('Please sign in or create an account to access this feature and secure your digital legacy.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Maybe Later', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            // Navigate to auth screen
            Navigator.pushNamed(context, '/auth');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text('Sign In'),
        ),
      ],
    );
  }
}
