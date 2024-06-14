import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class Storage {
  final storageRef = FirebaseStorage.instance.ref();
  final userStorageRef = FirebaseStorage.instance.ref("${FirebaseAuth.instance.currentUser?.uid}/");

  Future<String> uploadFile({
    required Uint8List bytes,
    required String filePathWithExtension,
    required String contentType,
  }) async {
    final fileRef = userStorageRef.child(filePathWithExtension);
    final uploadTask = fileRef.putData(
        bytes,
        SettableMetadata(
          contentType: contentType,
          customMetadata: {
            "version": "one",
          },
        ));

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
