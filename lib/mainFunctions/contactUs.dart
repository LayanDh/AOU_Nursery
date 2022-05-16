import 'package:aou_nursery/mainFunctions/custom_icon.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  static const routeName = '/contact-us-screen';

  ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                item(DBIcons.logoTwitter, 'Twitter', ()  {
                  var url = 'https://twitter.com/';
                   openBrowserURL(url: url);
                }),
                item(DBIcons.logoInstagram, 'Instagram', ()  {
                  var url = 'https://instagram.com/';
                  openBrowserURL(url: url);
                }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                item(Icons.support, 'Technical support', () {
                  const url =
                      'https://www.arabou.edu.sa/ar/units/academic-advising/Pages/contact-us.aspx';
                  openBrowserURL(url: url);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget item(IconData icon, String text, VoidCallback onPressed) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: const BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.teal,
              blurRadius: 20,
            )
          ]),
          height: 110,
          width: 150,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Icon(
                icon,
                color: Colors.yellow.shade200,
                size: 50,
              ),
              TextButton(
                child: Text(text),
                onPressed: onPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future openBrowserURL({
    required String url,
  }) async {
    if (await canLaunch(url) != null) {
      await launch(url);
    } else {
      print('error');
    }
  }
}
