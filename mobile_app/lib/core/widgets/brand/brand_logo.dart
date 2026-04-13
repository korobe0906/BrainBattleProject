import 'package:flutter/material.dart';
import '../../theme/theme_extensions.dart';

class BrandLogo extends StatelessWidget {
  const BrandLogo({
    super.key,
    this.showSubtitle = true,
    this.center = true,
    this.scale = 1,
  });

  final bool showSubtitle;
  final bool center;
  final double scale;

  @override
  Widget build(BuildContext context) {
    final auth = context.authTokens.colors;

    final titleSize = 34.0 * scale;
    final subSize = 13.0 * scale;

    final widget = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        /// TITLE
        RichText(
          textAlign: center ? TextAlign.center : TextAlign.left,
          text: TextSpan(
            children: [
              _text(
                'BRAIN ',
                auth.brandPrimary,
                titleSize,
              ),
              _text(
                'BATTLE',
                auth.brandSecondary,
                titleSize,
              ),
            ],
          ),
        ),

        if (showSubtitle) ...[
          const SizedBox(height: 4),

          Text(
            'LANGUAGE LEARNING',
            style: TextStyle(
              fontSize: subSize,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.2,
              height: 1.1,
              color: auth.brandTertiary,
            ),
          ),
        ],
      ],
    );

    return widget;
  }

  TextSpan _text(String text, Color color, double size) {
    return TextSpan(
      text: text,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.2, // 👈 giảm lại để chữ "dày" hơn
        height: 1.05,
        color: color,
        shadows: [
          Shadow(
            color: color.withOpacity(0.4),
            blurRadius: 12,
          ),
        ],
      ),
    );
  }
}