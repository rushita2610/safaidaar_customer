// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:safaidaar_customer/Home_Screen.dart';
import 'package:safaidaar_customer/Offers_Screen.dart';
import 'package:safaidaar_customer/Services_Screen.dart';
import 'package:safaidaar_customer/Your_Orders_Screen.dart';

import 'Cart Details_Screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  final int _selectedIndex;

  const BottomNavigationScreen(
    this._selectedIndex,
    //{super.key}
  );

  @override
  _BottomNavigationScreenState createState() =>
      _BottomNavigationScreenState(_selectedIndex);
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 1;
  AnimationController? _controller;
  List<dynamic> tabs = [
    "Ironing",
    "Dry Cleaning With Ironing",
    "Laundry With Ironing",
    "Offers",
  ];
  // ignore: non_constant_identifier_names
  DateTime pre_backpress = DateTime.now();
String Address = "";
  final List<Widget> _widgetOptions = <Widget>[
    homeScreen(),
    const Servicescreen(),
    const Cartdetails(),
    const Your_orders(),
     OfferScreen(),
  ];

  List<dynamic> Bottomname = [
    "Home",
    "Service",
    "Cart",
    "Order",
    "Offers",
  ];

  List<dynamic> BottomList = [
    {
      "Selected": "assets/Home-Hover.png",
      "unSelected": "assets/Home-Normal.png",
    },
    {
      "Selected": "assets/Services-hover.png",
      "unSelected": "assets/Services-Normal.png",
    },
    {
      "Selected": "assets/Cart-Hover.png",
      "unSelected": "assets/Cart-Normal.png",
    },
    {
      "Selected": "assets/Order-hover.png",
      "unSelected": "assets/Order-normal.png",
    },
    {
      "Selected": "assets/Offer-Hover.png",
      "unSelected": "assets/Offer-Normal.png",
    },
  ];

  _BottomNavigationScreenState(this._selectedIndex);

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   // DateTime timeBackPressed = DateTime.now();

    return WillPopScope(
      onWillPop: () async {
        final timegap = DateTime.now().difference(pre_backpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        pre_backpress = DateTime.now();
        if (cantExit) {
          //show snackbar
          const snack = SnackBar(
            content: Text('Press Back button again to Exit'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
          return false;
        } else {
          exit(0);
          return false;
        }
      },
      child: Scaffold(
          extendBody: true,
          bottomNavigationBar: Container(
            color: const Color(0xFF000052),
            height: 60,
            padding: const EdgeInsets.only(bottom: 0.0, top: 8),
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: 50,
                  child: Container(
                    color: const Color(0xFF000052),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    color: Colors.transparent,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 3,
                        mainAxisSpacing: 2,
                        childAspectRatio: 1 / 0.60,
                        crossAxisCount: 5,
                      ),
                      shrinkWrap: true,
                      itemCount: _widgetOptions.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                // color: Colors.green,
                                // height: 50,
                                alignment: Alignment.bottomCenter,
                                child: (_selectedIndex == index)
                                    ? InkWell(
                                        child: Container(
                                          // color: Colors.red,
                                          child: Image.asset(
                                            BottomList[index]["Selected"]
                                                .toString(),
                                            height: 28,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        // color: Colors.grey,
                                        child: Image.asset(
                                          BottomList[index]["unSelected"]
                                              .toString(),
                                          height: 25,
                                        ),
                                      ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Container(
                                height: 14,
                                alignment: Alignment.bottomCenter,
                                child: (_selectedIndex == index)
                                    ? Container(
                                        child: Text(
                                          Bottomname[index],
                                          style: const TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        child: Text(
                                          Bottomname[index],
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: _widgetOptions.elementAt(_selectedIndex)),
    );
  }
}
