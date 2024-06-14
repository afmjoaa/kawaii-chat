
import 'package:flutter/material.dart';

class Utility{
  static MediaQueryData getMediaQueryData(BuildContext context) {
    return MediaQuery.of(context);
  }

  static double getScreenWidth(BuildContext context) {
    return getMediaQueryData(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return getMediaQueryData(context).size.height;
  }

  static bool isSmallScreen(BuildContext context) {
    return getScreenWidth(context) < 600;
  }

  static bool isMediumScreen(BuildContext context) {
    return getScreenWidth(context) >= 600 && getScreenWidth(context) < 1000;
  }

  static bool isLargeScreen(BuildContext context) {
    return getScreenWidth(context) >= 1000;
  }
}