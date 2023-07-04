import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'HomePage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  OneSignal.shared.setAppId("488d259d-51f6-4e38-aba8-2d2d43fb8487");
  runApp(MaterialApp(home: SplashScreen(),theme: ThemeData.dark(),));
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigateToHomepage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
    );
  }

  void navigateToHomepage() {
    Future.delayed(Duration(seconds: 2)).whenComplete(() {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return HomePage(

          );
        },
      ));
    });
  }
}

//488d259d-51f6-4e38-aba8-2d2d43fb8487
