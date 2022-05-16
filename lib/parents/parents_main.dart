import 'package:aou_nursery/loginPage/intro_screen.dart';
import 'package:aou_nursery/mainFunctions/chats/chat.dart';
import 'package:aou_nursery/mainFunctions/contactUs.dart';
import 'package:aou_nursery/mainFunctions/register_in_nursery/child_register.dart';
import 'package:aou_nursery/mainFunctions/reports/report_home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../mainFunctions/Nursery_photos/photo_home.dart';

Color color1 = Colors.teal.shade100;
Color color2 = Colors.teal;

class Parents_Main extends StatefulWidget {
  static const routeName = 'parentsMain';
  const Parents_Main({Key? key}) : super(key: key);

  @override
  State<Parents_Main> createState() => _Parents_MainState();
}

class _Parents_MainState extends State<Parents_Main> {
  final _auth = FirebaseAuth.instance;
  late User signedInUsrer;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUsrer = user;
        print(signedInUsrer.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
              Navigator.of(context).pushNamed(IntroScreen.routeName);
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
              size: 25,
            ),
          )
        ],
        title: const Text(
          "AOU Nursery",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal.shade200,
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          child: Stack(children: <Widget>[
            Container(
              width: width,
              height: height * .30,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color1, color2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            buildHeaderData(height, width),
            buildNotificationPanel(context, height, width),
            buildBottomBar(width),
          ]),
        ),
      ),
    );
  }

  Widget buildHeaderData(double height, double width) {
    return Positioned(
      top: (height * .30) / 4 - 40,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: new Border.all(color: Colors.teal.shade100, width: 3),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/imges/IMG_3671.JPG'),
                )),
          ),
          const SizedBox(
            height: 7,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                'Hello,',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                ' Have a Good Day!',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildBottomBar(double width) {
    return Positioned(
      bottom: 0,
      width: width,
      child: Container(
        height: 55,
        width: width,
        color: Colors.white,
        child: Material(
          elevation: 5,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  width: width / 2,
                  child: RaisedButton.icon(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(Child_Register.routeName);
                      },
                      icon: Icon(
                        Icons.app_registration_outlined,
                        size: 35,
                        color: Color(0xff065967).withOpacity(0.7),
                      ),
                      label: const Text(
                        'Register your child',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ))),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNotificationPanel(
      BuildContext context, double height, double width) {
    return Positioned(
      width: width,
      height: height * 0.70 - 80,
      top: height * 0.30 + 34,
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              buildBodyCardTitle(title: 'Nursery Children News! '),
              buildNewsItem(
                  context: context,
                  icon: Icons.article_outlined,
                  text1: 'Nursery diary',
                  text2:
                      'Here you will find everything related\nto your child\'s day in the nursery'),
              buildNewsItem(
                  context: context,
                  icon: Icons.photo_album,
                  text1: 'Special moments',
                  text2: 'You can see the wonderful pictures\nof your child'),
              buildNewsItem(
                  context: context,
                  icon: Icons.chat,
                  text1: 'Nursery forum',
                  text2:
                      'We welcome your discussions, questions,\n and suggestions here\n'),
              buildNewsItem(
                  context: context,
                  icon: Icons.feedback,
                  text1: 'FeedBack',
                  text2: 'Your feedback matters to us\n'),
              buildNewsItem(
                  context: context,
                  icon: Icons.phone,
                  text1: 'Contact informations',
                  text2: 'you will find our social media accounts\nand phone number for contact.\n'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBodyCardTitle({required String title}) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade900,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNewsItem({
    required BuildContext context,
    required IconData icon,
    required String text1,
    required String text2,
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
              colors: [color2, Color.fromARGB(255, 230, 243, 242)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Icon(
            icon,
            size: 28,
            color: Color.fromARGB(255, 245, 248, 248),
          ),
        ),
        title: const Text(
          'Aou nursery',
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              text1,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              text2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14),
            )
          ],
        ),
        onTap: () async {
          if (icon == Icons.chat) {
            Navigator.of(context).pushNamed(Chat_Screen.routeName);
          } else if (icon == Icons.feedback) {
            final url = 'https://forms.gle/ibpBz9Qtp8Y9pJBGA';
            openBrowserURL(url: url);
          } else if (icon == Icons.photo_album) {
            Navigator.of(context).pushNamed(Show_Upload.routeName);
          }else if(icon == Icons.phone){
            
            Navigator.of(context).pushNamed(ContactUsScreen.routeName);
          }
           else {
            Navigator.of(context).pushNamed(Report_home.routeName);
          }
        },
      ),
    );
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
