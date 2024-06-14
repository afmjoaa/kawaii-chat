
import 'package:flutter/material.dart';
import 'package:kawaii_chat/core/kawaii_chat_provider.dart';
import 'package:kawaii_chat/shared/theme/theme_cubit.dart';

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

  static bool isLightTheme(ThemeType themeType) {
    if (themeType == ThemeType.light) {
      return true;
    } else {
      return false;
    }
  }

  static void startLoadingAnimation() {
    KawaiiChatProvider.loadingCubit.startLoading();
  }

  static void completeLoadingAnimation() {
    KawaiiChatProvider.loadingCubit.resetLoading();
  }

  static void showLoadingFailedError(String errorMessage) {
    KawaiiChatProvider.loadingCubit.loadingFailed(errorMessage);
  }
}