import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kawaii_chat/utility/app_colors.dart';
import 'package:kawaii_chat/utility/app_static_ui.dart';

enum ThemeType { light, dark }

class ThemeState {
  final ThemeData themeData;
  final ThemeType themeType;

  ThemeState(this.themeData, this.themeType);
}

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(light, ThemeType.light));

  void toggleScheme() {
    emit(state.themeType == ThemeType.light
        ? ThemeState(dark, ThemeType.dark)
        : ThemeState(light, ThemeType.light));
  }

  static ThemeData get light {
    return ThemeData(
      inputDecorationTheme: _getInputDecorationTheme(),
      elevatedButtonTheme: ElevatedButtonThemeData(style: AppStaticUi.defaultElevatedButtonStyle()),
      textButtonTheme: TextButtonThemeData(style: AppStaticUi.defaultTextButtonStyle()),
      outlinedButtonTheme: OutlinedButtonThemeData(style: AppStaticUi.defaultOutlineButtonStyle()),
      iconButtonTheme: IconButtonThemeData(style: AppStaticUi.defaultIconButtonStyle()),
      appBarTheme: const AppBarTheme(
        color: Color.fromARGB(255, 117, 208, 247),
      ),
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: const Color(0xFF13B9FF),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      inputDecorationTheme: _getInputDecorationTheme(),
      elevatedButtonTheme: ElevatedButtonThemeData(style: AppStaticUi.defaultElevatedButtonStyle()),
      textButtonTheme: TextButtonThemeData(style: AppStaticUi.defaultTextButtonStyle()),
      outlinedButtonTheme: OutlinedButtonThemeData(style: AppStaticUi.defaultOutlineButtonStyle()),
      iconButtonTheme: IconButtonThemeData(style: AppStaticUi.defaultIconButtonStyle()),
      appBarTheme: const AppBarTheme(
        color: Color.fromARGB(255, 16, 46, 59),
      ),
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: const Color(0xFF13B9FF),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static InputDecorationTheme _getInputDecorationTheme() {
    return InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.boarderColor,
          width: 1,
        ),
      ),
      labelStyle: const TextStyle(color: AppColors.textPrimary),
      floatingLabelStyle: const TextStyle(color: AppColors.primary),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.boarderColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.primary,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
      activeIndicatorBorder: const BorderSide(
        color: AppColors.primary,
      ),
    );
  }
}
