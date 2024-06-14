
import 'package:flutter/material.dart';
import 'package:kawaii_chat/core/kawaii_chat_application.dart';
import 'package:kawaii_chat/shared/loading/loading_cubit.dart';

class KawaiiChatProvider extends InheritedWidget {
  static late KawaiiChatApplication appInstance;
  static late LoadingCubit loadingCubit;

  final KawaiiChatApplication application;

  KawaiiChatProvider(this.application, Widget child, {Key? key})
      : super(key: key, child: child) {
    appInstance = application;
  }

  @override
  bool updateShouldNotify(_) => true;

  static KawaiiChatProvider of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType(
        aspect: KawaiiChatProvider) as KawaiiChatProvider);
  }
}
