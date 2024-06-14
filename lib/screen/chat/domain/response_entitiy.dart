import 'package:flutter_chat_types/flutter_chat_types.dart';

class ResponseEntity {
  int runningIndex;
  List<Message> messages;
  String id;

  ResponseEntity({
    required this.runningIndex,
    required this.messages,
    required this.id,
  });

  ResponseEntity copyWith({
    int? runningIndex,
    List<Message>? messages,
    String? id,
  }) {
    return ResponseEntity(
      runningIndex: runningIndex ?? this.runningIndex,
      messages: messages ?? this.messages,
      id: id ?? this.id,
    );
  }
}