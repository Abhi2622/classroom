import 'dart:async';

import 'package:classroom/Screens/HomePage/HomePage.dart';
import 'package:classroom/SupportingWidget/Qtext.dart';
import 'package:classroom/SupportingWidget/navigationHelper.dart';
import 'package:classroom/res/color.dart';
import 'package:classroom/res/images.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                splashImage,
                fit: BoxFit.cover,
              ),
            ),
            const Center(
              child: QText(
                "ClassRoom",
                fontSize: 27,
                fontWeight: FontWeight.w700,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1500), () {
      pushAndReplace(context, HomePage(),);
    });
  }
}
