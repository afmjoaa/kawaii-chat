import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:kawaii_chat/core/kawaii_chat_provider.dart';
import 'package:kawaii_chat/screen/chat/presentation/chats_screen.dart';
import 'package:kawaii_chat/screen/landing/landing_screen.dart';
import 'package:kawaii_chat/shared/loading/loading_cubit.dart';
import 'package:kawaii_chat/shared/loading/loading_widget.dart';

class AppRoutes {
  static String get initialRoute {
    return FirebaseAuth.instance.currentUser != null
        ? ChatsScreen.path
        : LandingScreen.path;
  }

  static GoRouter configureRoutes() {
    KawaiiChatProvider.loadingCubit = LoadingCubit();
    return GoRouter(
      initialLocation: initialRoute,
      routes: [
        GoRoute(
          path: LandingScreen.path,
          name: LandingScreen.path,
          builder: (context, state) => const LandingScreen(),
        ),
        GoRoute(
          path: ChatsScreen.path,
          name: ChatsScreen.path,
          builder: (context, state) => LoadingWidget(
            loadingCubit: KawaiiChatProvider.loadingCubit,
            child: const ChatsScreen(),
          ),
        ),
      ],
    );
  }
}
