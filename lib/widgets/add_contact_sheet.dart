import 'package:flutter/material.dart';
import 'glass_card.dart';
import 'gradient_button.dart';

class AddContactSheet extends StatefulWidget {
  final Function(String, String) onAdd;
  const AddContactSheet({super.key, required this.onAdd});

  @override
  State<AddContactSheet> createState() => _AddContactSheetState();
}

class _AddContactSheetState extends State<AddContactSheet> {
  final _nameController = TextEditingController();
  final _relController = TextEditingController();

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
          Text('Add Trusted Contact',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSurface)),
          const SizedBox(height: 24),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Full Name'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _relController,
            decoration: const InputDecoration(labelText: 'Relationship'),
          ),
          const SizedBox(height: 32),
          GradientButton(
            text: 'Add Contact',
            onPressed: () {
              if (_nameController.text.isNotEmpty) {
                widget.onAdd(_nameController.text, _relController.text);
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
