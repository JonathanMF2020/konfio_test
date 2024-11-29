import 'package:flutter/material.dart';
import 'package:konfiotest/core/constants/colors.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: AppColors.background,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: AppColors.secondary),
    titleTextStyle: TextStyle(color: AppColors.primary, fontSize: 18),
  );
}

TextTheme textTheme() {
  return const TextTheme(
          bodyLarge: TextStyle(color: AppColors.primary, fontSize: 14),
          bodyMedium: TextStyle(
            color: AppColors.primary,
            fontSize: 14,
          ),
          bodySmall: TextStyle(
              color: AppColors.primary,
              fontSize: 14,
              fontWeight: FontWeight.bold),
          titleLarge: TextStyle(color: AppColors.primary, fontSize: 20))
      .apply(
    bodyColor: AppColors.primary,
    displayColor: AppColors.primary,
  );
}
