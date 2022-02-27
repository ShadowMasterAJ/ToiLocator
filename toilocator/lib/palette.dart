import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor turquoise = const MaterialColor(
    0xFF00CCFF, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xff00b8e6), //10%
      100: const Color(0xff00a3cc), //20%
      200: const Color(0xff008fb3), //30%
      300: const Color(0xff007a99), //40%
      400: const Color(0xff006680), //50%
      500: const Color(0xff005266), //60%
      600: const Color(0xff003d4c), //70%
      700: const Color(0xff002933), //80%
      800: const Color(0xff001419), //90%
      900: const Color(0xff000000), //100%
    },
  );
}
