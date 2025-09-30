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
