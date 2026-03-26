import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:animate_do/animate_do.dart';
import 'dart:ui' as ui;
import '../theme.dart';

class DocumentViewer extends StatelessWidget {
  final String title;
  final String? filePath;
  final String? date;
  final String? status;

  const DocumentViewer({
    super.key,
    required this.title,
    this.filePath,
    this.date,
    this.status,
  });

  /// Show the viewer as a full-screen overlay
  static void show(BuildContext context, {
    required String title,
    String? filePath,
    String? date,
    String? status,
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        barrierColor: Colors.black.withValues(alpha: 0.5),
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: DocumentViewer(
              title: title,
              filePath: filePath,
              date: date,
              status: status,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final hasFile = filePath != null && filePath!.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            color: isDark
                ? Colors.black.withValues(alpha: 0.6)
                : Colors.black.withValues(alpha: 0.3),
            child: SafeArea(
              child: GestureDetector(
                onTap: () {}, // Prevent closing when tapping content
                child: Column(
                  children: [
                    _header(context, theme),
                    Expanded(
                      child: hasFile
                          ? _imageViewer(context, theme)
                          : _noFileState(theme),
                    ),
                    _footer(context, theme),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context, ThemeData theme) {
    return FadeInDown(
      duration: const Duration(milliseconds: 400),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.medium, AppSpacing.medium, AppSpacing.medium, 0),
        child: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close_rounded,
                    color: Colors.white, size: 20),
              ),
            ),
            const SizedBox(width: AppSpacing.small),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (date != null)
                    Text(
                      'Added on $date',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    ),
                ],
              ),
            ),
            if (status != null)
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.medium, vertical: 6),
                decoration: BoxDecoration(
                  color: _statusColor(status!).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _statusColor(status!).withValues(alpha: 0.5),
                  ),
                ),
                child: Text(
                  status!,
                  style: TextStyle(
                    color: _statusColor(status!),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _imageViewer(BuildContext context, ThemeData theme) {
    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.large),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: InteractiveViewer(
            minScale: 0.5,
            maxScale: 4.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: kIsWeb
                    ? Image.network(
                        filePath!,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            _errorState(theme),
                      )
                    : Image.file(
                        File(filePath!),
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            _errorState(theme),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _noFileState(ThemeData theme) {
    return FadeIn(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.xlarge),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
              child: Icon(
                Icons.description_outlined,
                size: 64,
                color: Colors.white.withValues(alpha: 0.3),
              ),
            ),
            const SizedBox(height: AppSpacing.large),
            Text(
              title,
              style: theme.textTheme.headlineMedium?.copyWith(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.small),
            Text(
              'No preview available for this document.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.5),
              ),
            ),
            if (date != null) ...[
              const SizedBox(height: AppSpacing.medium),
              Text(
                'Added on $date',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.4),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _errorState(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.huge),
      color: Colors.black.withValues(alpha: 0.3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.broken_image_outlined,
            size: 64,
            color: Colors.white.withValues(alpha: 0.3),
          ),
          const SizedBox(height: AppSpacing.medium),
          Text(
            'Unable to load image',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _footer(BuildContext context, ThemeData theme) {
    return FadeInUp(
      duration: const Duration(milliseconds: 400),
      delay: const Duration(milliseconds: 200),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.large),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (filePath != null) ...[
              _footerHint(Icons.pinch_rounded, 'Pinch to zoom'),
              const SizedBox(width: AppSpacing.xlarge),
            ],
            _footerHint(Icons.touch_app_outlined, 'Tap outside to close'),
          ],
        ),
      ),
    );
  }

  Widget _footerHint(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.white.withValues(alpha: 0.3)),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.3),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'signed':
      case 'verified':
        return Colors.greenAccent;
      case 'vaulted':
        return Colors.cyanAccent;
      case 'pending':
        return Colors.orangeAccent;
      default:
        return Colors.white70;
    }
  }
}
