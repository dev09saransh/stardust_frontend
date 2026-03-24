import 'package:flutter/material.dart';
import 'glass_card.dart';
import 'gradient_button.dart';
import '../theme.dart';

class AddAssetSheet extends StatefulWidget {
  final Function(String, String, String) onAdd;
  const AddAssetSheet({super.key, required this.onAdd});

  @override
  State<AddAssetSheet> createState() => _AddAssetSheetState();
}

class _AddAssetSheetState extends State<AddAssetSheet> {
  final _nameController = TextEditingController();
  final _valueController = TextEditingController();
  String _type = 'Digital';

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
          Text('Add New Asset',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSurface)),
          const SizedBox(height: 24),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Asset Name'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _valueController,
            decoration: const InputDecoration(labelText: 'Value / Identifier'),
          ),
          const SizedBox(height: 16),
          Text('Category',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 14)),
          const SizedBox(height: 8),
          Row(
            children: [
              _typeChip('Digital'),
              const SizedBox(width: 12),
              _typeChip('Physical'),
            ],
          ),
          const SizedBox(height: 32),
          GradientButton(
            text: 'Add Asset',
            onPressed: () {
              if (_nameController.text.isNotEmpty) {
                widget.onAdd(_nameController.text, _valueController.text, _type);
                Navigator.pop(context);
              }
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _typeChip(String label) {
    final selected = _type == label;
    return GestureDetector(
      onTap: () => setState(() => _type = label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: selected
              ? AppTheme.lavenderAccent.withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.05),
          border: Border.all(
            color: selected
                ? AppTheme.lavenderAccent
                : Colors.white.withValues(alpha: 0.1),
          ),
        ),
        child: Text(label,
            style: TextStyle(
                color: selected 
                    ? Theme.of(context).colorScheme.onSurface 
                    : Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: selected ? FontWeight.w500 : FontWeight.w400)),
      ),
    );
  }
}
