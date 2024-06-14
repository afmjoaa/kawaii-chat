import 'package:flutter/material.dart';
import 'package:kawaii_chat/shared/widgets/common_appbar.dart';
import 'package:kawaii_chat/shared/widgets/text/cc_text_widget.dart';
import 'package:kawaii_chat/utility/app_colors.dart';
import 'package:kawaii_chat/utility/app_constants.dart';

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
      leadingWidth: 54,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}
