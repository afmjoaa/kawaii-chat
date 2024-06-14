import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kawaii_chat/core/service_locator.dart';
import 'package:kawaii_chat/screen/chat/domain/response_entitiy.dart';
import 'package:kawaii_chat/screen/chat/domain/response_use_case.dart';
import 'package:kawaii_chat/screen/chat/presentation/provider/chat_model.dart';
import 'package:kawaii_chat/utility/app_constants.dart';
import 'package:uuid/data.dart';
import 'package:uuid/rng.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatNotifier extends StateNotifier<ChatModel> {
  ChatNotifier() : super(ChatModel(
    user: types.User(
      id: const Uuid().v4(config: V4Options(null, CryptoRNG())),
      // imageUrl: AppConstants.chatUserUrl,
    ),
    responseEntity: ResponseEntity(
      runningIndex: 0,
      messages: [],
      id: const Uuid().v1(),
    ),
    isInitialLoading: true,
  ));

  types.User _getCurrentUser() {
    return types.User(
      id: FirebaseAuth.instance.currentUser!.uid,
      imageUrl: AppConstants.chatUserUrl,
    );
  }

  Future<void> loadMessage()  async {
    // emit loading state
    state = ChatModel(
      user: _getCurrentUser(),
      responseEntity: state.responseEntity,
      isInitialLoading: true,
    );

    final ResponseEntity responseEntity = await sl<ResponseUseCase>()
        .getResponseById()
        .first;

    state.responseEntity.id = responseEntity.id;
    state.responseEntity.runningIndex = responseEntity.runningIndex;
    state.responseEntity.messages = responseEntity.messages;

    // emit new state
    state = ChatModel(
      user: state.user,
      responseEntity: state.responseEntity,
      isInitialLoading: false,
    );
  }

  Future<void> addMessage(types.Message message) async {
    // emit loading state
    state = ChatModel(
      user: state.user,
      responseEntity: state.responseEntity,
      isInitialLoading: false,
    );

    state.responseEntity.messages.insert(0, message);

    // add or update db
    await sl<ResponseUseCase>()
        .addOrMergeNewResponse(
      responseEntity: state.responseEntity,
    );

  }

  void updateMessages(List<types.Message> messages) {
    state = ChatModel(
      user: state.user,
      responseEntity: state.responseEntity.copyWith(
        runningIndex: messages.length,
        messages: messages,
      ),
      isInitialLoading: false,
    );
  }
}

final chatProvider = StateNotifierProvider.autoDispose<ChatNotifier, ChatModel>((ref) => ChatNotifier());