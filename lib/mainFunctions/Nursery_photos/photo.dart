import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddImage extends StatefulWidget {
  AddImage({Key? key}) : super(key: key);
  static const routeName = 'addImage';

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  File? _image;
  final imagePicker = ImagePicker();
  String? downloadURL;

  Future imagePickerMethod() async {
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        showSnackBar('No file selected', Duration(milliseconds: 400));
      }
    });
  }

  Future uploadimageMethod() async {

    if (_image == null) return;
    final fileName = _image!.path;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    String downloadUrl = '';
    try {
      final ref = FirebaseStorage.instance.ref('images/').child('$_image');
      TaskSnapshot uploadFile = await ref.putFile(_image!);
      if (uploadFile.state == TaskState.success) {
        downloadUrl = await uploadFile.ref.getDownloadURL();
      }
      await firebaseFirestore
          .collection('nursery pics')
          .add({'downloadURL': downloadUrl,'time':DateTime.now()});
      print(ref.fullPath);
    } catch (e) {
      print(e.toString() + 'error occured');
    }
  }

  showSnackBar(String errorText, Duration d) {
    final snackBar = SnackBar(
      content: Text(errorText),
      duration: d,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Upload Images",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.grey[100],
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: SizedBox(
            height: 550,
            width: double.infinity,
            child: Column(
              children: [
                const Text(
                  'Upload',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal),
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.teal),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: _image == null
                                ? const Center(
                                    child: Text(
                                    'No image selected',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.teal),
                                  ))
                                : Image.file(_image!),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              imagePickerMethod();
                            },
                            child: const Text(
                              'Select image',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_image != null) {
                                uploadimageMethod();
                                showSnackBar('Image Uploaded Successfully',
                                    Duration(seconds: 3));
                              } else {
                                showSnackBar(
                                    'Select Image First', Duration(seconds: 2));
                              }
                            },
                            child: const Text('Upload image',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
