// ignore_for_file: non_constant_identifier_names, camel_case_types, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safaidaar_customer/BottomNavigationScreen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Api/Api_Url.dart';

class DetailFeatured_Store extends StatefulWidget {
  String isFrom;
  String userid;
  String vendorid;

  DetailFeatured_Store(
      {Key? key,
      required this.isFrom,
      required this.userid,
      required this.vendorid})
      : super(key: key);

  @override
  State<DetailFeatured_Store> createState() => _DetailFeatured_StoreState();
}

class _DetailFeatured_StoreState extends State<DetailFeatured_Store> {
  bool isReload = false;
  bool _isShow = true;
  List<dynamic> tabs = [
    "Ironing",
    "Dry Cleaning With Ironing",
    "Laundry With Ironing",
    "Offers",
  ];
  int selectedtabIndex = 0;

  List<dynamic> buttonslist = ["Men's", "Shoes", "Household"];

  int _selectedbuttonIndex = 0;

  final List<Map> _books = [
    {'id': 101, 'days': 'Monday', 'title': '', 'author': ''},
    {'id': 102, 'days': 'Tuesday', 'title': '', 'author': ''},
    {'id': 103, 'days': 'Wednesday', 'title': '', 'author': ''},
    {'id': 104, 'days': 'Thursday', 'title': '', 'author': ''},
    {'id': 105, 'days': 'Friday', 'title': '', 'author': ''},
    {'id': 106, 'days': 'Saturday', 'title': '', 'author': ''},
    {'id': 107, 'days': 'Sunday', 'title': '', 'author': ''},
  ];

  TextEditingController searchcontroller = TextEditingController();
  TextEditingController Addproductcontroller = TextEditingController();

  // List<Map<String, dynamic>> _foundUsers = [];
  // final List<Map<String, dynamic>> _allUsers = [];
  bool _searchcursor = true;

  int cartQTY = 0;
  double cartToTal = 0.0;

  List<dynamic> productList = [
    {
      'clean': "In Dry Cleaning with Ironing",
      'name': "T-shirt",
      "image": "assets/Shirt-1.png",
      'QTY': 0,
      'price': 30
    },
    {
      'clean': "In Dry Cleaning with Ironing",
      'name': "Shirt",
      "image": "assets/Shirt.png",
      'QTY': 0,
      'price': 50
    },
  ];

  List<dynamic> productList2 = [
    {
      'clean': "In Dry Cleaning with Ironing",
      'name': "T-shirt",
      "image": "assets/Shirt-1.png",
      'QTY': 0,
      'price': 30
    },
    // {
    //   'clean': "In Dry Cleaning with Ironing",
    //   'name': "Shirt",
    //   "image": "assets/Shirt.png",
    //   'QTY': 0,
    //   'price': 50
    // },
  ];

  List<dynamic> productList3 = [
    {
      'clean': "In Dry Cleaning with Ironing",
      'name': "T-shirt",
      "image": "assets/Shirt-1.png",
      'QTY': 0,
      'price': 30
    },
    {
      'clean': "In Dry Cleaning with Ironing",
      'name': "Shirt",
      "image": "assets/Shirt.png",
      'QTY': 0,
      'price': 150
    },
  ];

  List<dynamic> crazyofferlist = [
    {
      "clean": "Dry Cleaning With Ironing (Men's)",
      "use code": "iLJ1bt",
      'name': "test",
      "image": "assets/customer_application_logo.svg",
      "offer%": 10,
      'QTY': 0,
      'price': 100
    },
  ];

  List<dynamic> cleaningwaysoffer = [];

  int itemCount = 0;

