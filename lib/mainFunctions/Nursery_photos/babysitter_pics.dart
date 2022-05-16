import 'package:flutter/material.dart';
import 'package:aou_nursery/mainFunctions/Nursery_photos/photo.dart';
import 'photo_home.dart';

Color color1 = Colors.teal;
Color color2 = Colors.teal.shade100;

class Babysitter_uploadPics extends StatefulWidget {
  Babysitter_uploadPics({Key? key}) : super(key: key);
  static const routeName = 'pics';
  @override
  State<Babysitter_uploadPics> createState() => _Babysitter_uploadPicsState();
}

class _Babysitter_uploadPicsState extends State<Babysitter_uploadPics> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
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
      body: Container(
        width: width,
        height: height,
        child: Stack(children: <Widget>[
          buildNotificationPanel(context, height, width),
        ]),
      ),
    );
  }

  Widget buildNotificationPanel(
      BuildContext context, double height, double width) {
    return Positioned(
      width: width,
      height: height * 0.70 - 80,
      top: height * .10,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 16,
          left: 16,
          top: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              buildNewsItem(
                context: context,
                icon: Icons.upload_file,
                text1: 'Upload images',
              ),
              Divider(
                height: 3,
                color: Colors.black,
              ),
              buildNewsItem(
                context: context,
                icon: Icons.image,
                text1: 'Show images ',
              ),
              Divider(
                height: 3,
                color: Colors.black26,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNewsItem(
      {required BuildContext context,
      required IconData icon,
      required String text1}) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
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
            size: 40,
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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        onTap: () {
          if (icon == Icons.upload_file) {
            Navigator.of(context).pushNamed(AddImage.routeName);
          } else if (icon == Icons.image) {
            Navigator.of(context).pushNamed(Show_Upload.routeName);
          }
        },
      ),
    );
  }
}
