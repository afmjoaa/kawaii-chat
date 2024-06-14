import 'package:kawaii_chat/core/service_locator.dart';
import 'package:kawaii_chat/screen/chat/data/model/models.dart';
import 'package:kawaii_chat/screen/chat/data/response_database.dart';
import 'package:kawaii_chat/screen/chat/domain/response_entitiy.dart';
import 'package:kawaii_chat/screen/chat/domain/response_repository.dart';
import 'package:kawaii_chat/utility/app_constants.dart';

class ResponseRepositoryImpl extends ResponseRepository {
  @override
  Future<void> addOrMergeNewResponse({
    required ResponseEntity responseEntity,
  }) {
    return sl<ResponseDatabase>().addOrMergeNewResponse(
      responseModel: ResponseModel.fromEntity(responseEntity),
    );
  }

  @override
  Future<void> deleteResponse() {
    return sl<ResponseDatabase>().deleteResponse();
  }

  @override
  Stream<ResponseEntity> getResponseById() {
    return sl<ResponseDatabase>()
        .getResponseById()
        .map((snapShot) => ResponseModel.fromJson(snapShot.data() ??
        ResponseModel(runningIndex: 0, messages: [], id: AppConstants.responseID).toJson()).toEntity());
  }

  @override
  Future<void> updateResponse({
    required ResponseEntity responseEntity,
  }) {
    return sl<ResponseDatabase>().updateResponse(
      responseModel: ResponseModel.fromEntity(responseEntity),
    );
  }
}

