import 'package:flutter/material.dart';
import 'package:shop_store/colors/colors.dart';

ThemeData themeData = ThemeData(
    scaffoldBackgroundColor: white,
    primaryColor: red,
    inputDecorationTheme: InputDecorationTheme(
        border: outlineInputBorder,
        errorBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        disabledBorder: outlineInputBorder,
        prefixIconColor: grey,
        suffixIconColor: grey),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: red,
            disabledBackgroundColor: grey,
            textStyle: header.copyWith(fontSize: 20, letterSpacing: 1.2))));

OutlineInputBorder outlineInputBorder =
    OutlineInputBorder(borderSide: BorderSide(color: grey));
