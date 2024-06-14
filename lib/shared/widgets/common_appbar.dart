import 'package:flutter/material.dart';
import 'package:kawaii_chat/utility/app_colors.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final Widget? titleWidget;
  final bool centerTitle;
  final double leadingWidth;

  const CommonAppbar({
    super.key,
    this.title,
    this.titleWidget,
    this.leading,
    this.centerTitle = true,
    this.leadingWidth = 56.0,
  });

  @override
  Widget build(BuildContext context) {
    final bool canPop = Navigator.canPop(context);
    return AppBar(
      leading: leading ?? _getDefaultLeadingWidget(canPop),
      leadingWidth: leadingWidth,
      title: _getTitleWidget(),
      centerTitle: centerTitle,
      elevation: 3,
      toolbarHeight: 54,
      backgroundColor: AppColors.secondary,
      shadowColor: Colors.black.withOpacity(0.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);

  Widget? _getTitleWidget() {
    if (title != null) {
      return Text(title!, style:
      const TextStyle(
        fontSize: 18,
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w500,
      ),);
    } else {
      return titleWidget;
    }
  }

  Widget? _getDefaultLeadingWidget(bool canPop) {
    if (canPop) {
      return Builder(
        builder: (BuildContext context) => IconButton(
          padding: const EdgeInsets.all(22),
          icon: Image.asset(
            'assets/icons/confirm.png',
            width: 20.0,
            height: 20.0,
          ),
          onPressed: () => Navigator.pop(context),
          tooltip: 'back',
        ),
      );
    } else {
      return null;
    }
  }
}
