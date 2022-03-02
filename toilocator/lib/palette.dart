import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor beige = const MaterialColor(
    0xf2dbb7, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xfbf3e7), //10%
      100: const Color(0xf2dbb7), //20%
      200: const Color(0xe9c387), //30%
      300: const Color(0xe1ab57), //40%
      400: const Color(0xdea44a), //50%
      500: const Color(0xdb9c38), //60%
      600: const Color(0xd89327), //70%
      700: const Color(0xb57b21), //80%
      800: const Color(0x825817), //90%
      900: const Color(0x2b1d08), //100%
    },
  );
}
