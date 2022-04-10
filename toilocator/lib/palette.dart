import 'package:flutter/material.dart';

/// Theme data for the app
class Palette {
  static const MaterialColor beige = const MaterialColor(
    0xFFe9c387, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xFFfbf3e7), //10%
      100: const Color(0xFFf2dbb7), //20%
      200: const Color(0xFFe9c387), //30%
      300: const Color(0xFFe1ab57), //40%
      400: const Color(0xFFdea44a), //50%
      500: const Color(0xFFdb9c38), //60%
      600: const Color(0xFFd89327), //70%
      700: const Color(0xFFb57b21), //80%
      800: const Color(0xFF825817), //90%
      900: const Color(0xFF2b1d08), //100%
    },
  );
}
