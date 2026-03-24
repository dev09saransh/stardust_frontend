import 'package:flutter/material.dart';
import 'glass_card.dart';
import 'gradient_button.dart';

class AddDocSheet extends StatefulWidget {
  final Function(String) onAdd;
  const AddDocSheet({super.key, required this.onAdd});

  @override
  State<AddDocSheet> createState() => _AddDocSheetState();
}

class _AddDocSheetState extends State<AddDocSheet> {
  final _titleController = TextEditingController();

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
          Text('Upload Document',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSurface)),
          const SizedBox(height: 24),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Document Title'),
          ),
          const SizedBox(height: 32),
          GradientButton(
            text: 'Upload',
            onPressed: () {
              if (_titleController.text.isNotEmpty) {
                widget.onAdd(_titleController.text);
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
