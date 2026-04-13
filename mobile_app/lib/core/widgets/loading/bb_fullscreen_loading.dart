import 'package:flutter/material.dart';

import '../../../core/theme/theme_extensions.dart';
import 'bb_loading_indicator.dart';

class BBFullscreenLoading extends StatelessWidget {
  const BBFullscreenLoading({
    super.key,
    this.label,
  });

  final String? label;

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;

    return Scaffold(
      backgroundColor: app.backgroundPrimary,
      body: Center(
        child: BBLoadingIndicator(
          size: 140,
          label: label,
        ),
      ),
    );
  }
}