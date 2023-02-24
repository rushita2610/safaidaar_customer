import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:safaidaar_customer/Api/Api_Url.dart';
import 'package:safaidaar_customer/FeaturedStore_Detail_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'FeaturedStore_VendorScreen.dart';

class OfferScreen extends StatefulWidget {
  //int selectedtabIndex = 0;
  List<dynamic> tabs = [
    "Ironing",
    "Dry Cleaning With Ironing",
    "Laundry With Ironing",
    "Offers",
  ];

  OfferScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  bool isReload = false;

  List<dynamic> crazyofferlist = [
    // {
    //   "image": "assets/customer_application_logo.svg",
    //   "name": "Divyanshi",
    //   "use code": "iLJ1bt",
    //   "off%": 10,
    // },
    // {
    //   "image": "assets/customer_application_logo.svg",
    //   "name": "Divyanshi",
    //   "use code": "wz9Ffc",
    //   "off%": 20,
    // },
  ];

  @override
  void initState() {
    // TODO: implement initState
    GetOffer_ApiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final Sizee = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: true,
          title: Transform(
            transform: Matrix4.translationValues(-60, 0.0, 0.0),
            child: const Text(
              "Offers",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ),
        body: (isReload == false)
            ? SingleChildScrollView(
                // physics: const NeverScrollableScrollPhysics(),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  //height: height,
                  child: Column(
                    children: [
                      Flexible(
                        flex: 0,
                        child: Container(
                          height: crazyofferlist.length * 220,
                          child: ListView.builder(
                              itemCount: crazyofferlist.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext cntx, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    crazyofferlist[index]["offer_id"]
                                        .toString();
                                    crazyofferlist[index]["vendor_id"]
                                        .toString();
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailFeatured_Store(
                                          isFrom: 'offer',
                                          userid: crazyofferlist[index]
                                                  ["offer_id"]
                                              .toString(),
                                          vendorid: crazyofferlist[index]
                                                  ["vendor_id"]
                                              .toString(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 220,
                                    width: width,
                                    child: Card(
                                      elevation: 4,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            child: Container(
                                              height: 140,
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                // color: Colors.red,
                                                border: Border(
                                                  bottom: BorderSide(
                                                      width: 1,
                                                      color: CupertinoColors
                                                          .systemGrey4),
                                                ),
                                              ),
                                              padding: const EdgeInsets.only(
                                                  top: 30,
                                                  left: 5,
                                                  right: 5,
                                                  bottom: 30),
                                              child: Image.network(
                                                crazyofferlist[index]
                                                        ["offer_image"]
                                                    .toString(),
                                                fit: BoxFit.fill,
                                                height: 40,
                                                width: 90,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 60,
                                            width: width,
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 15),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      height: 25,
                                                      child: Text(
                                                        crazyofferlist[index]
                                                                ["vendor_name"]
                                                            .toString(),
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Clipboard.setData(
                                                          ClipboardData(
                                                            text: crazyofferlist[
                                                                        index][
                                                                    'offer_code']
                                                                .toString(),
                                                          ),
                                                        );
                                                        showToast(
                                                            '\n\nCopied to Clipboard',
                                                            context: context,
                                                            textAlign:
                                                                TextAlign.left,
                                                            textStyle: const TextStyle(
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .white),
                                                            fullWidth: true,
                                                            animation:
                                                                StyledToastAnimation
                                                                    .slideFromTop,
                                                            reverseAnimation:
                                                                StyledToastAnimation
                                                                    .slideToTop,
                                                            position:
                                                                StyledToastPosition
                                                                    .top,
                                                            startOffset:
                                                                const Offset(
                                                                    0.0, -3.0),
                                                            backgroundColor:
                                                                const Color(
                                                                    0xFF000052),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    15),
                                                            reverseEndOffset:
                                                                const Offset(
                                                                    0.0, -3.0),
                                                            duration:
                                                                const Duration(
                                                                    seconds: 4),
                                                            //Animation duration   animDuration * 2 <= duration
                                                            animDuration:
                                                                const Duration(seconds: 1),
                                                            curve: Curves.easeIn,
                                                            reverseCurve: Curves.easeInOut);
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 25,
                                                        width: width * 0.15,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape: BoxShape
                                                              .rectangle,
                                                          border: Border.all(
                                                            color: const Color(
                                                                0xFF000052),
                                                          ),
                                                        ),
                                                        child: Text(
                                                          crazyofferlist[index]
                                                                  ['offer_code']
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xFF000052),
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      height: 25,
                                                      child: Text(
                                                        "${crazyofferlist[index]["amount_percentage"].toString()}% off on some services",
                                                        style: const TextStyle(
                                                          color: Colors.black54,
                                                          // fontWeight: FontWeight.bold,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                    // const SizedBox(width: 5,),
                                                    Container(
                                                      height: 35,
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: TextButton(
                                                        onPressed: () {
                                                          Clipboard.setData(
                                                            ClipboardData(
                                                              text: crazyofferlist[
                                                                          index]
                                                                      [
                                                                      'offer_code']
                                                                  .toString(),
                                                            ),
                                                          );
                                                          showToast(
                                                              '\n\nCopied to Clipboard',
                                                              context: context,
                                                              textAlign: TextAlign
                                                                  .left,
                                                              textStyle: const TextStyle(
                                                                  fontSize:
                                                                      16.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: Colors
                                                                      .white),
                                                              fullWidth: true,
                                                              animation:
                                                                  StyledToastAnimation
                                                                      .slideFromTop,
                                                              reverseAnimation:
                                                                  StyledToastAnimation
                                                                      .slideToTop,
                                                              position:
                                                                  StyledToastPosition
                                                                      .top,
                                                              startOffset:
                                                                  const Offset(
                                                                      0.0, -3.0),
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xFF000052),
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      15),
                                                              reverseEndOffset:
                                                                  const Offset(
                                                                      0.0, -3.0),
                                                              duration: const Duration(
                                                                  seconds: 4),
                                                              //Animation duration   animDuration * 2 <= duration
                                                              animDuration:
                                                                  const Duration(seconds: 1),
                                                              curve: Curves.easeIn,
                                                              reverseCurve: Curves.easeInOut);
                                                        },
                                                        child: const Text(
                                                          "Copy Code",
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .lightBlueAccent,
                                                            fontSize: 17,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF000052),
                ),
              ),
      ),
    );
  }

  GetOffer_ApiCall() async {
    setState(() {
      isReload = true;
    });
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token") ?? "";
      var user_id = prefs.getString("id") ?? "";

      print(GetOffers_Api +
          "?lattitude=23.03984909999999&longitude=72.5602797&user_id=${user_id}");
      var response = await http.get(
        Uri.parse(GetOffers_Api +
            "?lattitude=23.03984909999999&longitude=72.5602797&user_id=${user_id}"),
      );

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        print(decode);
        if (decode["success"] = true) {
          crazyofferlist.clear();
          crazyofferlist = decode["data"]["data"];
        } else {}
        setState(() {
          isReload = false;
        });
      } else {
        print("Error" + response.statusCode.toString());
        print("Error" + response.body.toString());

        setState(() {
          isReload = false;
        });
      }
    } catch (e) {
      setState(() {
        isReload = false;
      });
      print("Exception in getoffer =>" + e.toString());
      throw e;
    }
  }
}
