import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String?> uploadMedia(File file, String path) async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(path);
    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> deleteMedia(String imagePath) async {
    await _firebaseStorage.ref().child(imagePath).delete();
  }
}
