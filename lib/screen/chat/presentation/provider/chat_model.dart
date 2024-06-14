import 'package:kawaii_chat/screen/chat/domain/response_entitiy.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatModel {
  final bool isInitialLoading;
  final ResponseEntity responseEntity;
  final types.User user;

  ChatModel({
    required this.isInitialLoading,
    required this.responseEntity,
    required this.user,
  });
}