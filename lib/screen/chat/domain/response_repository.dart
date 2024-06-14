import 'package:kawaii_chat/screen/chat/domain/response_entitiy.dart';

abstract class ResponseRepository {
  Future<void> addOrMergeNewResponse({
    required ResponseEntity responseEntity,
  });

  Stream<ResponseEntity> getResponseById();

  Future<void> updateResponse({
    required ResponseEntity responseEntity,
  });

  Future<void> deleteResponse();
}
