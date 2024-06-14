
import 'package:flutter/material.dart';
import 'package:kawaii_chat/utility/app_colors.dart';

class AppStaticUi {
  static ButtonStyle defaultElevatedButtonStyle({
    Color backGroundColor = AppColors.primary,
    Color foreGroundColor = AppColors.color_white,
    double borderRadius = 10,
    VisualDensity visualDensity = VisualDensity.standard,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
  }) =>
      ElevatedButton.styleFrom(
        padding: padding,
        visualDensity: visualDensity,
        backgroundColor: backGroundColor,
        foregroundColor: foreGroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      );

  static ButtonStyle defaultOutlineButtonStyle({
    Color backGroundColor = AppColors.secondary,
    Color foreGroundColor = AppColors.textPrimary,
    double borderRadius = 10,
    VisualDensity visualDensity = VisualDensity.standard,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
  }) =>
      OutlinedButton.styleFrom(
        visualDensity: visualDensity,
        padding: padding,
        backgroundColor: backGroundColor,
        foregroundColor: foreGroundColor,
        side: const BorderSide(color: AppColors.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      );

  static ButtonStyle defaultTextButtonStyle({
    Color backGroundColor = AppColors.color_transparent,
    Color foreGroundColor = AppColors.textPrimary,
    double borderRadius = 10,
    VisualDensity visualDensity = VisualDensity.standard,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
  }) =>
      TextButton.styleFrom(
        visualDensity: visualDensity,
        padding: padding,
        backgroundColor: backGroundColor,
        foregroundColor: foreGroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      );

  static ButtonStyle defaultIconButtonStyle({
    Color backGroundColor = AppColors.color_transparent,
    Color foreGroundColor = AppColors.secondaryDark,
    double borderRadius = 10,
    VisualDensity visualDensity = VisualDensity.standard,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
  }) =>
      IconButton.styleFrom(
        visualDensity: visualDensity,
        padding: padding,
        backgroundColor: backGroundColor,
        foregroundColor: foreGroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      );
}