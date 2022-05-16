import 'package:aou_nursery/widgetsFolder/auth_form.dart';
import 'package:flutter/material.dart';


class BabysitterLogin extends StatelessWidget {
  static const routeName = 'baLogin';

  const BabysitterLogin({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    // ignore: prefer_const_constructors
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50))),
                  ),
                  Center(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 2,
                        ),
                        const Text(
                          'Welcome to AOU Nursery!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Image.asset(
                          'assets/imges/newBaby.png',
                          height: 270,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              AouthForm(
                type: 'baby',
                ),
            ],
          ),
        ));
  }
}