  @override
  void initState() {
    // _foundUsers = _allUsers;
    buttonslist.clear();
    if (selectedtabIndex == 0) {
      buttonslist.add("Men's");
      buttonslist.add("Shoes");
      buttonslist.add("Household");
    } else if (selectedtabIndex == 1) {
      buttonslist.add("Shoes");
      buttonslist.add("Household");
    } else if (selectedtabIndex == 2) {
      buttonslist.add("Shoes");
      buttonslist.add("Men's");
    } else if (selectedtabIndex == 3) {
      buttonslist.clear();
    }
    super.initState();
    if (widget.isFrom == "offer") {
      selectedtabIndex = tabs.length - 1;
      _selectedbuttonIndex = 0;
      buttonslist.clear();
    }
    GetOffer_ApiCall();
    GetVendorOffer_ApiCall();
  }

  Future<void> _showproductdialogbox(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => Container(
        height: 100,
        // width: MediaQuery.of(context).size.width - 40,
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          title: Column(
            children: [
              const Text(
                "Shirt",
                style: TextStyle(
                  fontSize: 18,
                  // fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
                child: Image.asset("assets/Shirt-1.png"),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 2,
                child: RaisedButton(
                  elevation: 0,
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Close",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
          title: Transform(
            transform: Matrix4.translationValues(-10, 0.0, 0.0),
            child: const Text(
              "Geets Laundry House",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _isShow = !_isShow;
                });
              },
              icon: const Icon(
                Icons.info,
                color: Color(0xFF000052),
              ),
            ),
          ],
        ),
        body: (isReload == false)
            ? SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  // height: Sizee.height * 1,
                  child: Column(
                    children: [
                      // if(isDesktop(context))
                      SizedBox(
                        height: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Icon(
                                  Icons.location_on,
                                  color: Color(0xFF000052),
                                  size: 17,
                                ),
                                Text(
                                  "Delivery Range : 30KM",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF000052),
                                      borderRadius: BorderRadius.circular(4)),
                                  height: 25,
                                  width: 30,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        "3",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      _isShow
                          ? Column(
                              children: [
                                const Divider(
                                  color: CupertinoColors.systemGrey6,
                                  thickness: 2,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  // color: Colors.red,
                                  height: 25,
                                  child: ListView.builder(
                                      // controller: _scrollController,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: tabs.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        // _scrollToBottom();
                                        return Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedtabIndex = index;
                                                  _selectedbuttonIndex = 0;
                                                  buttonslist.clear();
                                                  if (selectedtabIndex == 0) {
                                                    buttonslist.add("Men's");
                                                    buttonslist.add("Shoes");
                                                    buttonslist
                                                        .add("Household");
                                                  } else if (selectedtabIndex ==
                                                      1) {
                                                    buttonslist.add("Shoes");
                                                    buttonslist
                                                        .add("Household");
                                                  } else if (selectedtabIndex ==
                                                      2) {
                                                    buttonslist.add("Shoes");
                                                    buttonslist.add("Men's");
                                                  } else if (selectedtabIndex ==
                                                      3) {
                                                    buttonslist.clear();
                                                  }
                                                });
                                              },
                                              child: (selectedtabIndex == index)
                                                  ? InkWell(
                                                      child: Container(
                                                        // height: 12,
                                                        // color:Colors.blue,
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10,
                                                                right: 10),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              tabs[index],
                                                              style: const TextStyle(
                                                                  color: Color(
                                                                      0xFF000052),
                                                                  fontSize: 13),
                                                            ),
                                                            Container(
                                                              height: 3,
                                                              width:
                                                                  Sizee.width /
                                                                          5 -
                                                                      23,
                                                              color: const Color(
                                                                  0xFF000052),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : InkWell(
                                                      child: Container(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10,
                                                                right: 10),
                                                        child: Text(
                                                          tabs[index],
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 13),
                                                        ),
                                                      ),
                                                    ),
                                            ),
                                          ],
                                        );
                                      }),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                buttonslist.length > 0
                                    ? Container(
                                        // alignment: Alignment.topLeft,
                                        // color: Colors.red,
                                        height: 50,
                                        // width: Sizee.width / 2 - 35,
                                        child: ListView.builder(
                                            // controller: _scrollController,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            itemCount: buttonslist.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              // _scrollToBottom();
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5, left: 5),
                                                    height: 45,
                                                    //width: 80,
                                                    child: RaisedButton(
                                                      elevation: 0,
                                                      color:
                                                          (_selectedbuttonIndex ==
                                                                  index)
                                                              ? Colors.lightBlue
                                                              : Colors.grey,
                                                      shape: RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color: (_selectedbuttonIndex ==
                                                                      index)
                                                                  ? const Color(
                                                                      0xFF000052)
                                                                  : Colors
                                                                      .black45,
                                                              width: 2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      onPressed: () {
                                                        setState(() {
                                                          _selectedbuttonIndex =
                                                              index;
                                                          //productList.clear();
                                                          if (index == 1) {
                                                            productList =
                                                                productList2;
                                                          } else {
                                                            productList =
                                                                productList3;
                                                          }
                                                          print(productList);
                                                        });
                                                      },
                                                      child: Text(
                                                        buttonslist[index],
                                                        style: TextStyle(
                                                          color:
                                                              (_selectedbuttonIndex ==
                                                                      index)
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                          fontSize: 13.6,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              );
                                            }),
                                      )
                                    : SizedBox(),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  // color: Colors.red,
                                  height: 50,
                                  child: TextFormField(
                                    onTap: () {
                                      setState(() {
                                        _searchcursor = !_searchcursor;
                                      });
                                    },
                                    controller: searchcontroller,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color(0xFF000052)),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color(0xFF000052)),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color(0xFF000052)),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      suffixIcon: _searchcursor
                                          ? const Icon(
                                              Icons.search,
                                              color: Color(0xFF000052),
                                            )
                                          : const Icon(
                                              Icons.search,
                                              color: Colors.grey,
                                            ),
                                      hintText: "Search within the menu....",
                                      hintStyle: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                selectedtabIndex == tabs.length - 1
                                    ? Flexible(
                                        flex: 0,
                                        child: Container(
                                          height: crazyofferlist.length * 230,
                                          child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: crazyofferlist.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                // color: Colors.red,
                                                height: 230,
                                                // width: Sizee.width,
                                                child: Card(
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      side: const BorderSide(
                                                          color: CupertinoColors
                                                              .systemGrey3)),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              // color: Colors.blue,
                                                              width:
                                                                  Sizee.width /
                                                                          2 -
                                                                      20,
                                                              height: 20,
                                                              child: Text(
                                                                crazyofferlist[
                                                                            index]
                                                                        [
                                                                        "offer_name"]
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              // color: Colors.blue,
                                                              width:
                                                                  Sizee.width /
                                                                          2 -
                                                                      20,
                                                              height: 20,
                                                              child: Text(
                                                                "Flat ${crazyofferlist[index]["amount_percentage"].toString()} % Off",
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 16,
                                                                  color: Color(
                                                                      0xFF000052),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              // color: Colors.blue,
                                                              width:
                                                                  Sizee.width /
                                                                          2 -
                                                                      20,
                                                              height: 20,
                                                              child: Text(
                                                                crazyofferlist[
                                                                            index]
                                                                        [
                                                                        "description"]
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                             // color: Colors.red,
                                                              width:
                                                                  Sizee.width /
                                                                      2 + 27,
                                                              height:
                                                                  cleaningwaysoffer
                                                                          .length *
                                                                      25,
                                                              child: ListView
                                                                  .builder(
                                                                      itemCount:
                                                                          cleaningwaysoffer
                                                                              .length,
                                                                      physics:
                                                                          const NeverScrollableScrollPhysics(),
                                                                      itemBuilder:
                                                                          (BuildContext cntx,
                                                                              int index) {
                                                                        return Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Container(
                                                                              height: 7,
                                                                              width: 7,
                                                                              decoration: const BoxDecoration(
                                                                                shape: BoxShape.circle,
                                                                                color: Colors.black,
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              padding: const EdgeInsets.only(left: 8, bottom: 6),
                                                                              // color: Colors.blue,
                                                                              width: Sizee.width / 2 + 20,
                                                                              height: 25,
                                                                              child: Text(
                                                                                "${cleaningwaysoffer[index]["offer_applicable_services"][0]["parent_category_name"].toString()} (${cleaningwaysoffer[index]["offer_applicable_services"][0]["name"].toString()})",
                                                                                style: const TextStyle(
                                                                                  fontSize: 14,
                                                                                  color: Colors.black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      }),
                                                            ),
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              height: 33,
                                                              // color: Colors.red,
                                                              child: TextButton(
                                                                onPressed:
                                                                    () {},
                                                                child:
                                                                    const Text(
                                                                  "See more",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xFF000052),
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                                ),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                _showfluttertoast();
                                                              },
                                                              child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                height: 40,
                                                                width:
                                                                    Sizee.width /
                                                                            2 -
                                                                        20,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  border: Border
                                                                      .all(
                                                                    color: const Color(
                                                                        0xFF000052),
                                                                  ),
                                                                ),
                                                                child: Text(
                                                                  "USE CODE: ${crazyofferlist[index]["offer_code"].toString()}",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                            .indigo[
                                                                        900],
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                          // color: Colors.blue,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            15,
                                                                        top:
                                                                            15),
                                                                height: 50,
                                                                width:
                                                                    Sizee.width /
                                                                            3 -
                                                                        20,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .rectangle,
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .indigo)),
                                                                child: Image
                                                                    .network(
                                                                  crazyofferlist[
                                                                              index]
                                                                          [
                                                                          "offer_image"]
                                                                      .toString(),
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                height: 45,
                                                                width:
                                                                    Sizee.width /
                                                                            3 -
                                                                        20,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color: Colors
                                                                            .indigo[
                                                                        900]),
                                                                child:
                                                                    TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    _showfluttertoast();
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    "Apply",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                    ),
                                                                  ),
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
                                            },
                                          ),
                                        ),
                                      )
                                    : Container(
                                        // color: Colors.red,
                                        height: productList.length * 180,
                                        // height: Sizee.height / 2,
                                        child: ListView.builder(
                                            itemCount: productList.length,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                // color: Colors.red,
                                                height: 165,
                                                // width: Sizee.width,
                                                child: Card(
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      side: const BorderSide(
                                                          color: CupertinoColors
                                                              .systemGrey3)),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      top: 15,
                                                    ),
                                                    child: Column(
                                                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15,
                                                                  right: 35),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    // color: Colors.blue,
                                                                    width: Sizee.width /
                                                                            2 -
                                                                        20,
                                                                    height: 20,
                                                                    child: Text(
                                                                      productList[
                                                                              index]
                                                                          [
                                                                          "clean"],
                                                                      //productList[index]["clean"],
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    productList[
                                                                            index]
                                                                        [
                                                                        "name"],
                                                                    maxLines: 2,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          17,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  _showproductdialogbox(
                                                                      context);
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 80,
                                                                  width: 80,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .black,
                                                                        width:
                                                                            1),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(3),
                                                                  ),
                                                                  child: Image.asset(
                                                                      productList[
                                                                              index]
                                                                          [
                                                                          "image"]),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15,
                                                                  right: 10),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                // padding: EdgeInsets.only(left: 13),
                                                                // color: Colors.blue,
                                                                width:
                                                                    Sizee.width /
                                                                            2 -
                                                                        22,
                                                                height: 20,
                                                                child: Text(
                                                                  "Rs ${productList[index]["price"]}",
                                                                  maxLines: 2,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ),
                                                              productList[index]
                                                                          [
                                                                          "QTY"] >
                                                                      0
                                                                  ? Container(
                                                                      // height: 50,
                                                                      // width: 80,
                                                                      decoration: BoxDecoration(
                                                                          color: const Color(
                                                                              0xFF000052),
                                                                          borderRadius: BorderRadius.circular(
                                                                              7),
                                                                          border:
                                                                              Border.all(color: Colors.grey)),
                                                                      child:
                                                                          Row(
                                                                        children: <
                                                                            Widget>[
                                                                          Container(
                                                                            height:
                                                                                45,
                                                                            width:
                                                                                Sizee.width / 8 - 5,
                                                                            child:
                                                                                RaisedButton(
                                                                              elevation: 0,
                                                                              shape: const RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(7), bottomLeft: Radius.circular(7)),
                                                                              ),
                                                                              color: const Color(
                                                                                0xFF000052,
                                                                              ),
                                                                              onPressed: () {
                                                                                setState(() {
                                                                                  productList[index]["QTY"] = int.parse(productList[index]["QTY"].toString()) - 1;
                                                                                  print(productList[index]["QTY"]);
                                                                                  UpdateCartPrice();
                                                                                });
                                                                              },
                                                                              child: const Text(
                                                                                "-",
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 20,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            color:
                                                                                Colors.white,
                                                                            height:
                                                                                45,
                                                                            width:
                                                                                Sizee.width / 8 - 9.69,
                                                                            child:
                                                                                Text(
                                                                              productList[index]["QTY"].toString(),
                                                                              textAlign: TextAlign.center,
                                                                              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: Colors.black),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            height:
                                                                                45,
                                                                            width:
                                                                                Sizee.width / 8 - 5,
                                                                            child:
                                                                                RaisedButton(
                                                                              shape: const RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.only(topRight: Radius.circular(7), bottomRight: Radius.circular(7)),
                                                                              ),
                                                                              color: const Color(0xFF000052),
                                                                              onPressed: () {
                                                                                setState(() {
                                                                                  setState(() {
                                                                                    productList[index]["QTY"] = int.parse(productList[index]["QTY"].toString()) + 1;
                                                                                    print(productList[index]["QTY"]);
                                                                                    UpdateCartPrice();
                                                                                  });
                                                                                });
                                                                              },
                                                                              child: const Text(
                                                                                "+",
                                                                                textAlign: TextAlign.left,
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 20,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  : Container(
                                                                      height:
                                                                          45,
                                                                      width:
                                                                          Sizee.width /
                                                                              3,
                                                                      decoration: BoxDecoration(
                                                                          color: const Color(
                                                                              0xFF000052),
                                                                          borderRadius: BorderRadius.circular(
                                                                              6),
                                                                          border:
                                                                              Border.all(color: Colors.white70)),
                                                                      child:
                                                                          RaisedButton(
                                                                        elevation:
                                                                            0,
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5)),
                                                                        color: const Color(
                                                                            0xFF000052),
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            productList[index]["QTY"] =
                                                                                1;
                                                                            UpdateCartPrice();
                                                                          });
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          "ADD+",
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 17),
                                                                        ),
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
                                      ),
                              ],
                            )
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    // padding:
                                    //     const EdgeInsets.only(left: 10, right: 10),
                                    // color: Colors.red,
                                    height: Sizee.height / 3.5,
                                    width: Sizee.width,
                                    child: ClipRRect(
                                      child: Image.asset(
                                        "assets/exp1.jpg",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 60,
                                  ),
                                  Container(
                                    // padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: const Text(
                                            "Operational Hours",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          height: 3,
                                          width: Sizee.width / 5 - 15,
                                          color: const Color(0xFF000052),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // padding: const EdgeInsets.only(
                                    //   left: 15,
                                    // ),
                                    // color: Colors.red,
                                    height: Sizee.height / 3,
                                    child: ListView(
                                      children: [_createDataTable()],
                                    ),
                                  ),
                                  const Divider(
                                    color: CupertinoColors.systemGrey6,
                                    thickness: 2,
                                  ),
                                ],
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
        bottomSheet: (cartQTY == 0)
            ? const SizedBox()
            : Container(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, bottom: 5, top: 15),
                // color: Colors.white,
                height: 100,
                width: Sizee.width,
                child: Card(
                  elevation: 0,
                  // color: Colors.white,
                  child: Container(
                    height: 50,
                    padding:
                        const EdgeInsets.only(left: 15, right: 0, bottom: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF000052),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 5, top: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  "$cartQTY ITEMS",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 20,
                                    child: Text(
                                      "Rs $cartToTal ",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.5,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 18,
                                    child: const Text(
                                      "+ Other charges",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        // fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const BottomNavigationScreen(2),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const BottomNavigationScreen(2),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Next",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const BottomNavigationScreen(2),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.arrow_right_outlined,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            ],
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

  GetVendorOffer_ApiCall() async {
    setState(() {
      isReload = true;
    });
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token") ?? "";
      var user_id = prefs.getString("id") ?? "";

      print(GetVendorserviceoffer_Api +
          "/${widget.vendorid}/?search=&user_id=${user_id}");
      var response = await http.get(
        Uri.parse(GetVendorserviceoffer_Api +
            "/${widget.vendorid}/?search=&user_id=${user_id}"),
      );

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        print(decode);
        if (decode["success"] = true) {
          cleaningwaysoffer.clear();
          cleaningwaysoffer = decode["data"];
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
          GetVendorOffer_ApiCall();
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

  UpdateCartPrice() {
    setState(() {
      cartQTY = 0;
      cartToTal = 0.0;
      for (var i = 0; i < productList.length; i++) {
        print("for${productList[i]["QTY"]}");
        cartQTY = cartQTY + int.parse(productList[i]["QTY"].toString());
        cartToTal =
            cartToTal + (productList[i]["QTY"] * productList[i]["price"]);
      }
      print("$cartQTY, $cartToTal");
    });
  }

  Future<void> _showfluttertoast() async {
    showToast('Status\n\nOffer Applied Successfully ',
        context: context,
        textAlign: TextAlign.left,
        textStyle: const TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.white),
        fullWidth: true,
        animation: StyledToastAnimation.slideFromTop,
        reverseAnimation: StyledToastAnimation.slideToTop,
        position: StyledToastPosition.top,
        startOffset: const Offset(0, -3.0),
        backgroundColor: const Color(0xFF000052),
        borderRadius: BorderRadius.circular(15),
        reverseEndOffset: const Offset(0, -3.0),
        duration: const Duration(seconds: 4),
        //Animation duration   animDuration * 2 <= duration
        animDuration: const Duration(seconds: 1),
        curve: Curves.easeIn,
        reverseCurve: Curves.easeInOut);
  }

  double size = 30;

  DataTable _createDataTable() {
    return DataTable(
      headingRowHeight: size,
      columns: _createColumns(),
      // dataTextStyle: TextStyle(fontSize: 13),
      rows: _createRows(),
      dataRowHeight: size,
      showBottomBorder: true,
      border: TableBorder.all(color: Colors.black, width: 1),
      headingTextStyle:
          const TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
      headingRowColor: MaterialStateProperty.resolveWith(
        (states) => const Color(0xFF000052),
      ),
    );
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(
        label: Text(
          'Days',
          style: TextStyle(fontSize: 13.8),
        ),
      ),
      const DataColumn(
        label: Text(
          'Open time',
          style: TextStyle(fontSize: 13.8),
        ),
      ),
      const DataColumn(
        label: Text(
          'Close time',
          style: TextStyle(fontSize: 13.8),
        ),
      ),
    ];
  }

  List<DataRow> _createRows() {
    return _books
        .map(
          (book) => DataRow(
            cells: [
              DataCell(
                Text(
                  '${book['days']}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 13.5),
                ),
                // Text(
                //   book['days'],
                // ),
              ),
              DataCell(
                Text(
                  book['title'],
                ),
              ),
              DataCell(
                Text(
                  book['author'],
                ),
              ),
            ],
          ),
        )
        .toList();
  }
}
