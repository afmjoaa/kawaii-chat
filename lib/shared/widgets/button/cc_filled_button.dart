import 'package:flutter/material.dart';
import 'package:kawaii_chat/utility/app_colors.dart';

class CcFilledButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String iconPath;
  final String label;
  final Color backGroundColor;
  final Color foreGroundColor;
  final double borderRadius;

  const CcFilledButton({
    Key? key,
    required this.onPressed,
    required this.iconPath,
    required this.label,
    this.backGroundColor = AppColors.primary,
    this.foreGroundColor = AppColors.color_white,
    this.borderRadius = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backGroundColor,
        foregroundColor: foreGroundColor,
        disabledForegroundColor: foreGroundColor,
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