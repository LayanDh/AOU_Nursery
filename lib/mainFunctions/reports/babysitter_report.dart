import 'package:aou_nursery/mainFunctions/reports/create_report.dart';
import 'package:aou_nursery/mainFunctions/reports/report_home.dart';
import 'package:flutter/material.dart';

Color color1 = Colors.teal;
Color color2 = Colors.teal.shade100;

class Babysitter_report extends StatefulWidget {
  const Babysitter_report({Key? key}) : super(key: key);
    static const routeName = 'babyReport';

  @override
  State<Babysitter_report> createState() => _Babysitter_reportState();
}

class _Babysitter_reportState extends State<Babysitter_report> {
  @override
 Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Report page",
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
                text1: 'Add Report',
              ),
              Divider(
                height: 3,
                color: Colors.black,
              ),
              buildNewsItem(
                context: context,
                icon: Icons.text_snippet_outlined,
                text1: 'Show Reports ',
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
            Navigator.of(context).pushNamed(Create_Report.routeName);
          } else if (icon == Icons.text_snippet_outlined) {
            Navigator.of(context).pushNamed(Report_home.routeName);
          }
        },
      ),
    );
  }
}
