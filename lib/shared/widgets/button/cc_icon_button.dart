import 'package:flutter/material.dart';
import 'package:kawaii_chat/utility/app_colors.dart';

class CcIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String iconPath;
  final String tooltip;
  final Color foreGroundColor;
  final Color backGroundColor;
  final Color boarderColor;
  final double borderWidth;
  final double borderRadiusLeft;
  final double borderRadiusRight;

  const CcIconButton(
      {Key? key,
      required this.onPressed,
      required this.iconPath,
      required this.tooltip,
      this.foreGroundColor = AppColors.textPrimary,
      this.backGroundColor = AppColors.color_transparent,
      this.boarderColor = AppColors.color_transparent,
      this.borderWidth = 0,
      this.borderRadiusLeft = 30,
      this.borderRadiusRight = 30})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: backGroundColor,
        foregroundColor: foreGroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: boarderColor, width: borderWidth),
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(borderRadiusLeft),
            right: Radius.circular(borderRadiusRight),
          ),
        ),
      ),
      icon: Image.asset(
        iconPath,
        height: 20,
        width: 20,
      ),
    );
  }
}
