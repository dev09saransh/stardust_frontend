import 'package:flutter/material.dart';
import 'glass_card.dart';
import 'gradient_button.dart';

class AddPasswordSheet extends StatefulWidget {
  final Function(String, String, String) onAdd;
  const AddPasswordSheet({super.key, required this.onAdd});

  @override
  State<AddPasswordSheet> createState() => _AddPasswordSheetState();
}

class _AddPasswordSheetState extends State<AddPasswordSheet> {
  final _siteController = TextEditingController();
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 100),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Save Password',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSurface)),
          const SizedBox(height: 24),
          TextField(
            controller: _siteController,
            decoration: const InputDecoration(labelText: 'Website / App'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _userController,
            decoration: const InputDecoration(labelText: 'Username / Email'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _passController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Password'),
          ),
          const SizedBox(height: 32),
          GradientButton(
            text: 'Save Password',
            onPressed: () {
              if (_siteController.text.isNotEmpty) {
                widget.onAdd(_siteController.text, _userController.text, _passController.text);
                Navigator.pop(context);
              }
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
