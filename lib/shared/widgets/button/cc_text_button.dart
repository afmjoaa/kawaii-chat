import 'package:flutter/material.dart';
import 'package:kawaii_chat/shared/widgets/text/cc_text_widget.dart';
import 'package:kawaii_chat/utility/app_colors.dart';

class CcTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? iconPath;
  final String label;
  final Color backGroundColor;
  final Color foreGroundColor;
  final double iconRightPadding;
  final double borderRadius;

  const CcTextButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.iconPath,
    this.iconRightPadding = 10,
    this.backGroundColor = AppColors.color_transparent,
    this.foreGroundColor = AppColors.textPrimary,
    this.borderRadius = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: backGroundColor,
        foregroundColor: foreGroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (iconPath != null)
              Padding(
                padding: EdgeInsets.only(right: iconRightPadding),
                child: Image.asset(
                  iconPath!,
                  height: 20,
                  width: 20,
                ),
              ),
            CcTextWidget(text: label, fontSize: 14, softWrap: false, overflow: TextOverflow.ellipsis,),
          ],
        ),
      ),
    );
  }
}