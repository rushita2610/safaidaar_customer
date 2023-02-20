// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safaidaar_customer/Login.dart';

import 'Images/Images.dart';

class Intro_Screen extends StatefulWidget {
  const Intro_Screen({Key? key}) : super(key: key);

  @override
  State<Intro_Screen> createState() => _Intro_ScreenState();
}

class _Intro_ScreenState extends State<Intro_Screen> {
  bool? isReload;
  var pageController = PageController();
  bool isLastPage = false;
  final GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController MobileNumber = TextEditingController();
  bool isobscure = false;

  // void initState() {
  //   super.initState();
  // }

  // late ScrollController c;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  int _currentIndex = 0;

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    // dispose the PageController
  }

  @override
  Widget build(BuildContext context) {
    //final Sizee = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          // child: SingleChildScrollView(
          child: Container(
            //height: Sizee.height,
            height: height,
            child: PageView(
              // scrollDirection: Axis.horizontal,
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (value) {
                // setState(() {
                //   isLastPage = value == 2;
                // });
                print(value);
              },
              children: [
                buildPage(
                  index: 1,
                  color: Colors.white,
                  titletxt: "Welcome to",
                  mainimage: safaidarimg,
                  urlImage: intro_screen_one,
                  title: "Step 1: Choose the Service",
                  subTitle:
                      "We have a range of services as Dry Cleaning, Laundry & Steam Ironing to choose from",
                  nextpagelink: nextarrow,
                ),
                buildPage(
                  index: 2,
                  color: Colors.white,
                  titletxt: "Welcome to",
                  mainimage: safaidarimg,
                  urlImage: intro_screen_two,
                  title: "Step 2: Choose Pick up Date & Time",
                  subTitle:
                      "You can select the Delivery Date & Time as per your convenience",
                  nextpagelink: nextarrow,
                ),
                buildPage(
                  index: 3,
                  color: Colors.white,
                  titletxt: "Welcome to",
                  mainimage: safaidarimg,
                  urlImage: intro_screen_three,
                  title: "Step 3: Choose Delivery Option",
                  subTitle:
                      "We know how important it is to deliver your clothes on time",
                  nextpagelink: nextarrow,
                ),
              ],
            ),
          ),
          // ),
        ),
      ),
    );
  }

  Widget buildPage({
    required Color color,
    required String titletxt,
    required String mainimage,
    required int index,
    required String urlImage,
    required String title,
    required String subTitle,
    required String nextpagelink,
  }) {
    // final Sizee = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // print("${bottom_logo}bottom logo");
    return Container(
      padding: const EdgeInsets.only(top: 60),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              // top: 30,
            ),
            alignment: Alignment.topLeft,
            child: Text(
              titletxt,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 35,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            // color: Colors.red,
            // height: 80,
            height: height * 0.1,
            width: width * 0.9,
            //width: Sizee.width - 20,
            padding: const EdgeInsets.only(left: 30, right: 30),
            // alignment: Alignment.topLeft,
            child: SvgPicture.asset(
              mainimage,
              height: 50,
              // fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Flexible(
            child: SizedBox(
              // height: Sizee.height,
              // width: Sizee.width,
              height: height * 1,
              width: width * 1,
              child: Stack(
                children: [
                  Positioned(
                    bottom: height * 0.4,
                    top: 20,
                    //Sizee.height - 100,
                    left: 180,
                    // right: 0,
                    child: SizedBox(
                      // height: Sizee.height - 150,
                      // child: Transform.rotate(
                      //   angle: 131.95,
                        child:
                        ClipOval(
                          // clipper: WaveClip(),
                          child: Container(
                            decoration: BoxDecoration(
                              //shape: BoxShape.circle,
                              color: Colors.blue[200],
                            ),
                           // width: Sizee.width,
                            width: width * 1.5,
                          ),
                        ),
                     // ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    top: 0,
                    child:
                    // Transform.rotate(
                    //   angle: 131.95,
                    //   child:
                      ClippedPartsWidget(
                        // clipper: WaveClip2(),
                        bottom: Container(
                          height: height * 1,
                          color: const Color(0xFF000052),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 100,
                              ),
                              Container(
                                // height: 180,
                                // width: 180,
                                height:  height * 0.3,
                                width:  width * 0.5,
                                child: Image.asset(
                                  urlImage,
                                ),
                              ),
                              // const SizedBox(height: 10,),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: Text(
                                  title,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 25, right: 25, top: 13),
                                child: Text(
                                  subTitle,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                  maxLines: 3,
                                ),
                              ),
                            ],
                          ),
                        ),
                        splitFunction: (Size size, double x) {
                          // normalizing x to make it exactly one wave
                          final normalizedX = x / size.width * 2 * pi;
                          final waveHeight = size.height / 35;
                          final y =
                              size.height / 7 - sin(normalizedX) * waveHeight;
                          return y;
                        },
                      ),
                    //),
                  ),
                  Positioned(
                    bottom: 30,
                    right: 40,
                    // height: 45,
                    // width: 45,
                    height: height * 0.1,
                    width:  width * 0.2,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentIndex = _currentIndex + 1;
                        });
                        if (_currentIndex > 2) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        } else {
                          pageController.animateToPage(_currentIndex,
                              duration: const Duration(milliseconds: 1),
                              curve: Curves.linear);
                        }
                        // pageController.animateTo(MediaQuery
                        //     .of(context)
                        //     .size
                        //     .width, duration: const Duration(seconds: 1),
                        //     curve: Curves.linear,);
                      },
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          // alignment: Alignment.bottomRight,
                          height: 55,
                          width: 55,
                          child: Image.asset(nextpagelink),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class WaveClip extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     // Path path = new Path();
