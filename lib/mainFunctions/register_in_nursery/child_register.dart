import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'success.dart';

Color color1 = Colors.teal;
Color color2 = Colors.teal.shade100;

class Child_Register extends StatefulWidget {
  static const routeName = 'ChildRegester';
  const Child_Register({Key? key}) : super(key: key);

  @override
  State<Child_Register> createState() => _Child_RegisterState();
}

class _Child_RegisterState extends State<Child_Register> {
  final parentNameController = TextEditingController();
  final childNameController = TextEditingController();
  final childAgeController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final dateTimerController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  void _trySubmit() {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formkey.currentState?.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Aou Nursery')),
      body: Form(
        key: _formkey,
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            SizedBox(
              height: 24,
            ),
            TextField(
              controller: parentNameController,
              decoration: InputDecoration(
                labelText: 'Parent Name',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            TextField(
              controller: childNameController,
              decoration: const InputDecoration(
                labelText: 'Child Name',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            TextField(
              controller: childAgeController,
              keyboardType: const TextInputType.numberWithOptions(),
              decoration: const InputDecoration(
                labelText: 'Child Age',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            TextField(
              controller: phoneNumberController,
              keyboardType: const TextInputType.numberWithOptions(),
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Text(' Select Date & Time '),
            DateTimeField(
              controller: dateTimerController,
              format: DateFormat("yyyy-MM-dd HH:mm"),
              onShowPicker: (context, currentValue) async {
                final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
                if (date != null) {
                  final time = await showTimePicker(
                    context: context,
                    initialTime:
                        TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                  );
                  return DateTimeField.combine(date, time);
                } else {
                  return currentValue;
                }
              },
            ),
            SizedBox(
              height: 32,
            ),
            Divider(
              height: 3,
              color: Colors.black,
            ),
            buildNewsItem(
              context: context,
              icon: Icons.attach_money_outlined,
              text1:
                  '1 hour: 40 SAR\nYou can pay when you bring your child\nto nursery or by bank transfer.',
            ),
            buildNewsItem(
              context: context,
              icon: Icons.account_balance,
              text1:
                  '\nRiyadh Bank:- \nIBAN: SA51 2000 0002 3307 4570 9940\n\nSampa:\nIBAN:SA25 4000 0000 0000 0190 6488',
            ),
            const SizedBox(
              height: 32,
            ),
            ElevatedButton(
              onPressed: () {
                try {
                  final user = ChildInfo(
                    parentName: parentNameController.text,
                    childName: childNameController.text,
                    childAge: int.parse(childAgeController.text),
                    phoneNumber: int.parse(phoneNumberController.text),
                    date: DateTime.parse(dateTimerController.text),
                    attend: 'false',
                  );
                  creatUser(user: user);
                  Navigator.of(context).pushNamed(Success.routeName);
                } catch (e) {
                  Fluttertoast.showToast(
                      msg: 'Please you must fill all fields in correct way!',
                      gravity: ToastGravity.TOP,
                      backgroundColor: Colors.red,
                      toastLength: Toast.LENGTH_LONG,
                      fontSize: 20);
                }
              },
              child: const Text('Next',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Future creatUser({required ChildInfo user}) async {
    final docUser = FirebaseFirestore.instance.collection('childrenInfo').doc();
    user.id = docUser.id;
    final json = user.toJson();

    await docUser.set(json);
  }

  Widget buildNewsItem({
    required BuildContext context,
    required IconData icon,
    required String text1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 10),
        leading: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [color1, Color.fromARGB(255, 230, 243, 242)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Icon(
            icon,
            size: 28,
            color: Colors.white70,
          ),
        ),
        title: Text(
          'Pay & Price',
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              text1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}

class ChildInfo {
  late String id;
  late final String parentName;
  late final String childName;
  late final int childAge;
  late final int phoneNumber;
  late final DateTime date;
  String attend = 'false';

  ChildInfo(
      {this.id = '',
      required this.parentName,
      required this.childName,
      required this.childAge,
      required this.phoneNumber,
      required this.date,
      required this.attend});

  Map<String, dynamic> toJson() => {
        'id': id,
        'parent name': parentName,
        'child name': childName,
        'child Age': childAge,
        'phone Number': phoneNumber,
        'date': date,
        'attend': attend
      };

  static ChildInfo fromJson(Map<String, dynamic> json) {
    return ChildInfo(
      id: json['id'],
      parentName: json['parent name'],
      childName: json['child name'],
      childAge: json['child Age'],
      phoneNumber: json['phone Number'],
      date: (json['date'] as Timestamp).toDate(),
      attend: 'false',
    );
  }
}
