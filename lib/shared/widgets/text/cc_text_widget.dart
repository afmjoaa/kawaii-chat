import 'package:flutter/material.dart';
import 'package:kawaii_chat/utility/app_colors.dart';

class CcTextWidget extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextOverflow overflow;
  final bool softWrap;
  final double? letterSpacing;
  final double? height;
  final TextAlign textAlign;

  const CcTextWidget(
      {super.key,
      required this.text,
      this.height,
      this.letterSpacing,
      this.textAlign = TextAlign.start,
      this.fontSize = 16,
      this.fontWeight = FontWeight.w400,
      this.overflow = TextOverflow.fade,
      this.color = AppColors.textPrimary,
      this.softWrap = true,
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        overflow: overflow,
        height: height,
        letterSpacing: letterSpacing,
      ),
      softWrap: softWrap,
      overflow: overflow,
    );
  }
}
