// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safaidaar_customer/Api/Api_Url.dart';
import 'package:safaidaar_customer/BottomNavigationScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

class OTPScreen extends StatefulWidget {
  String strMobile;
  String strOTP;

  OTPScreen({
    Key? key,
    required this.strOTP,
    required this.strMobile,
  }) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isReload = false;
  int _otpCodeLength = 4;
  bool _isLoadingButton = false;
  bool _enableButton = false;
  String _otpCode = "";
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final intRegex = RegExp(r'\d+', multiLine: true);
  TextEditingController textEditingController = TextEditingController(text: "");

  //TextEditingController MobileNumber = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _otpCode = widget.strOTP;
      textEditingController.text = _otpCode;
    });
    _getSignatureCode();
    _startListeningSms();
  }

  @override
  void dispose() {
    super.dispose();
    SmsVerification.stopListening();
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      color: CupertinoColors.systemGrey,
      border: Border.all(color: Colors.black45),
      borderRadius: BorderRadius.circular(15),
    );
  }

  /// get signature code
  _getSignatureCode() async {
    String? signature = await SmsVerification.getAppSignature();
    print("signature $signature");
  }

  /// listen sms
  _startListeningSms() {
    SmsVerification.startListeningSms().then((message) {
      setState(() {
        _otpCode = SmsVerification.getCode(message, intRegex);
        textEditingController.text = _otpCode;
        _onOtpCallBack(_otpCode, true);
      });
    });
  }

  _onSubmitOtp() {
    setState(() {
      _isLoadingButton = !_isLoadingButton;
      _verifyOtpCode();
    });
  }

  _onClickRetry() {
    _startListeningSms();
  }

  _onOtpCallBack(String otpCode, bool isAutofill) {
    setState(() {
      this._otpCode = otpCode;
      if (otpCode.length == _otpCodeLength && isAutofill) {
        _enableButton = false;
        _isLoadingButton = true;
        _verifyOtpCode();
      } else if (otpCode.length == _otpCodeLength && !isAutofill) {
        _enableButton = true;
        _isLoadingButton = false;
      } else {
        _enableButton = false;
      }
    });
  }

  _verifyOtpCode() {
    FocusScope.of(context).requestFocus(FocusNode());
    Timer(const Duration(milliseconds: 4000), () {
      setState(() {
        _isLoadingButton = false;
        _enableButton = false;
      });

      _scaffoldKey.currentState?.showSnackBar(
          SnackBar(content: Text("Verification OTP Code $_otpCode Success")));
    });
  }

  @override
  Widget build(BuildContext context) {
    final Sizee = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: (isReload == false)
          ? SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  // color: Colors.red,
                  height: Sizee.height,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 20,
                          top: 20,
                        ),
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "OTP Verification",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
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
                        height: 70,
                        width: Sizee.width - 20,
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
                          // height: Sizee.height / 1 - 50,
                          // color: Colors.red,
                          height: double.infinity,
                          // color: Colors.red,
                          width: double.infinity,
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: Sizee.height / 8.5,
                                top: 30,
                                //Sizee.height - 100,
                                left: 190,
                                // right: 10,
                                child: Container(
                                  // color: Colors.red,
                                  // height: Sizee.height / 1 - 300,
                                  child: Transform.rotate(
                                    angle: 131.95,
                                    child: ClipPath(
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue[200],
                                        ),
                                        width: Sizee.width,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                top: 0,
                                child: SizedBox(
                                  // color: Colors.red,
                                  // child: Transform.rotate(
                                  //   angle: 131.95,
                                  child: ClippedPartsWidget(
                                    // clipper: WaveClip2(),
                                    bottom: Container(
                                      height: Sizee.height - 255,
                                      width: Sizee.width,
                                      //height: Sizee.height - 315,
                                      color: const Color(0xFF000052),
                                      child: Column(
                                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          const SizedBox(
                                            height: 130,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                              left: 30,
                                              bottom: 10,
                                            ),
                                            alignment: Alignment.topLeft,
                                            child: const Text(
                                              "VERIFY DETAILS",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                              left: 30,
                                            ),
                                            alignment: Alignment.topLeft,
                                            child: const Text(
                                              "We have sent a verification code to",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                              left: 30,
                                            ),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              widget.strMobile,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                              left: 30,
                                              right: 30,
                                              //top: 100,
                                            ),
                                            height: 120,
                                            width: Sizee.width,
                                            child: Card(
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              // color: CupertinoColors.systemGrey6,
                                              color: Colors.white,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      child: const Text(
                                                        "Enter OTP",
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                      height: 49,
                                                      alignment:
                                                          Alignment.center,
                                                      // color: Colors.red,
                                                      child: TextFieldPin(
                                                          textController:
                                                              textEditingController,
                                                          autoFocus: true,
                                                          codeLength:
                                                              _otpCodeLength,
                                                          alignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          defaultBoxSize: 48.0,
                                                          margin: 4,
                                                          selectedBoxSize: 48.0,
                                                          textStyle: const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          defaultDecoration:
                                                              _pinPutDecoration.copyWith(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .black45)),
                                                          selectedDecoration:
                                                              _pinPutDecoration,
                                                          onChange: (code) {
                                                            _onOtpCallBack(
                                                                code, false);
                                                          }),
                                                    ),
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
                                            height: 45,
                                            child: RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              color: Colors.blue,
                                              onPressed: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  VerifyOTP_ApiCall();
                                                }
                                              },
                                              child: const Text(
                                                "VERIFY",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 40,
                                          ),
                                          RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              text:
                                                  "Didn't receive the OTP ?                                                           ",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: "Resend OTP",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {
                                                          print("otp");
                                                          SendOTP_ApiCall();
                                                          // Navigator.push(
                                                          //   context,
                                                          //   MaterialPageRoute(
                                                          //       builder: (context) =>
                                                          //           Signup(
                                                          //             imgFile: null,
                                                          //           )),
                                                          // );
                                                        },
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                    splitFunction: (Size size, double x) {
                                      // normalizing x to make it exactly one wave
                                      final normalizedX =
                                          x / size.width * 2 * pi;
                                      final waveHeight = size.height / 30;
                                      final y = size.height / 8 -
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
            )
          : Center(
              child: Container(
                padding: const EdgeInsets.only(left: 30, right: 30),
                height: 80,
                width: Sizee.width,
                child: Card(
                  elevation: 5,
                  child: Row(
                    children: const [
                      SizedBox(
                        width: 10,
                      ),
                      CircularProgressIndicator(color: Color(0xFF000052)),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Please Wait...",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  // VerifyOTP_ApiCall() async {
  //   setState(() {
  //     isReload = true;
  //   });
  //   try {
  //     final body = {
  //       "mobile": widget.strMobile,
  //       "otp": textEditingController.text,
  //       "user_type": "2",
  //     };
  //     print("verify otp body ${body.toString()}");
  //
  //     var response = await http.post(Uri.parse(VerifyOTP_Api), body: body);
  //     if (response.statusCode == 200) {
  //       var decode = jsonDecode(response.body);
  //       if (decode["success"] = true) {
  //         LoginApiCall();
  //         SharedPreferences sharedPreferences =
  //             await SharedPreferences.getInstance();
  //         sharedPreferences.setString(
  //             "token", decode["data"]["token"].toString());
  //         print(
  //           decode["data"]["token"].toString(),
  //         );
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Container(
  //               // padding: const EdgeInsets.only(left: 15,top: 10,bottom: 10),
  //               height: 50,
  //               width: MediaQuery.of(context).size.width,
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   const Text(
  //                     'Status',
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 17,
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                   ),
  //                   Text(
  //                     decode["message"].toString(),
  //                     style: const TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 16,
  //                       // fontWeight: FontWeight.w500,
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //             duration: const Duration(seconds: 3),
  //             backgroundColor: const Color(0xFF000052),
  //             behavior: SnackBarBehavior.floating,
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(15),
  //             ),
  //             margin: EdgeInsets.only(
  //                 bottom: MediaQuery.of(context).size.height / 1 - 120,
  //                 right: 20,
  //                 left: 20),
  //           ),
  //         );
  //         setState(() {
  //           isReload == false;
  //         });
  //       }
  //     } else {
  //       print(
  //         "Error" + response.statusCode.toString(),
  //       );
  //       print(
  //         "Error" + response.body.toString(),
  //       );
  //     }
  //   } catch (e) {
  //     print(
  //       "Exception in Toady Error => " + e.toString(),
  //     );
  //     throw e;
  //   }
  // }

  VerifyOTP_ApiCall() async {
    setState(() {
      isReload = true;
    });
    try {
      final body = {
        "mobile": widget.strMobile,
        "otp": textEditingController.text.toString(),
        "user_type": "2",
      };

      var response = await http.post(Uri.parse(VerifyOTP_Api), body: body);

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        print("decode $decode");
        if (decode["success"] == true) {
          print("decode verify Otp $decode");
          SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
          sharedPreferences.setString(
              "token", decode["data"]["token"].toString());
          setState(() {});
          LoginApiCall();
        } else {
          print(jsonDecode(response.body));
          String errorMsg = decode["message"].toString();
          print(errorMsg);
          if (json.decode(response.body)["data"] != null) {
            print("3");
            var errorList = json.decode(response.body)["data"];
            print("4 $errorList");
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

          setState(() {
            isReload = false;
          });
        }
      } else {
        print("Error${response.statusCode}");
        print("Error${response.body}");
      }
    } catch (e) {
      setState(() {
        isReload = false;
      });
      print("Exception in Today Attendance=>$e");
      throw e;
    }
  }

  LoginApiCall() async {
    setState(() {
      isReload = true;
    });
    try {
      final body = {
        "mobile": widget.strMobile,
        "user_type": "2",
      };
      var response = await http.post(Uri.parse(Login_Api), body: body);
      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        if (decode["success"] == true) {
          print("decode login $decode");
          setState(() {});

          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString('id', decode['data'][0]['id'].toString());
          sharedPreferences.setString(
              "customer_name", decode["data"][0]["customer_name"].toString());
          sharedPreferences.setString("referral_mobile",
              decode["data"][0]["referral_mobile"].toString());
          sharedPreferences.setString(
              "email", decode["data"][0]["email"].toString());
          sharedPreferences.setString(
              "mobile", decode["data"][0]["mobile"].toString());
          sharedPreferences.setString(
              "dob", decode["data"][0]["dob"].toString());
          sharedPreferences.setString(
              "gender", decode["data"][0]["gender"].toString());
          sharedPreferences.setString(
              "customer_image", decode["data"][0]["customer_image"].toString());
          sharedPreferences.setString("preferred_language",
              decode["data"][0]["preferred_language"].toString());
          sharedPreferences.setString("anniversary_date",
              decode["data"][0]["anniversary_date"].toString());
          sharedPreferences.setString("isLogin", "login");
          // sharedPreferences.setString(
          //     "profile_image", decode["data"][0]["profile_image"].toString());
          print("islogin ${sharedPreferences.getString("isLogin") ?? ""}");

          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return const BottomNavigationScreen(0);
            }),
          );

          // setState(() {
          //   isReload = false;
          // });
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

          setState(() {
            isReload = false;
          });
        }
      } else {
        print("Error 2${response.statusCode}");
        print("Error${response.body}");
      }
    } catch (e) {
      setState(() {
        isReload = false;
      });
      print("Exception in verifyotp=>$e");
      throw e;
    }
  }

  SendOTP_ApiCall() async {
    setState(() {
      isReload = true;
    });
    try {
      final body = {
        "mobile": widget.strMobile,
        "user_type": "2",
      };

      var response = await http.post(Uri.parse(SendOTP_Api), body: body);

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);

        if (decode["success"] == true) {
          print(decode);
          setState(() {});
          _otpCode = decode["data"][0]["otp"].toString();
          textEditingController.text = _otpCode;
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => OTPScreen(strmobile: '+91 ${MobileNumber.text.toString()}', strotp: decode["data"][0]["otp"].toString(),)));
        } else {
          print("1");
          String errorMsg = json.decode(response.body)["message"].toString();
          print("2");
          if (json.decode(response.body)["data"] != null) {
            print("3");
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
        }

        setState(() {
          isReload = false;
        });
      } else {
        print("Error${response.statusCode}");
        print("Error${response.body}");
      }
    } catch (e) {
      setState(() {
        isReload = false;
      });
      print("Exception in Today Attendance=>$e");
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
