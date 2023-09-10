
import 'package:flutter/material.dart';

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key, required this.title});

  final String title;
  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  PlatformFile? pickedImage;
  XFile? camImage;
  
  Future selectImage() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState((){
      pickedImage = result.files.first;
    });
  }
  Future cameraImage(ImageSource source)async{
   final result = await ImagePicker().pickImage(source: source); //getting the path of the image
    if (result == null) return;

    setState(() {
      camImage = result ; // changing the profile picture
    });
  }

  Future uploadFile() async{
    final path = 'userImages/${camImage!.name}';
    final file = File(camImage!.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    //final imageRef = ref.getDownloadURL();
    
    ref.putFile(file);
  }
  
  Future downloadFile() async{
    final filePath = 'userImages/${camImage!.name}';
    final sRef = FirebaseStorage.instance.ref();
    final imageRef = sRef.child(filePath);

    try{
      const bytes = 3 * 1024 * 1024;
      final Uint8List? data = await imageRef.getData(bytes);
      return data;
    } on FirebaseException catch (e) {
      print(e);
    }

  }

  @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("abc")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (camImage != null)
            Expanded(
              child: Container(
                  color: Colors.blueAccent,
                  child: Image.file(
                    File(camImage!.path),
                    width: double.infinity ,
                    fit: BoxFit.cover,
                ),
              )
            ),
            const SizedBox(height: 32,),
            ElevatedButton(
              onPressed: selectImage,
              child: Text("gallery"),
            ),
            ElevatedButton(
              onPressed: () => cameraImage(ImageSource.camera),
              child: Text("camera"),
            ),
            ElevatedButton(
              onPressed: uploadFile,
              child: Text("upload Image"),
            ),
            Expanded(
              child: Container(
                  color: Colors.blueAccent,
                  child: Image.file(
                    File(camImage!.path),
                    width: double.infinity ,
                    fit: BoxFit.cover,
                ),
              )
            ),
          ]
            ),
          ),
      );
  }
}