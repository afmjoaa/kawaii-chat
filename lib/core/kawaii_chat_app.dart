import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kawaii_chat/shared/loading/loading_cubit.dart';
import 'package:kawaii_chat/shared/theme/theme_cubit.dart';
import 'package:kawaii_chat/utility/utility.dart';

import 'kawaii_chat_application.dart';
import 'kawaii_chat_provider.dart';

class KawaiiChatApp extends StatelessWidget {
  final KawaiiChatApplication _application;

  const KawaiiChatApp(this._application, {super.key});

  @override
  Widget build(BuildContext context) {
    final app = BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
            statusBarIconBrightness: Utility.isLightTheme(themeState.themeType) ? Brightness.dark : Brightness.light,
          ));
          return MaterialApp.router(
            routerConfig: _application.routes,
            title: 'Kawaii Chat',
            theme: themeState.themeData,
            debugShowCheckedModeBanner: false,
            locale: const Locale('en'),
            localizationsDelegates: [
              FirebaseUILocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              FirebaseUILocalizations.delegate,
            ],
          ).animate().fadeIn(delay: 50.ms, duration: 400.ms)
              .shimmer(duration: 800.ms,
          );
        });
    final appProvider = KawaiiChatProvider(_application, app);
    KawaiiChatProvider.loadingCubit = LoadingCubit();
    return appProvider;
  }
}