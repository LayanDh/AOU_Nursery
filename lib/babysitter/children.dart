import 'package:aou_nursery/mainFunctions/register_in_nursery/child_register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Children extends StatefulWidget {
  Children({Key? key}) : super(key: key);
  static const routeName = 'Children';
  @override
  State<Children> createState() => _ChildrenState();
}

class _ChildrenState extends State<Children> {
  Stream<List<ChildInfo>> readUsers() {
    final readUser = FirebaseFirestore.instance.collection('childrenInfo').orderBy('date');
    return readUser.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => ChildInfo.fromJson(doc.data())).toList());
  }

  Widget buildUser(ChildInfo info) {
    return ListTile(
      leading: CircleAvatar(
        child: Text('Age\n '+
          info.childAge.toString(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 13,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 210, 174, 180),
      ),
      title: Text(
        'Child name: '+info.childName +'\nParent name: ' +info.parentName,
        style: const TextStyle(
          color: Color.fromARGB(255, 0, 81, 73),
          fontWeight: FontWeight.w800,
        ),
      ),
      subtitle: Text('Date: '+info.date.toIso8601String()+'\nPhone number: '+info.phoneNumber.toString()+'\n\n',
      style: const TextStyle(fontWeight: FontWeight.w600),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aou Nursery'),
      ),
      body: StreamBuilder<List<ChildInfo>>(
        stream: readUsers(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            final users = snapshot.data!.reversed;

            return ListView(
              children: users.map(buildUser).toList(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}
