import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor purple = const MaterialColor(
    0xFF4A148C, //<- Cor primaria
    const <int, Color>{
      50: const Color(0x1A4A148C), //10%
      100: const Color(0x334A148C), //20%
      200: const Color(0x4D4A148C), //30%
      300: const Color(0x664A148C), //40%
      400: const Color(0x804A148C), //50%
      500: const Color(0x994A148C), //60%
      600: const Color(0xB34A148C), //70%
      700: const Color(0xCC4A148C), //80%
      800: const Color(0xE64A148C), //90%
      900: const Color(0xFF4A148C), //100%
    },
  );
}
