// ignore_for_file: deprecated_member_use, non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safaidaar_customer/Api/Api_Url.dart';
import 'package:safaidaar_customer/BottomNavigationScreen.dart';
import 'package:safaidaar_customer/C%20&%20Refund%20Policy.dart';
import 'package:safaidaar_customer/OTP_Screen.dart';
import 'package:safaidaar_customer/Privacy_Policy.dart';
import 'package:safaidaar_customer/Registration_Screen.dart';
import 'package:safaidaar_customer/T&C.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AboutUs_Screen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool? isReload;
  final pageController = PageController();
  bool isLastPage = false;
  final GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController MobileNumber = TextEditingController();
  bool isobscure = false;

  void initState() {
    super.initState();
  }

  // void CheckUserMobile() {
  //   print('text field: "+91 ${MobileNumber.text}"');
  //   Checkuser_ApiCall("+91 ${MobileNumber.text}");
  // }

  // int _currentIndex = 0;

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    // dispose the PageController
  }

  String isvalidMobile = "";
  String strMobilevalidator = "";
  String isLoggedin = "";

  //String msg = '';

  Future<void> _showvalidationdialogbox({required String msg}) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => Container(
        height: 100,
        // width: MediaQuery.of(context).size.width - 40,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          title: Column(
            children: [
              Text(
                msg,
                style: const TextStyle(
                  fontSize: 17.5,
                  // fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 2,
                child: RaisedButton(
                  color: const Color(0xFF000052),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "OK",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Sizee = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              // padding: const EdgeInsets.only(top: 20),
              height: height,
              width: width,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      // color: Colors.red,
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 30),
                      width: width * 0.5,
                      // height: 150,
                      alignment: Alignment.topRight,
                      child: RaisedButton(
                        color: const Color(0xFF000052),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString("isLogin", "skip");
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    const BottomNavigationScreen(0)),
                          );
                        },
                        child: const Text(
                          "Skip",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 20,
                    ),
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "Login/Sign up",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 35,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    // color: Colors.red,
                    height: height * 0.15,
                    width: width * 0.9,
                    padding: const EdgeInsets.only(left: 0, right: 30),
                    // alignment: Alignment.topLeft,
                    child: SvgPicture.asset(
                      "assets/customer_application_logo.svg",
                      height: 50,
                      // fit: BoxFit.cover,
                    ),
                  ),
                  Flexible(
                    child: SizedBox(
                      height: double.infinity,
                      // color: Colors.red,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: height * 0.4,
                            top: 20,
                            //Sizee.height - 100,
                            left: 200,
                            // right: 10,
                            child: SizedBox(
                              // height: Sizee.height / 1 - 330,
                              // child: Transform.rotate(
                              //   angle: 131.95,
                              child: ClipOval(
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
                              //  ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            top: 0,
                            child: SizedBox(
                              // color: Colors.red,
                              // height: Sizee.height - 300,
                              // child: Transform.rotate(
                              //   angle: 131.95,
                              child: ClippedPartsWidget(
                                // clipper: WaveClip2(),
                                bottom: Container(
                                  width: width,
                                  // height: Sizee.height - 315,
                                  color: const Color(0xFF000052),
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      const SizedBox(
                                        height: 120,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                          left: 30,
                                          right: 30,
                                          //top: 100,
                                        ),
                                        height: 102,
                                        width: width,
                                        child: Card(
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          // color: CupertinoColors.systemGrey6,
                                          color: Colors.white,
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 5,
                                                  ),
                                                  alignment: Alignment.topLeft,
                                                  child: const Text(
                                                    "Mobile Number",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Flexible(
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 5,
                                                                top: 15),
                                                        alignment:
                                                            Alignment.center,
                                                        width: Sizee.width / 8 +
                                                            15,
                                                        height: 50,
                                                        child: TextFormField(
                                                          readOnly: true,
                                                          //  controller: email,
                                                          // keyboardType: TextInputType.emailAddress,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                UnderlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Colors
                                                                          .black),
                                                            ),
                                                            enabledBorder:
                                                                UnderlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              borderSide:
                                                                  const BorderSide(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            focusedBorder:
                                                                UnderlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              borderSide:
                                                                  const BorderSide(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            errorBorder:
                                                                UnderlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              borderSide:
                                                                  const BorderSide(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            // prefixText: "+91",
                                                            prefixStyle:
                                                                const TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 17,
                                                            ),
                                                            labelText: '+91',
                                                            labelStyle:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 17,
                                                            ),
                                                          ),
                                                          textAlign:
                                                              TextAlign.left,
                                                          // validator: (text) {
                                                          //   if (text == null || text.isEmpty) {
                                                          //     return 'Please enter Full Name ';
                                                          //   }
                                                          //   return null;
                                                          // },
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 7,
                                                    ),
                                                    // Flexible(
                                                    //   child:
                                                    Container(
                                                      // color: Colors.red,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10),
                                                      height: 50,
                                                      width:
                                                          Sizee.width / 2 + 40,
                                                      child: TextFormField(
                                                        controller:
                                                            MobileNumber,
                                                        maxLength: 10,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 17,
                                                        ),
                                                        decoration: InputDecoration(
                                                            border: UnderlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Colors
                                                                          .black),
                                                            ),
                                                            counterText: '',
                                                            enabledBorder: UnderlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              borderSide:
                                                                  const BorderSide(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            focusedBorder: UnderlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              borderSide:
                                                                  const BorderSide(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            errorBorder: UnderlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              borderSide:
                                                                  const BorderSide(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            hintText: "Enter your number"
                                                            // validator: (text) {
                                                            //   if (text == null || text == "") {
                                                            //     return 'Please enter Mobile Number ';
                                                            //   } else if (text.length != 10) {
                                                            //     setState(() {
                                                            //       isvalidMobile = false as String;
                                                            //       strMobilevalidator = '';
                                                            //     });
                                                            //     return "Mobile Number must be of 10 digit";
                                                            //   } else {
                                                            //     setState(() {
                                                            //       isvalidMobile = true as String;
                                                            //       strMobilevalidator = '';
                                                            //     });
                                                            //     return null;
                                                            //   }
                                                            // },
                                                            ),
                                                      ),
                                                    ),
                                                    // ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: Sizee.width / 1 - 130,
                                        height: 55,
                                        child: RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          color: Colors.blue,
                                          onPressed: () {
                                            print(MobileNumber.text);
                                            if (MobileNumber.text
                                                .trim()
                                                .isEmpty) {
                                              _showvalidationdialogbox(
                                                  msg:
                                                      'Please enter mobile number');
                                            } else if (MobileNumber.text
                                                    .trim()
                                                    .length <
                                                10) {
                                              _showvalidationdialogbox(
                                                  msg:
                                                      'Please enter valid mobile number');
                                            } else {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                // Navigator.of(context).push(
                                                //   MaterialPageRoute(
                                                //     builder: (context) =>
                                                //         const BottomNavigationScreen(
                                                //             0),
                                                //   ),
                                                // );
                                                Login_ApiCall();
                                              }
                                            }
                                          },
                                          child: const Text(
                                            "Continue",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      // const SizedBox(
                                      //   height: 20,
                                      // ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "New user?",
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 15,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Regiatration(),
                                                ),
                                              );
                                            },
                                            child: const Text(
                                              "Signup",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          text: "By continue, I accept the ",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: "Terms and Conditions",
                                              style: const TextStyle(
                                                color: Colors.blue,
                                                fontSize: 15,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          AboutUsScreen(
                                                        strURL:
                                                            'terms_and_conditions',
                                                      ),
                                                    ),
                                                  );
                                                },
                                            ),
                                            const TextSpan(
                                              text: ", ",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "Privacy Policy ",
                                              style: const TextStyle(
                                                color: Colors.blue,
                                                fontSize: 15,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          AboutUsScreen(
                                                        strURL:
                                                            'privacy_policy',
                                                      ),
                                                    ),
                                                  );
                                                },
                                            ),
                                            const TextSpan(
                                              text: "& ",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  "Cancellation & Refund Policy.",
                                              style: const TextStyle(
                                                color: Colors.blue,
                                                fontSize: 15,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          AboutUsScreen(
                                                        strURL: 'refund_policy',
                                                      ),
                                                    ),
                                                  );
                                                },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                splitFunction: (Size size, double x) {
                                  // normalizing x to make it exactly one wave
                                  final normalizedX = x / size.width * 2 * pi;
                                  final waveHeight = size.height / 35;
                                  final y = size.height / 7 -
                                      sin(normalizedX) * waveHeight;

                                  return y;
                                },
                              ),
                              // ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Login_ApiCall() async {
    setState(() {
      isReload = true;
    });
    try {
      final body = {
        "mobile": "+91 ${MobileNumber.text.toString()}",
        "user_type": "2",
      };

      var response = await http.post(Uri.parse(Login_Api), body: body);

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        print("decode $decode");
        if (decode["success"] == true) {
          print(decode);
          setState(() {});
          SendOTP_ApiCall();
        } else {
          print(json.decode(response.body)['errors']);
          String errorMsg = json.decode(response.body)["message"].toString();
          print(errorMsg);
          if (json.decode(response.body)["data"] != null) {
            print(errorMsg);
            var errorList = json.decode(response.body)["data"];

            for (int i = 0; i < errorList.length; i++) {
              Map errorMap = errorList[i];
              for (String k in errorMap.keys) {
                print(errorMap[k]);
                errorMsg = errorMap[k][0] ??
                    json.decode(response.body)["message"].toString();
                break;
              }
            }
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Container(
                // padding: const EdgeInsets.only(left: 15,top: 10,bottom: 10),
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Status',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      errorMsg,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        // fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              duration: const Duration(seconds: 3),
              backgroundColor: const Color(0xFF000052),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 1 - 120,
                  right: 20,
                  left: 20),
            ),
          );
        }
        setState(() {
          isReload = false;
        });
      } else {
        print("Error 2" + response.statusCode.toString());
        print("Error" + response.body.toString());
      }
    } catch (e) {
      setState(() {
        isReload = false;
      });
      print("Exception in Today Attendance=>" + e.toString());
      throw e;
    }
  }

  SendOTP_ApiCall() async {
    setState(() {
      isReload = true;
    });
    try {
      final body = {
        "mobile": "+91 ${MobileNumber.text.toString()}",
        "user_type": "2",
      };
      var response = await http.post(Uri.parse(SendOTP_Api), body: body);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        if (decode["success"] = true) {
          print(decode["data"][0]["otp"].toString());
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return OTPScreen(
                strMobile: "+91 ${MobileNumber.text.toString()}",
                strOTP: decode["data"][0]["otp"].toString(),
              );
            }),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Container(
                // padding: const EdgeInsets.only(left: 15,top: 10,bottom: 10),
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Status',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      decode["message"].toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        // fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              duration: const Duration(seconds: 3),
              backgroundColor: const Color(0xFF000052),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 1 - 120,
                  right: 20,
                  left: 20),
            ),
          );
        }
        setState(() {
          isReload = false;
        });
      } else {
        setState(() {
          isReload = false;
        });
        print(
          "Error" + response.statusCode.toString(),
        );
        print(
          "Error" + response.body.toString(),
        );
      }
    } catch (e) {
      print(
        "Exception in Toady Attendance => " + e.toString(),
      );
      throw e;
    }
  }
}

class WaveClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // Path path = new Path();
    // final lowPoint = size.height - 30;
    // final highPoint = size.height - 60;
    double weight = size.width;
    double height = size.height;
    double offset = 65.0;
    Path path = Path();
    path.moveTo(0, height);
    path.lineTo(0, height);
    path.lineTo(weight, height);
    path.lineTo(weight, height - (height - offset));
    path.quadraticBezierTo(
        4 * weight / 4, 0, weight / 2, height - (height - offset));
    path.quadraticBezierTo(
        weight / 5, 5 * offset, 0, height - (height - offset));
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
