import 'package:flutter/material.dart';
import 'glass_card.dart';
import '../utils/card_benefits.dart';
import 'package:animate_do/animate_do.dart';

class CardBenefitsSheet extends StatelessWidget {
  final String cardName;
  final String cardVariant;

  const CardBenefitsSheet({
    super.key,
    required this.cardName,
    required this.cardVariant,
  });

  @override
  Widget build(BuildContext context) {
    final benefits = CardBenefitsProvider.getBenefits(cardName, cardVariant);

    return GlassCard(
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        left: 16,
        right: 16,
        top: 100,
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.credit_card_rounded, color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(cardName,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context).colorScheme.onSurface)),
                    Text(cardVariant,
                        style: TextStyle(
                            fontSize: 13,
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5))),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close_rounded),
                style: IconButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text('PREMIUM BENEFITS',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: Theme.of(context).colorScheme.primary)),
          const SizedBox(height: 16),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: benefits.length,
              itemBuilder: (context, index) {
                final benefit = benefits[index];
                return FadeInRight(
                  delay: Duration(milliseconds: index * 100),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(benefit.icon, size: 20, color: Theme.of(context).colorScheme.onSurface),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(benefit.title,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).colorScheme.onSurface)),
                              const SizedBox(height: 4),
                              Text(benefit.description,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              '* Verify benefits with your bank. Terms & conditions apply.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10,
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3)),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
