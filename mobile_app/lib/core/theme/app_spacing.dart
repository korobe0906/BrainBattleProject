import 'package:flutter/widgets.dart';

abstract final class AppSpacing {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 40;

  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: md,
  );

  static const EdgeInsets pagePadding = EdgeInsets.all(lg);

  static const EdgeInsets cardPadding = EdgeInsets.all(md);

  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: md,
  );

  static const EdgeInsets inputContentPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: md,
  );
}
