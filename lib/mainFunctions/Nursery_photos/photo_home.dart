import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Show_Upload extends StatefulWidget {
  Show_Upload({Key? key}) : super(key: key);
  static const routeName = 'photo_page';
  @override
  State<Show_Upload> createState() => _Show_UploadState();
}

class _Show_UploadState extends State<Show_Upload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Special moments",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.grey[100],
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('nursery pics')
              .orderBy('time')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.reversed.length,
                  itemBuilder: (BuildContext context, int index) {
                   var data= snapshot.data!.docs.reversed.toList();
                    String url = data[index]['downloadURL'];
                    return Container(
                      margin: const EdgeInsets.all(8),
                      child: Image.network(
                        url,
                        height: 300,
                        fit: BoxFit.fill,
                      ),
                    );
                  });
            }
          }),
    );
  }
}
