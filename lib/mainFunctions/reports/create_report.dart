import 'dart:io';

import 'package:aou_nursery/mainFunctions/reports/report_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class Create_Report extends StatefulWidget {
  Create_Report({Key? key}) : super(key: key);
  static const routeName = 'CreateReport';

  @override
  State<Create_Report> createState() => _Create_ReportState();
}

class _Create_ReportState extends State<Create_Report> {
  File? sampleImage;
  final imagePicker = ImagePicker();
  final formKey =  GlobalKey<FormState>();
  String url = '';
  late String _myValue;
  String? downloadURL;

  Future getImage() async {
    final tempImage = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (tempImage != null) {
        sampleImage = File(tempImage.path);
      } else {
        print('No file selected');
      }
    });
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void uploadStatusImage() async {
    if (validateAndSave()) {
      Reference imageref =
          FirebaseStorage.instance.ref().child('Report images');
     // FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var timeKey = DateTime.now();
      UploadTask task =
          imageref.child(timeKey.toString() + ".jpg").putFile(sampleImage!);
      var imageUrl =
          await (await task.whenComplete(() => null)).ref.getDownloadURL();
      url = imageUrl.toString();
      print(url);

      goToPostsHome();
      saveToDatabase(url);
    }
  }

  void saveToDatabase(String url) {
    var dbTimeKey = DateTime.now();
    var formatDate = DateFormat('MMM d, yyyy');
    var formatTime = DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);
   // final docUser = FirebaseFirestore.instance.collection('Post').doc();
    DatabaseReference dbref = FirebaseDatabase.instance.ref();
    var iemagData = {
      "image": url,
      'description': _myValue,
      'date': date,
      'time': time
    };
    dbref.child('Post').push().set(iemagData);
    //docUser.set(iemagData);
  }

  void goToPostsHome() {
    Navigator.of(context).pushNamed(Report_home.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "AOU nursery",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          
          child: sampleImage == null ? const Text('Select an Image') : enableUpload(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Add Image',
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }

  Widget enableUpload() {
    return Container(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Image.file(
              sampleImage!,
              height: 330.0,
              width: 660.0,
            ),
            const SizedBox(
              height: 15.0,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              validator: (value) {
                return value!.isEmpty ? 'Blod Description is required' : null;
              },
              onSaved: (value) {
                _myValue = value!;
              },
            ),
            const SizedBox(
              height: 15.0,
            ),
            RaisedButton(
                elevation: 10.0,
                child: const Text('Add a New Report'),
                textColor: Colors.white,
                color: Colors.teal,
                onPressed: () {
                  uploadStatusImage();
                }),
          ],
        ),
      ),
    );
  }
}
