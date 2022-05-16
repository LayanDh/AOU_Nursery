import 'package:aou_nursery/babysitter/babysitter_main.dart';
import 'package:aou_nursery/parents/parents_main.dart';
import 'package:aou_nursery/parents/parents_register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'original_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AouthForm extends StatefulWidget {
  final String type;
  AouthForm({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  State<AouthForm> createState() => _AouthFormState();
}

class _AouthFormState extends State<AouthForm> {
  final _auth = FirebaseAuth.instance;
  final _babyAuth = FirebaseAuth.instance;
  final dbRef = FirebaseDatabase.instance.ref().child('Users');
  final _formkey = GlobalKey<FormState>();
  var _userEmail = ' ';
  var _userName = ' ';
  var _userPassword = ' ';

  void _loginBabysitter() async {
    try {
      final newUser = await _babyAuth.signInWithEmailAndPassword(
          email: _userEmail, password: _userPassword);
      if (newUser != null) {
        final User? user = _babyAuth.currentUser;
        final userId = user?.uid;
        FirebaseDatabase database = FirebaseDatabase.instance;
        DatabaseReference ref = database.ref("Users/$userId").child("role");
        DatabaseEvent event = await ref.once();
        //print(event.snapshot.value);
        if (event.snapshot.value == 'Admin') {
          Navigator.of(context).pushNamed(Babysitter_Main.routeName);
        } else if (event.snapshot.value != 'Admin') {
          Fluttertoast.showToast(
              msg: 'You are not a babysitter please use parents page',
              gravity: ToastGravity.TOP,
              backgroundColor: Colors.red,
              toastLength: Toast.LENGTH_LONG,
              fontSize: 20);
        }
      }
    } catch (err) {
      Fluttertoast.showToast(
          msg:
              'Wrong email or password!',
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_LONG,
          fontSize: 20);
    }
  }

  void _loginParents() async {
    try {
      final newUser = await _babyAuth.signInWithEmailAndPassword(
          email: _userEmail, password: _userPassword);
      if (newUser != null) {
        final User? user = _babyAuth.currentUser;
        final userId = user?.uid;
        FirebaseDatabase database = FirebaseDatabase.instance;
        DatabaseReference ref = database.ref("Users/$userId").child("email");
        DatabaseEvent event = await ref.once();
       // print(event.snapshot.value);
        if (event.snapshot.value != 'babysitter@gmail.com') {
          Navigator.of(context).pushNamed(Parents_Main.routeName);
        } else {
          Fluttertoast.showToast(
              msg: 'You do not have permission to access parents account',
              gravity: ToastGravity.TOP,
              backgroundColor: Colors.red,
              toastLength: Toast.LENGTH_LONG,
              fontSize: 20);
        }
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg:
              'Wrong email or password, please check that you have an account or your information is correct!',
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_LONG,
          fontSize: 20);
    }
  }

  Future openBrowserURL({
    required String url,
  }) async {
    if (await canLaunch(url) != null) {
      await launch(url);
    } else {
      Fluttertoast.showToast(
          msg: 'sorry the url does not found',
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_LONG,
          fontSize: 20);
    }
  }

  void _trySubmit() {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formkey.currentState?.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        child: Column(
          children: <Widget>[
            if (widget.type == 'paRegester')
              TextFormField(
                key: ValueKey('username'),
                validator: (Value) {
                  if (Value!.isEmpty || Value.length < 3) {
                    return 'Please enter at least 3 characters';
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'User name',
                ),
                onSaved: (Value) {
                  _userName = Value!;
                },
              ),
            const SizedBox(height: 16),
            TextFormField(
              key: ValueKey('Email'),
              validator: (Value) {
                if (Value!.isEmpty || !Value.contains('@')) {
                  return 'Please enter a valid eamil';
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: 'Email address',
                hintText: 'ex: name@gmail.com',
              ),
              onSaved: (Value) {
                _userEmail = Value!;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              key: ValueKey('password'),
              validator: (Value) {
                if (Value!.isEmpty || Value.length < 7) {
                  return 'Your password must be more than 6 characters';
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: 'Password',
              ),
              obscureText: true,
              onSaved: (Value) {
                _userPassword = Value!;
              },
            ),
            const SizedBox(
              height: 12,
            ),
            OriginalButton(
                text: (widget.type == 'paRegester' ? 'Signup' : 'Login'),
                onPressed: () async {
                  if (widget.type == 'parents') {
                    _trySubmit();
                    _loginParents();
                  } else if (widget.type == 'baby') {
                    _trySubmit();
                    _loginBabysitter();
                  } else if (widget.type == 'paRegester') {
                    _trySubmit();
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: _userEmail, password: _userPassword);
                      Navigator.of(context).pushNamed(Parents_Main.routeName);

                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(newUser.user!.uid)
                          .set({'username': _userName, 'email': _userEmail});
                    } on FirebaseAuthException catch (err) {
                      Fluttertoast.showToast(
                          msg: 'The email already exists!',
                          gravity: ToastGravity.TOP,
                          backgroundColor: Colors.red,
                          toastLength: Toast.LENGTH_LONG,
                          fontSize: 20);
                    }
                  }
                },
                textColor: Colors.white,
                bgColor: widget.type == 'parents' || widget.type == 'paRegester'
                    ? Colors.teal.shade200
                    : Colors.teal),
            if (widget.type == 'parents') ...[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(ParentsRegister.routeName);
                },
                child: Text(
                  'Don\'t have an acount?',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                ),
              ),
            ] else if (widget.type == 'baby') ...[
              TextButton(
                onPressed: () {
                  final url = 'https://forms.gle/Qex4vBSNmmwSVrVt6';
                  openBrowserURL(url: url);
                },
                child: Text(
                  'Apply for a job in AOU Nursery',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
