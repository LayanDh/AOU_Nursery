import 'package:aou_nursery/loginPage/intro_screen.dart';
import 'package:aou_nursery/mainFunctions/Nursery_photos/babysitter_pics.dart';
import 'package:aou_nursery/mainFunctions/chats/chat.dart';
import 'package:aou_nursery/mainFunctions/reports/babysitter_report.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'children.dart';

Color color1 = Colors.teal;
Color color2 = Colors.teal.shade100;

class Babysitter_Main extends StatefulWidget {
  static const routeName = 'babyMain';
  const Babysitter_Main({Key? key}) : super(key: key);

  @override
  State<Babysitter_Main> createState() => _Babysitter_MainState();
}

class _Babysitter_MainState extends State<Babysitter_Main> {
  final _auth = FirebaseAuth.instance;
  late User signedInUsrer;

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
            icon: Icon(
              Icons.logout,
              color: Colors.white,
              size: 25,
            ),
          )
        ],
        title: Text(
          "AOU nursery",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal,
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
          ]),
        ),
      ),
    );
  }

  Widget buildHeaderData(double height, double width) {
    return Positioned(
      top: (height * .30) / 3 - 40,
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
                  image: AssetImage('assets/imges/first.jpeg'),
                )),
          ),
          SizedBox(
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
              buildBodyCardTitle(title: 'Babysitter Functions'),
              Divider(
                height: 3,
                color: Colors.black26,
              ),
              buildNewsItem(
                  context: context,
                  icon: Icons.article_outlined,
                  text1: 'Upload report',
                  text2: 'Upload reports and news of the nursery '),
              Divider(
                height: 3,
                color: Colors.black,
              ),
              buildNewsItem(
                  context: context,
                  icon: Icons.photo_album,
                  text1: 'Uplode pictures',
                  text2: 'Choose the child and upload the pictures'),
              Divider(
                height: 3,
                color: Colors.black26,
              ),
              buildNewsItem(
                  context: context,
                  icon: Icons.chat,
                  text1: 'Contact parents',
                  text2: 'Messaging the parents'),
              Divider(
                height: 3,
                color: Colors.black26,
              ),
                            buildNewsItem(
                  context: context,
                  icon: Icons.checklist,
                  text1: 'checklist attendance',
                  text2: ' '),
              Divider(
                height: 3,
                color: Colors.black,
              ),
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

  Widget buildNewsItem(
      {required BuildContext context,
      required IconData icon,
      required String text1,
      required String text2}) {
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
              colors: [color1, color2],
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
        onTap: () {
          if (icon == Icons.chat) {
            Navigator.of(context).pushNamed(Chat_Screen.routeName);
          } else if (icon == Icons.photo_album) {
            
            Navigator.of(context).pushNamed(Babysitter_uploadPics.routeName);
          } else if(icon == Icons.article_outlined) {
            Navigator.of(context).pushNamed(Babysitter_report.routeName);
          } else{
            Navigator.of(context).pushNamed(Children.routeName);
          }
        },
      ),
    );
  }
}
