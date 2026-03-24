import 'package:flutter/material.dart';
import '../../widgets/stardust_background.dart';
import '../../widgets/glass_card.dart';
import '../../theme.dart';
import 'package:animate_do/animate_do.dart';

class SecurityLogScreen extends StatelessWidget {
  const SecurityLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> logs = [
      {'event': 'Account Login', 'id': '192.168.1.1', 'time': '2026-03-24 10:15 AM'},
      {'event': 'Password Changed', 'id': '192.168.1.1', 'time': '2026-03-23 02:45 PM'},
      {'event': 'New Device Linked', 'id': '172.16.0.42', 'time': '2026-03-22 11:30 AM'},
      {'event': 'Failed Login Attempt', 'id': '45.12.33.19', 'time': '2026-03-22 09:12 AM'},
      {'event': 'Recovery Email Updated', 'id': '192.168.1.1', 'time': '2026-03-21 04:20 PM'},
      {'event': 'Vault Exported', 'id': '192.168.1.1', 'time': '2026-03-20 06:05 PM'},
    ];

    return Scaffold(
      body: StardustBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_rounded),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Security Log',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GlassCard(
                      padding: const EdgeInsets.all(0),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
                                ),
                              ),
                            ),
                            child: Row(
                              children: const [
                                Expanded(flex: 2, child: Text('EVENT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                                Expanded(flex: 2, child: Text('IP ADDRESS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                                Expanded(flex: 2, child: Text('TIMESTAMP', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                              ],
                            ),
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: logs.length,
                            separatorBuilder: (context, index) => Divider(
                              height: 1,
                              color: Theme.of(context).dividerColor.withValues(alpha: 0.05),
                            ),
                            itemBuilder: (context, index) {
                              final log = logs[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        log['event']!,
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.onSurface,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        log['id']!,
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        log['time']!,
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
