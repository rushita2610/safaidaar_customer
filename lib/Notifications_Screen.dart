import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:safaidaar_customer/Api/Api_Url.dart';
import 'package:safaidaar_customer/Your_Order_Detail_Screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool? isReload;

  List<dynamic> notificationlist = [
    // {
    //   'image': 'assets/user_placeholder.png',
    //   'order id': '22-23/202',
    //   'order status': 'Rejected by Vendor',
    //   'name': 'Diyanshi',
    //   'hrs': 22,
    // },
    // {
    //   'image': 'assets/user_placeholder.png',
    //   'order id': '22-23/203',
    //   'order status': 'Payment successfully done',
    //   'name': 'Rivansh',
    //   'hrs': 22,
    // },
    // {
    //   'image': 'assets/user_placeholder.png',
    //   'order id': '22-23/204',
    //   'order status': 'New Order has been added',
    //   'name': 'Diyanshi',
    //   'hrs': 22,
    // },
    // {
    //   'image': 'assets/user_placeholder.png',
    //   'order id': '22-23/180',
    //   'order status': 'Successfully Delivered',
    //   'name': 'Namita',
    //   'hrs': 23,
    // },
    // {
    //   'image': 'assets/user_placeholder.png',
    //   'order id': '22-23/181',
    //   'order status': 'is on the way for delivery',
    //   'name': 'Sarita',
    //   'hrs': 23,
    // },
    // {
    //   'image': 'assets/user_placeholder.png',
    //   'order id': '22-23/178',
    //   'order status': 'Accepted by Vendor',
    //   'name': 'Namita',
    //   'hrs': 23,
    // },
    // {
    //   'image': 'assets/user_placeholder.png',
    //   'order id': '22-23/204',
    //   'order status': 'Vendor',
    //   'name': 'Richa',
    //   'hrs': 18,
    // },
    // {
    //   'image': 'assets/user_placeholder.png',
    //   'order id': '22-23/202',
    //   'order status': 'Rejected by Vendor',
    //   'name': 'Diyanshi',
    //   'hrs': 18,
    // },
    // {
    //   'image': 'assets/user_placeholder.png',
    //   'order id': '22-23/203',
    //   'order status': 'Payment successfully done',
    //   'name': 'Rivansh',
    //   'hrs': 18,
    // },
    // {
    //   'image': 'assets/user_placeholder.png',
    //   'order id': '22-23/204',
    //   'order status': 'New Order has been added',
    //   'name': 'Diyanshi',
    //   'hrs': 19,
    // },
    // {
    //   'image': 'assets/user_placeholder.png',
    //   'order id': '22-23/202',
    //   'order status': 'Rejected by Vendor',
    //   'name': 'Diyanshi',
    //   'hrs': 15,
    // },
    // {
    //   'image': 'assets/user_placeholder.png',
    //   'order id': '22-23/203',
    //   'order status': 'Payment successfully done',
    //   'name': 'Rivansh',
    //   'hrs': 15,
    // },
    // {
    //   'image': 'assets/user_placeholder.png',
    //   'order id': '22-23/204',
    //   'order status': 'New Order has been added',
    //   'name': 'Diyanshi',
    //   'hrs': 11,
    // },
  ];

  @override
  void initState() {
    super.initState();
    GetNotification_ApiCall();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // final Sizee = MediaQuery.of(context).size;
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
            "Notification",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: (isReload == false)
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  // height: height * 1,
                  width: width,
                  child: Column(
                    children: [
                      // ConstrainedBox(
                      //   constraints: BoxConstraints(
                      //     maxHeight: notificationlist.length * 90,
                      //     minHeight: 90,
                      //   ),
                      notificationlist.length > 0
                          ? Container(
                              height: notificationlist.length * 90,
                              child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  // shrinkWrap: true,
                                  itemCount: notificationlist.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const Yourorderdetail(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        // color: Colors.red,
                                        height: 90,
                                        width: double.infinity,
                                        child: Card(
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15, right: 10),
                                                  height: 70,
                                                  // width: 70,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Image.network(
                                                      notificationlist[index]
                                                          ['image']),
                                                ),
                                              ),
                                              Container(
                                                width: width * 0.55,
                                                // color: Colors.red,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      // "Order-${notificationlist[index]['order id']} ${notificationlist[index]['order status']}- ${notificationlist[index]['name']}",
                                                      "${notificationlist[index]['text']}",
                                                      style: const TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "${notificationlist[index]['time']}",
                                                      style: const TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 15,
                                                        //fontWeight: FontWeight.w700,
                                                      ),
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
                            )
                          : Column(
                              children: [
                                const SizedBox(
                                  height: 100,
                                ),
                                Container(
                                  height: 250,
                                  width: 250,
                                  child: Center(
                                    child: Image.asset(
                                        "assets/no_result_found.png"),
                                  ),
                                ),
                                const Text(
                                  "No Result Found.",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "We did not find anything here.",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                      // ),
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

  GetNotification_ApiCall() async {
    setState(() {
      isReload = true;
    });
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token") ?? "";
      print(token);
      final Header = {
        "Authorization": "Bearer ${token}",
      };
      print(Header);
      print(token);
      var response =
          await http.get(Uri.parse(GetNotificaton_Api), headers: Header);

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        print(decode);
        if (decode["success"] == true) {
          notificationlist.clear();
          notificationlist = decode["data"][0]["data"];
        } else {
          final snackBar = SnackBar(
            content: Text(decode["message"].toString()),
            action: SnackBarAction(
              label: '',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

        setState(() {
          isReload = false;
        });
      } else {
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
