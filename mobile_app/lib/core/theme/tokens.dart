import 'package:flutter/material.dart';
import 'palette.dart';

class BBSpacing {
  static const double xs = 6;
  static const double sm = 10;
  static const double md = 14;
  static const double lg = 18;
  static const double xl = 24;
}

class BBRadii {
  static const double sm = 10;
  static const double md = 14;
  static const double lg = 18;
  static const double xl = 22;
}

class BBTokens {
  static const double hairline = 1.0;
}

class BBShadows {
  static List<BoxShadow> neon = [
    BoxShadow(
      color: BBPalette.pink.withOpacity(0.30),
      blurRadius: 22,
      spreadRadius: 1,
    ),
  ];
}

class BBTypo {
  static TextStyle title(BuildContext ctx) =>
      Theme.of(ctx).textTheme.titleLarge!.copyWith(
        color: Theme.of(ctx).colorScheme.onBackground,
        fontWeight: FontWeight.w700,
      );

  static TextStyle subtitle(BuildContext ctx) =>
      Theme.of(ctx).textTheme.titleMedium!.copyWith(
        color: Theme.of(ctx).colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w600,
      );

  static TextStyle body(BuildContext ctx) =>
      Theme.of(ctx).textTheme.bodyMedium!.copyWith(
        color: Theme.of(ctx).colorScheme.onSurface,
      );
}
