import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kawaii_chat/core/firebase_options.dart';
import 'package:kawaii_chat/core/kawaii_chat_app.dart';
import 'package:kawaii_chat/core/kawaii_chat_application.dart';
import 'package:kawaii_chat/core/service_locator.dart';

import 'core/config.dart';
import 'shared/theme/theme_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseUIAuth.configureProviders(authProviders);
  final KawaiiChatApplication application = KawaiiChatApplication();
  application.onCreate();
  await setUpServiceLocators();
  await sl.allReady();
  startAppComponent(application);
}

void startAppComponent(var application) {
  runApp(
    BlocProvider(
      create: (context) => ThemeCubit(),
      child: ProviderScope(
        child: KawaiiChatApp(application),
      ),
    ),
  );
}
