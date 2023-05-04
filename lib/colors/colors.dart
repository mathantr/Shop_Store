import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color _colorFromHex(String hexColor) {
  final hexcode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexcode', radix: 16));
}

Color white = _colorFromHex('#ffffff');
Color red = _colorFromHex('#f71515');
Color grey = _colorFromHex('#808080');
Color orangeAccent = _colorFromHex('#FFA500');
Color black = _colorFromHex('#000000');
Color liteBlack = _colorFromHex('#313131');
Color liteyellow = _colorFromHex('#fbf1e0');
Color darkshade = _colorFromHex('##F2D29C');
Color litteRed = _colorFromHex('#820000');

final header = GoogleFonts.mukta();
final textFont = GoogleFonts.oswald();
