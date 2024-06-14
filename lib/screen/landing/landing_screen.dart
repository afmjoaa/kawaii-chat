import 'package:flutter/material.dart';
import 'package:kawaii_chat/shared/widgets/button/cc_filled_button.dart';
import 'package:kawaii_chat/shared/widgets/button/cc_icon_button.dart';
import 'package:kawaii_chat/shared/widgets/button/cc_outline_button.dart';
import 'package:kawaii_chat/shared/widgets/common_appbar.dart';
import 'package:kawaii_chat/utility/app_colors.dart';
import 'package:kawaii_chat/utility/app_constants.dart';
import 'package:kawaii_chat/utility/utility.dart';

class LandingScreen extends StatelessWidget {
  static const String path = '/landing';

  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.color_background,
        appBar: CommonAppbar(
          titleWidget: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppConstants.appIcon,
                  height: 46,
                  width: 46,
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  'Kawaii Chat',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          height: 64.0,
          actions: [
            _getButtonBasedOnWidth(
              context: context,
              onPressed: () {
                //TODO
              },
              iconPath: AppConstants.createAccount,
              label: 'Create Account',
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: const Placeholder(),
    );
  }

  Widget _getButtonBasedOnWidth({
    required BuildContext context,
    required VoidCallback onPressed,
    required String iconPath,
    required String label,
    bool isFilledButton = true,
  }) {
    if (Utility.getScreenWidth(context) > 800) {
      return isFilledButton
          ? CcFilledButton(
        onPressed: onPressed,
        iconPath: iconPath,
        label: label,
      )
          : CcOutlineButton(
        onPressed: onPressed,
        iconPath: iconPath,
        label: label,
      );
    } else {
      return CcIconButton(
        onPressed: onPressed,
        iconPath: iconPath,
        tooltip: label,
      );
    }
  }
}
