// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:safaidaar_customer/BottomNavigationScreen.dart';
import 'package:safaidaar_customer/Home_Screen.dart';
import 'package:safaidaar_customer/Intro_Screens.dart';
import 'package:floating_bubbles/floating_bubbles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class First_Screen extends StatefulWidget {
  const First_Screen({Key? key}) : super(key: key);

  @override
  State<First_Screen> createState() => _First_ScreenState();
}

class _First_ScreenState extends State<First_Screen> {
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  bool isReload = false;

  // Future<Null> getSharedPrefs() async {
  //   print("enter");
  //
  //   Future.delayed(const Duration(seconds: 5), () async {
  //     print("enter navigation");
  //     Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const Intro_Screen(),
  //         ));
  //   });
  // }

  Future check() async {
    Future.delayed(const Duration(seconds: 2), () async {
      print("enter navigation");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String isLogin = prefs.getString("isLogin") ?? '';
      print(isLogin);
      if (isLogin == "login") {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => BottomNavigationScreen(0),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Intro_Screen(),
          ),
        );
      }

    });
  }

  @override
  void initState() {
    super.initState();
    // getSharedPrefs();
    Timer(Duration(seconds: 2), () {
      check();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // final Size = MediaQuery.of(context).size;
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Container(
        // height: Size.height,
        // width: Size.width,
        height: height * 1,
        width: width * 1,
        // padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            Positioned(
              // left: 50,
              // right: 50,
              // height: Size.height,
              // top: Size.height / 2,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                height: height * 1,
                width: width * 1,
                child: SvgPicture.asset(
                  "assets/customer_application_logo.svg",
                ),
              ),
            ),
            Positioned.fill(
              left: -2,
              top: 10,
              //bottom: 80,
              child: FloatingBubbles.alwaysRepeating(
                noOfBubbles: 200,
                strokeWidth: 1.5,
                colorsOfBubbles: const [
                  Colors.blue,
                  // Colors.red,
                ],
                sizeFactor: 0.05,
                opacity: 80,
                speed: BubbleSpeed.slow,
                paintingStyle: PaintingStyle.stroke,
                shape: BubbleShape.circle, //This is the default
              ),
            ),
          ],
        ),
      ),
    );
  }
}
