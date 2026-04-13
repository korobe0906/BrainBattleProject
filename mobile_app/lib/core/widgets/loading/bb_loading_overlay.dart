import 'package:flutter/material.dart';

import '../../../core/theme/theme_extensions.dart';
import 'bb_loading_indicator.dart';

class BBLoadingOverlay extends StatelessWidget {
  const BBLoadingOverlay({
    super.key,
    required this.loading,
    required this.child,
    this.label,
  });

  final bool loading;
  final Widget child;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;

    return Stack(
      children: [
        child,
        if (loading)
          Positioned.fill(
            child: Container(
              color: app.backgroundPrimary.withOpacity(0.72),
              child: Center(
                child: BBLoadingIndicator(
                  size: 120,
                  label: label,
                ),
              ),
            ),
          ),
      ],
    );
  }
}