import 'dart:ui';
import 'package:flutter/material.dart';

import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/theme_extensions.dart';

class BBCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final VoidCallback? onTap;

  const BBCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.margin = const EdgeInsets.symmetric(vertical: AppSpacing.sm),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final app = context.appTokens.colors;
    final auth = context.authTokens.colors;

    final card = Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        boxShadow: [
          BoxShadow(
            color: auth.heroGlow,
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            app.surfacePrimary.withOpacity(0.18),
            app.surfacePrimary.withOpacity(0.08),
          ],
        ),
        border: GradientBoxBorder(
          gradient: LinearGradient(
            colors: [auth.brandPrimary, auth.brandSecondary],
          ),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        child: card,
      );
    }

    return card;
  }
}

class GradientBoxBorder extends BoxBorder {
  const GradientBoxBorder({
    required this.gradient,
    this.width = 1.0,
  });

  final Gradient gradient;
  final double width;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(width);

  @override
  bool get isUniform => true;

  @override
  BorderSide get top => BorderSide(width: width, color: Colors.transparent);

  @override
  BorderSide get bottom => BorderSide(width: width, color: Colors.transparent);

  @override
  BorderSide get left => BorderSide(width: width, color: Colors.transparent);

  @override
  BorderSide get right => BorderSide(width: width, color: Colors.transparent);

  @override
  BoxBorder scale(double t) {
    return GradientBoxBorder(
      gradient: gradient,
      width: width * t,
    );
  }

  Paint _paint(Rect rect) {
    final shader = gradient.createShader(rect);
    return Paint()
      ..shader = shader
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
  }

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    TextDirection? textDirection,
    BoxShape shape = BoxShape.rectangle,
    BorderRadius? borderRadius,
  }) {
    final paint = _paint(rect);

    if (shape == BoxShape.circle) {
      canvas.drawOval(rect.deflate(width / 2), paint);
    } else {
      final rrect =
          (borderRadius ?? BorderRadius.zero).toRRect(rect).deflate(width / 2);
      canvas.drawRRect(rrect, paint);
    }
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) => this;

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) => this;
}