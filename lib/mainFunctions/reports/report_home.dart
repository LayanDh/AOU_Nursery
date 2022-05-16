import 'package:aou_nursery/mainFunctions/reports/post.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Report_home extends StatefulWidget {
  Report_home({Key? key}) : super(key: key);
  static const routeName = 'homeReport';

  @override
  State<Report_home> createState() => _Report_homeState();
}

class _Report_homeState extends State<Report_home> {
  List<Post> postList = [];
  List<String> KEYS = [];

  List DATA = [];

  @override
  void initState() {
    super.initState();
    getFuture();
  }

  late Future<DatabaseEvent>? postRef;
  void getFuture() {
    postRef = FirebaseDatabase.instance.ref().child('Post').once();
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
        body: FutureBuilder<DatabaseEvent>(
          future: postRef,
          builder: (context, snap) {
            DATA.clear();
            if (snap.hasData) {
              snap.data?.snapshot.children.forEach((element) {
                DATA.add(element.value);
              });
              return ListView.builder(
                  itemCount: DATA.length,
                  itemBuilder: (context, i) {
                    var reversed= DATA.reversed.toList();
                    return Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          child: Image.network(reversed[i]['image']),
                          height: 250,
                        ),
                        ListTile(
                          title: Text(reversed[i]['description']),
                          trailing: Text(reversed[i]['date'].toString()),
                        ),
                      ],
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