//     // final lowPoint = size.height - 30;
//     // final highPoint = size.height - 60;
//     double weight = size.width;
//     double height = size.height;
//     double offset = 40.0;
//     Path path = Path();
//     path.moveTo(0, height);
//     path.lineTo(0, height);
//     path.lineTo(weight, height);
//     path.lineTo(weight, height - (height - offset));
//     path.quadraticBezierTo(
//         4 * weight / 4, 0, weight / 3, height - (height - offset));
//     path.quadraticBezierTo(
//         weight / 5, 5 * offset, 0, height - (height - offset));
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }

class WaveClip2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // Path path = new Path();
    // final lowPoint = size.height - 30;
    // final highPoint = size.height - 60;
    double weight = size.width;
    double height = size.height;
    double offset = 40.0;
    Path path = Path();
    path.moveTo(0, height - (height - offset));
    path.lineTo(0, height);
    path.lineTo(weight, height);
    path.lineTo(weight, height - (height - offset));
    path.quadraticBezierTo(
        4 * weight / 4, 2 * offset, weight / 1.5, height - (height - offset));
    path.quadraticBezierTo(weight / 3.5, 0, 0, height - (height - offset));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class ClippedPartsWidget extends StatelessWidget {
  final Widget bottom;
  final double Function(Size, double) splitFunction;

  ClippedPartsWidget({
    required this.bottom,
    required this.splitFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // I'm putting unmodified top widget to back. I wont cut it.
        // Instead I'll overlay it with clipped bottom widget.
        Align(
          alignment: Alignment.bottomCenter,
          child: ClipPath(
            clipper: FunctionClipper(splitFunction: splitFunction),
            child: bottom,
          ),
        ),
      ],
    );
  }
}

class FunctionClipper extends CustomClipper<Path> {
  final double Function(Size, double) splitFunction;

  FunctionClipper({required this.splitFunction}) : super();

  Path getClip(Size size) {
    final path = Path();

    // move to split line starting point
    path.moveTo(0, splitFunction(size, 0));

    // draw split line
    for (double x = 1; x <= size.width; x++) {
      path.lineTo(x, splitFunction(size, x));
    }

    // close bottom part of screen
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // I'm returning fixed 'true' value here for simplicity, it's not the part of actual question
    // basically that means that clipping will be redrawn on any changes
    return true;
  }
}
