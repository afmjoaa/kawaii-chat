import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kawaii_chat/screen/chat/presentation/attachment_bottom_sheet.dart';
import 'package:kawaii_chat/screen/chat/presentation/chats_appbar.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:kawaii_chat/screen/chat/presentation/provider/chat_notifier.dart';
import 'package:kawaii_chat/utility/app_colors.dart';
import 'package:kawaii_chat/utility/utility.dart';
import 'package:mime/mime.dart';
import 'package:uuid/uuid.dart';


class ChatsScreen extends ConsumerStatefulWidget {
  static const String path = '/chats';

  const ChatsScreen({super.key});

  @override
  ConsumerState<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends ConsumerState<ChatsScreen> {
  // late ChatsCubit chatsCubit;
  late Widget? listBottomWidget;
  late Widget? customBottomWidget;

  @override
  void initState() {
    super.initState();
    // chatsCubit = ChatsCubit();
    // chatsCubit.loadMessage();
    Future.microtask(() {
      final counterNotifier = ref.read(chatProvider.notifier);
      counterNotifier.loadMessage();
    });

    listBottomWidget = null;
    customBottomWidget = null;
  }

  void _handleAttachmentPressed(types.User user) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => AttachmentBottomSheet(
        onPhotoTap: () {
          Navigator.pop(context);
          _handleImageSelection(user);
        },
        onFileTap: () {
          Navigator.pop(context);
          _handleFileSelection(user);
        },
        onCancelTap: () => Navigator.pop(context),
      ),
    );
  }

  void _handleFileSelection(types.User user) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.isNotEmpty) {
      final message = types.FileMessage(
        author: user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v1(),
        mimeType: kIsWeb ? "" : lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: kIsWeb ? "" : result.files.single.path!,
      );

      // chatsCubit.addMessage(message);
      ref.read(chatProvider.notifier).addMessage(message);
    }
  }

  void _handleImageSelection(types.User user) async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      await _addSelectedImage(result, user);
    }
  }

  Future<void> _addSelectedImage(XFile result, types.User user) async {
    final bytes = await result.readAsBytes();
    final image = await decodeImageFromList(bytes);

    final message = types.ImageMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      height: image.height.toDouble(),
      id: const Uuid().v1(),
      name: result.name,
      size: bytes.length,
      uri: result.path,
      width: image.width.toDouble(),
    );

    ref.read(chatProvider.notifier).addMessage(message);
  }

  void _handlePreviewDataFetched(
      types.TextMessage message,
      types.PreviewData previewData,
      List<types.Message> messages,
      ) {
    final index = messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    messages[index] = updatedMessage;
    ref.read(chatProvider.notifier).updateMessages(messages);
  }

  void _handleSendPressed(types.PartialText message, types.User user) {
    final textMessage = types.TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v1(),
      text: message.text,
    );

    ref.read(chatProvider.notifier).addMessage(textMessage);
  }

  @override
  Widget build(BuildContext context) {

    final state = ref.watch(chatProvider);
    if (state.isInitialLoading) {
      Utility.startLoadingAnimation();
    } else {
      Utility.completeLoadingAnimation();
    }

    
    // return BlocBuilder<ChatsCubit, ChatsState>(
    //   bloc: chatsCubit,
    //   builder: (context, state) {
    //
    return Scaffold(
          appBar: const ChatsAppbar(
            title: 'Kawaii Chat',
          ),
          body: Chat(
            messages: state.responseEntity.messages,
            customBottomWidget: customBottomWidget,
            listBottomWidget: listBottomWidget,
            onAttachmentPressed: () {
              _handleAttachmentPressed(state.user);
            },
            onMessageTap: _handleMessageTap,
            onPreviewDataFetched: (textMessage, previewData) {
                _handlePreviewDataFetched(textMessage, previewData,
                    state.responseEntity.messages);
            },
            onSendPressed: (text) {
              _handleSendPressed(text, state.user);
            },
            showUserAvatars: true,
            showUserNames: true,
            user: state.user,
            theme: DefaultChatTheme(
              inputTextDecoration: const InputDecoration(
                isDense: true,
                contentPadding:
                EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                labelStyle: TextStyle(color: AppColors.textPrimary),
                floatingLabelStyle: TextStyle(color: AppColors.primary),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              attachmentButtonMargin: EdgeInsets.all(0),
              inputBackgroundColor: AppColors.color_F5F5F7,
              inputSurfaceTintColor: AppColors.color_F5F5F7,
              inputTextColor: AppColors.color_000000,
              inputTextCursorColor: AppColors.primary,
              inputBorderRadius: BorderRadius.vertical(
                top: Radius.circular(listBottomWidget != null ? 0 : 28),
              ),
              inputContainerDecoration: BoxDecoration(
                color: AppColors.color_F5F5F7,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: listBottomWidget != null ? 0 : 2,
                    blurRadius: listBottomWidget != null ? 0 : 4,
                    offset: const Offset(1, 3),
                  ),
                ],
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
              ),
              inputElevation: 3,
              primaryColor: AppColors.primary,
            ),
          ),
        );
    //   },
    // );
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    print("Message is tapped");
  }
}
