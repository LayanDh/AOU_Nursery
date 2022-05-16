import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:aou_nursery/mainFunctions/Nursery_photos/photo_home.dart';
import 'package:aou_nursery/mainFunctions/chats/chat.dart';
import 'package:aou_nursery/mainFunctions/contactUs.dart';
import 'package:aou_nursery/mainFunctions/reports/babysitter_report.dart';
import 'package:aou_nursery/mainFunctions/reports/create_report.dart';
import 'package:aou_nursery/mainFunctions/reports/report_home.dart';
import 'package:aou_nursery/parents/parents_main.dart';
import 'package:aou_nursery/parents/parents_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'babysitter/babysitter_main.dart';
import 'babysitter/children.dart';
import 'loginPage/babysitter_screen.dart';
import 'loginPage/intro_screen.dart';
import 'loginPage/parents_screen.dart';
import 'mainFunctions/Nursery_photos/babysitter_pics.dart';
import 'mainFunctions/chats/chat.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart'; 
import 'mainFunctions/Nursery_photos/photo.dart';
import 'mainFunctions/Nursery_photos/photo_home.dart';
import 'mainFunctions/register_in_nursery/child_register.dart';
import 'mainFunctions/register_in_nursery/success.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  debugShowCheckedModeBanner:
  false;
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AOU Nursery',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          //fillColor: Color(0xFFE0F2F1),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal.shade200),
            borderRadius: BorderRadius.circular(25),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.teal),
            borderRadius: BorderRadius.circular(25),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.teal),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => AnimatedSplashScreen(
              splash: 'assets/imges/newLogo.png',
              splashIconSize: 300,
              nextScreen: IntroScreen(),
              splashTransition: SplashTransition.scaleTransition,
              pageTransitionType: PageTransitionType.bottomToTop,
              duration: 2500,
            ),
        IntroScreen.routeName: (context) => IntroScreen(),
        ParentsLogin.routeName: (context) => const ParentsLogin(),
        BabysitterLogin.routeName: (context) => const BabysitterLogin(),
        Parents_Main.routeName: (context) => const Parents_Main(),
        Babysitter_Main.routeName: (context) => const Babysitter_Main(),
        ParentsRegister.routeName: (context) => const ParentsRegister(),
        Child_Register.routeName: (context) => const Child_Register(),
        Chat_Screen.routeName: (context) => const Chat_Screen(),
        Show_Upload.routeName: (context) => Show_Upload(),
        AddImage.routeName: (context) => AddImage(),
        Babysitter_uploadPics.routeName: (context) => Babysitter_uploadPics(),
        Babysitter_report.routeName: (context) => Babysitter_report(),
        Report_home.routeName: (context) => Report_home(),
        Create_Report.routeName: (context) => Create_Report(),
        Children.routeName: (context) => Children(),
        Success.routeName: (context) => const Success(),
        ContactUsScreen.routeName: (context) => ContactUsScreen(),
      },
    );
  }
}
