import 'package:flutter/material.dart';

import 'app_routes.dart';
import 'application.dart';
import '../utility/log.dart';
import 'package:go_router/go_router.dart';

class KawaiiChatApplication implements Application {

  late GoRouter routes;

  @override
  void onCreate() {
    _initLog();
    _initRouter();
  }

  void _initLog() {
    Log.init();
  }

  void _initRouter() {
    routes = AppRoutes.configureRoutes();
  }

  @override
  void onTerminate() {

  }

}