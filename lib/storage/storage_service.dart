import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:kawaii_chat/storage/progess_entity.dart';

class StorageService {
  final storageRef = FirebaseStorage.instance.ref();
  final userStorageRef = FirebaseStorage.instance.ref("${FirebaseAuth.instance.currentUser?.uid}/");

  Future<String> uploadFile({
    required Uint8List bytes,
    required StreamController<ProgressEntity> progressController,
    required String filePathWithExtension,
    required String contentType,
  }) async {
    // "avatarHeads/${DateTime.now().toString()}.$fileExtension"
    final fileRef = userStorageRef.child(filePathWithExtension);
    final uploadTask = fileRef.putData(
        bytes,
        SettableMetadata(
          contentType: contentType,
          customMetadata: {
            "version": "one",
          },
        ));

    // Listen for state changes, errors, and completion of the upload.
    double progress = 0;
    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          progress = (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          progressController.sink
              .add(ProgressEntity(progress, UploadState.running));
          break;
        case TaskState.paused:
          progressController.sink
              .add(ProgressEntity(progress, UploadState.paused));
          break;
        case TaskState.canceled:
          progressController.sink.add(ProgressEntity(0, UploadState.canceled));
          break;
        case TaskState.error:
          progressController.sink.add(ProgressEntity(0, UploadState.failed));
          break;
        case TaskState.success:
          progressController.sink
              .add(ProgressEntity(progress, UploadState.succeed));
          break;
      }
    });
    final snapshot = await uploadTask.whenComplete(() => null);
    final urlImageUser = await snapshot.ref.getDownloadURL();
    return urlImageUser;
  }

  Future<String> getFileDownloadLink(String filePath) async {
    return await userStorageRef.child(filePath).getDownloadURL();
  }

  Future<void> deleteStorageFile({
    required String filePath,
  }) async {
    final desertRef = userStorageRef.child(filePath);
    await desertRef.delete();
  }

  Future<void> deleteStorageDirectory({
    required String directoryPath,
  }) async {
    await userStorageRef.child(directoryPath).listAll().then(
          (value) {
        for (var element in value.items) {
          storageRef.child(element.fullPath).delete();
        }
      },
    );
  }

  Future<List<String>> listAllMedia({
    required String path,
    List<String> fileUrls = const [],
  }) async {
    final listResult = await storageRef.child(path).listAll();

    // Process prefixes
    for (var prefix in listResult.prefixes) {
      fileUrls = await listAllMedia(path: prefix.fullPath, fileUrls: fileUrls);
    }

    // Process items
    for (var item in listResult.items) {
      fileUrls.add(item.fullPath);
    }
    return fileUrls;
  }
}
