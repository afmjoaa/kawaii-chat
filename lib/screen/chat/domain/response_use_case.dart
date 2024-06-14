import 'package:kawaii_chat/core/service_locator.dart';
import 'package:kawaii_chat/screen/chat/domain/response_entitiy.dart';
import 'package:kawaii_chat/screen/chat/domain/response_repository.dart';

class ResponseUseCase {
  const ResponseUseCase();

  Future<void> addOrMergeNewResponse({
    required ResponseEntity responseEntity,
  }) {
    return sl<ResponseRepository>().addOrMergeNewResponse(
      responseEntity: responseEntity,
    );
  }

  Stream<ResponseEntity> getResponseById() {
    return sl<ResponseRepository>().getResponseById(
    );
  }

  Future<void> updateResponse({
    required ResponseEntity responseEntity,
  }) {
    return sl<ResponseRepository>().updateResponse(
      responseEntity: responseEntity,
    );
  }

  Future<void> deleteResponse() {
    return sl<ResponseRepository>().deleteResponse();
  }
}
