import 'package:aou_nursery/parents/parents_main.dart';
import 'package:flutter/material.dart';

Color color1 = Colors.teal;
Color color2 = Colors.teal.shade100;

class Success extends StatelessWidget {
  const Success({Key? key}) : super(key: key);
  static const routeName = 'Success';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.check,
              size: 50,
            ),
            SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Your child has been \nsuccessfully registered',
                  style: TextStyle(
                    color: Colors.teal.shade700,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Divider(
              height: 10,
              color: Colors.black,
            ),
            SizedBox(
              height: 40,
            ),
            buildNewsItem(
              context: context,
              icon: Icons.account_circle_rounded,
              text1: 'Go back to the main page',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNewsItem({
    required BuildContext context,
    required IconData icon,
    required String text1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 30),
        leading: Container(
          height: 40,
          width: 40,
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
          ],
        ),
        onTap: () {
           Navigator.of(context).pushNamed(Parents_Main.routeName);
        },
      ),
    );
  }
}
