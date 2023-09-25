import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class Service{
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  
  Future<String?> uploadMedia(File file,String path) async {
    
    Reference ref = _firebaseStorage.ref().child(path);
    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();  
    return downloadUrl;
  }

}