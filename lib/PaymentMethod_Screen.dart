import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safaidaar_customer/Api/Api_Url.dart';
import 'package:safaidaar_customer/Order_Confirmation_Screen.dart';
import 'package:safaidaar_customer/Razorpay_Payment_Screen.dart';

import 'package:http/http.dart' as http;

class Paymentmethod extends StatefulWidget {
  const Paymentmethod({Key? key}) : super(key: key);

  @override
  State<Paymentmethod> createState() => _PaymentmethodState();
}

class _PaymentmethodState extends State<Paymentmethod> {
  bool isReload = false;

  List<dynamic> paymethodway = [
    // {
    //   'image': 'assets/razorpayicon.png',
    //   'payment': 'Razorpay Payment Gateway',
    // },
  ];

  @override
  void initState() {
    Paymentgateway_ApiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            title: const Text(
              "Payment Method",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          body: (isReload == false)
              ? SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Container(
                    height: height,
                    width: width,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        Container(
                          height: 38,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 10),
                          color: CupertinoColors.systemGrey5,
                          width: width,
                          child: RichText(
                            textAlign: TextAlign.left,
                            text: const TextSpan(
                              text: "Pay To Dispatch",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: " (No Cash Payments Allowed)",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Orderconfirmation(),
                              ),
                            );
                          },
                          child: Container(
                            height: height * 0.15,
                            width: width,
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, top: 15, bottom: 15),
                            child: Card(
                              elevation: 2.5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: CupertinoColors.systemGrey5,
                                    ),
                                    height: 45,
                                    width: 45,
                                    child: Image.asset(
                                      "assets/pod.png",
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                  Container(
                                    width: width * 0.65,
                                    //color: Colors.red,
                                    child: const Text(
                                      "Pay before the order dispatch for delivery (Pay to Dispatch)",
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 38,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 10),
                          color: CupertinoColors.systemGrey5,
                          width: width,
                          child: const Text(
                            "Others",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Container(
                          width: width,
                          height: paymethodway.length * 125,
                          child: ListView.builder(
                              itemCount: paymethodway.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const RazorpayPayment(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: height * 0.15,
                                    width: width,
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5, top: 15, bottom: 15),
                                    child: Card(
                                      elevation: 2.5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ClipRRect(
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color:
                                                    CupertinoColors.systemGrey5,
                                              ),
                                              height: 45,
                                              width: 45,
                                              child: Image.network(
                                                paymethodway[index]
                                                        ['payment_logo']
                                                    .toString(),
                                                height: 40,
                                                alignment: Alignment.center,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: width * 0.65,
                                            //color: Colors.red,
                                            child: Text(
                                              paymethodway[index]
                                                      ['payment_name']
                                                  .toString(),
                                              maxLines: 2,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF000052),
                    ),
                  ),
                )),
    );
  }

  Paymentgateway_ApiCall() async {
    setState(() {
      isReload = true;
    });
    try {
      // final body = {
      //   "all": true,
      // };
     print(Paymentgateway_Api);
      var response = await http.get(
        Uri.parse(Paymentgateway_Api),
      );
      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        print("decode : $decode");
        if (decode["success"] == true) {
          setState(() {
            paymethodway.clear();
            paymethodway = decode["data"];
          });
        } else {}
        setState(() {
          isReload = false;
        });
      } else {
        setState(() {
          isReload = false;
        });
        print("Error" + response.statusCode.toString());
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
}
