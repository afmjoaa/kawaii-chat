import 'package:codeintel_chatbot_cms/shared/widgets/button/cc_icon_button.dart';
import 'package:codeintel_chatbot_cms/utility/app_colors.dart';
import 'package:codeintel_chatbot_cms/utility/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RightSlidingDialog extends StatefulWidget {
  final Widget child;
  final double width;

  const RightSlidingDialog({super.key, required this.child, required this.width});

  @override
  RightSlidingDialogState createState() => RightSlidingDialogState();
}

class RightSlidingDialogState extends State<RightSlidingDialog> {
  bool _isVisible = false;
  final Duration animationDuration = const Duration(milliseconds: 300);
  late final double width;

  @override
  void initState() {
    super.initState();
    width = widget.width;
    Future.delayed(const Duration(milliseconds: 50), () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: animationDuration,
          curve: Curves.easeInOut,
          top: 0,
          bottom: 0,
          right: _isVisible ? 0 : width * -1,
          child: Container(
            width: width,
            decoration: BoxDecoration(
              color: AppColors.color_white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: const Offset(1, 1), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: widget.child,
            ),
          ),
        ),
        Positioned(top: 0, right: 0, child: _getCollapseButton()),
      ],
    );
  }

  Widget _getCollapseButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
      child: CcIconButton(
        onPressed: () {
          setState(() {
            _isVisible = false;
          });
          Future.delayed(animationDuration)
              .then((_) => context.pop());
        },
        borderRadiusLeft: 30,
        borderRadiusRight: 0,
        iconPath: AppConstants.doubleRight,
        tooltip: "Collapse",
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
