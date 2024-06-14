import 'package:flutter/material.dart';
import 'package:kawaii_chat/screen/auth/authentication.dart';
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
              Authentication.openAuthDialog(context: context);
            },
            iconPath: AppConstants.createAccount,
            label: 'Create Account',
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: _getBodyWidget(),
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

  Widget _getBodyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.network(
            AppConstants.kawaiiBg,
            height: 160,
            width: 160,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),
          const Text(
            'Welcome to Kawaii Chat!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.pink,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Connect with your friends in the cutest way possible.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 160,
            child: CcFilledButton(onPressed: () {  },
              iconPath: AppConstants.chat,
              label: 'Start Chatting',
            ),
          ),
        ],
      ),
    );
  }
}
