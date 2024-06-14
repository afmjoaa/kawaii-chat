import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kawaii_chat/screen/landing/landing_screen.dart';
import 'package:kawaii_chat/shared/widgets/button/cc_filled_button.dart';
import 'package:kawaii_chat/shared/widgets/button/cc_icon_button.dart';
import 'package:kawaii_chat/shared/widgets/button/cc_outline_button.dart';
import 'package:kawaii_chat/shared/widgets/common_appbar.dart';
import 'package:kawaii_chat/shared/widgets/text/cc_text_widget.dart';
import 'package:kawaii_chat/utility/app_colors.dart';
import 'package:kawaii_chat/utility/app_constants.dart';
import 'package:kawaii_chat/utility/utility.dart';

class ChatsAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const ChatsAppbar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return CommonAppbar(
      centerTitle: false,
      titleWidget: SizedBox(
          height: 54,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CcTextWidget(
                text: title,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              const CcTextWidget(
                text:'online',
                  fontSize: 14,
                  color: AppColors.color_1CDC18,
                  fontWeight: FontWeight.w300,
              ),
            ],
          )),
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 16,
          ),
          Container(
            width: 38.0,
            height: 38.0,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: ClipOval(
                child: Image.asset(
                  AppConstants.appIcon,
                  fit: BoxFit.cover,
                )
              ),
            ),
          ),
        ],
      ),
      actions: [
        _getButtonBasedOnWidth(
          context: context,
          onPressed: () {
            FirebaseAuth.instance.signOut();
            GoRouter.of(context).pushReplacementNamed(LandingScreen.path);
          },
          label: 'Log out',
        ),
        const SizedBox(
          width: 20,
        )
      ],
      leadingWidth: 54,
    );
  }

  Widget _getButtonBasedOnWidth({
    required BuildContext context,
    required VoidCallback onPressed,
    required String label,
    bool isFilledButton = true,
  }) {
    if (Utility.getScreenWidth(context) > 800) {
      return isFilledButton
          ? CcFilledButton(
        onPressed: onPressed,
        iconPath: AppConstants.logoutWhite,
        label: label,
      ) : CcOutlineButton(
        onPressed: onPressed,
        iconPath: AppConstants.logoutBlack,
        label: label,
      );
    } else {
      return CcIconButton(
        onPressed: onPressed,
        iconPath: AppConstants.logoutBlack,
        tooltip: label,
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}
