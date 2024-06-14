import 'package:flutter/material.dart';
import 'package:kawaii_chat/utility/app_colors.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final Widget? titleWidget;
  final bool centerTitle;
  final double leadingWidth;
  final List<Widget>? actions;
  final double height;
  final Color backgroundColor;

  const CommonAppbar({
    super.key,
    this.title,
    this.titleWidget,
    this.leading,
    this.actions,
    this.height = 64.0,
    this.centerTitle = false,
    this.leadingWidth = 56.0,
    this.backgroundColor = AppColors.color_white,
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
      toolbarHeight: 64,
      backgroundColor: backgroundColor,
      surfaceTintColor: backgroundColor,
      shadowColor: Colors.black.withOpacity(0.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);

  Widget? _getTitleWidget() {
    if (title != null) {
      return Text(title!, style:
      const TextStyle(
        fontSize: 18,
        color: AppColors.color_black,
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
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 24,
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
