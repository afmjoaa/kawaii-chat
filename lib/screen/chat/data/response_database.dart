import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kawaii_chat/screen/chat/data/model/models.dart';
import 'package:kawaii_chat/utility/app_constants.dart';

class ResponseDatabase {
  CollectionReference _getRef() {
    return FirebaseFirestore.instance
        .collection("responses");
  }

  Future<void> addOrMergeNewResponse({
    required ResponseModel responseModel,
  }) async {
    return await _getRef().doc(responseModel.id).set(responseModel.toJson(), SetOptions(merge: true));
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getResponseById() {
    return FirebaseFirestore.instance
        .collection("responses")
        .doc(AppConstants.responseID)
        .snapshots();
  }

  Future<void> updateResponse({
    required ResponseModel responseModel,
  }) async {
    return await _getRef().doc(responseModel.id).update(responseModel.toJson());
  }

  Future<void> deleteResponse() async {
    return await _getRef().doc(AppConstants.responseID).delete();
  }
}
