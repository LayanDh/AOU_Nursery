import 'package:aou_nursery/loginPage/parents_screen.dart';
import 'package:aou_nursery/widgetsFolder/original_button.dart';
import 'package:flutter/material.dart';
import 'babysitter_screen.dart';

class IntroScreen extends StatelessWidget {
  static const routeName = 'intro';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const SizedBox( ),
              Image.asset(
                'assets/imges/newLogo.png',
              ),
              Column(
                children: [
                  OriginalButton(
                    text: 'Parents',
                    onPressed: () {
                      Navigator.of(context).pushNamed(ParentsLogin.routeName);
                    },
                        
                    textColor: Colors.white,
                    bgColor: Colors.teal.shade200,
                  ),
                  Text(''),
                  OriginalButton(
                    text: 'Babysitter',
                    onPressed: () => Navigator.of(context)
                        .pushNamed(BabysitterLogin.routeName),
                    textColor: Colors.white,
                    bgColor: Colors.teal,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
