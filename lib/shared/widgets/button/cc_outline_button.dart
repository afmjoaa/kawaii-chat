import 'package:flutter/material.dart';
import 'package:kawaii_chat/utility/app_colors.dart';

class CcOutlineButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String iconPath;
  final String label;
  final Color backGroundColor;
  final Color foreGroundColor;
  final double borderRadius;
  final Color borderColor;

  const CcOutlineButton({
    Key? key,
    required this.onPressed,
    required this.iconPath,
    required this.label,
    this.backGroundColor = AppColors.color_transparent,
    this.foreGroundColor = AppColors.textPrimary,
    this.borderColor = AppColors.primary,
    this.borderRadius = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: backGroundColor,
        foregroundColor: foreGroundColor,
        side: BorderSide(color: borderColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius), // Set the rounded corners radius here
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              height: 20,
              width: 20,
            ),
            const SizedBox(width: 10),
            Text(label),
          ],
        ),
      ),
    );
  }
}