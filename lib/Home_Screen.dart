// ignore_for_file: deprecated_member_use, use_build_context_synchronously
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:safaidaar_customer/AboutUs_Screen.dart';
import 'package:safaidaar_customer/AddressBook_Screen.dart';
import 'package:safaidaar_customer/Api/Api_Url.dart';
import 'package:safaidaar_customer/BottomNavigationScreen.dart';
import 'package:safaidaar_customer/Chat_Screen.dart';
import 'package:safaidaar_customer/Close_Account_Screen.dart';
import 'package:safaidaar_customer/EditProfile_Screen.dart';
import 'package:safaidaar_customer/FeaturedStore_Detail_Screen.dart';
import 'package:safaidaar_customer/FeaturedStore_VendorScreen.dart';
import 'package:safaidaar_customer/Feedback_Screen.dart';
import 'package:safaidaar_customer/Notifications_Screen.dart';
import 'package:safaidaar_customer/Offers_Screen.dart';
import 'package:safaidaar_customer/Recommended_Screen.dart';
import 'package:safaidaar_customer/Services_detail_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Add_Address_Screen.dart';
import 'package:in_app_review/in_app_review.dart';
import 'FeaturedStore_Detail_Screen.dart';
import 'package:flutter_svg/svg.dart';

import 'package:http/http.dart' as http;

import 'Login.dart';

List<dynamic> topserviceslist = [
  // {
  //   'image': 'assets/splash-1.png',
  //   'way': 'Dry Cleaning with Ironing',
  // },
  // {
  //   'image': 'assets/splash-1.png',
  //   'way': 'Ironing',
  // },
  // {
  //   'image': 'assets/splash-1.png',
  //   'way': 'Laundry',
  // },
  // {
  //   'image': 'assets/splash-1.png',
  //   'way': 'Laundry with Ironing',
  // },
  // {
  //   'image': 'assets/splash-1.png',
  //   'way': 'Dry Cleaning',
  // },
];

class homeScreen extends StatefulWidget {
  homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  bool isReload = false;
  String serviceid = "";

  List<dynamic> crazyofferlist = [
    // {
    //   'image': 'assets/customer_application_logo.svg',
    //   'name': 'Diyanshi',
    //   'offer': 10,
    // },
    // {
    //   'image': 'assets/customer_application_logo.svg',
    //   'name': 'Diyanshi',
    //   'offer': 20,
    // },
  ];

  List<dynamic> featuredstorelist = [
    // {
    //   'image': 'assets/exp1.jpg',
    //   'name': 'Exp-1',
    //   'deliveryrange': 66,
    //   'starting': 52.5,
    // },
    // {
    //   'image': 'assets/exp2.jpg',
    //   'name': 'Exp-2',
    //   'deliveryrange': 50,
    //   'starting': 65.5,
    // },
    // {
    //   'image': 'assets/exp1.jpg',
    //   'name': 'Exp-3',
    //   'deliveryrange': 55,
    //   'starting': 89.5,
    // },
    // {
    //   'image': 'assets/exp1.jpg',
    //   'name': 'Exp-4',
    //   'deliveryrange': 72,
    //   'starting': 40.5,
    // },
  ];

  List<dynamic> recommendedlist = [
    // {
    //   'image': 'assets/exp1.jpg',
    //   'name': 'Exp-1',
    //   'deliveryrange': 66,
    //   'starting': 52.5,
    // },
    // {
    //   'image': 'assets/exp2.jpg',
    //   'name': 'Exp-2',
    //   'deliveryrange': 50,
    //   'starting': 65.5,
    // },
    // {
    //   'image': 'assets/exp1.jpg',
    //   'name': 'Exp-3',
    //   'deliveryrange': 55,
    //   'starting': 89.5,
    // },
    // {
    //   'image': 'assets/exp1.jpg',
    //   'name': 'Exp-4',
    //   'deliveryrange': 72,
    //   'starting': 40.5,
    // },
  ];

  List<dynamic> menuassets = [
    "assets/your-orders.png",
    "assets/address-book.png",
    "assets/notification.png",
    "assets/about-us.png",
    "assets/play.png",
    "assets/T&C.png",
    "assets/privacy.png",
    "assets/T&C.png",
    "assets/contact-us.png",
    "assets/rating.png",
    "assets/share.png",
    "assets/chat.png",
  ];

  List<dynamic> menuname = [
    "Your Orders",
    "Address Book",
    "Notifications",
    "About Us",
    "Safaidaar Videos",
    "Terms & Conditions",
    "Privacy Policy",
    "Cancellation & Refund Policy",
    "Feedback",
    "Rating & Review",
    "Share App",
    "Chat Help",
  ];

  List<dynamic> addresslist = [
    // {
    //   "addresstype": "Office",
    // },
    // {
    //   "addresstype": "Home",
    // },
    // {
    //   "addresstype": "Other",
    // },
  ];

  TextEditingController searchcontroller = TextEditingController();
  List<Map<String, dynamic>> _foundUsers = [];
  final List<Map<String, dynamic>> _allUsers = [];

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _foundUsers = _allUsers;
    // HomeBannerApi();
    setDrawerdata();
    TopServices_ApiCall();
    FeatureStore_ApiCall();
    Recommended_ApiCall();
    GetOffer_ApiCall();
    GetAddress_ApiCall();
    profile();
    super.initState();
  }

  profile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  setDrawerdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String isLogin = prefs.getString("isLogin") ?? '';
    print(isLogin);
    if (isLogin == "login") {
      menuname.add("Log Out");
      menuassets.add("assets/log-out.png");
    } else {
      menuname.add("Log In");
      menuassets.add("assets/log-out.png");
    }
  }

  Future<void> _openAppReview() async {
    final InAppReview inAppReview = InAppReview.instance;

    if (await inAppReview.isAvailable()) {
      inAppReview.openStoreListing(
        appStoreId: '6444102906',
        microsoftStoreId: 'com.podigit.safaidaarVendor',
      );
    }
  }

  final Uri _url = Uri.parse(
      'https://www.youtube.com/channel/UC97VZs521SmVItFVp33E6kA?themeRefresh=1');

  String Address = 'search';

  @override
  Widget build(BuildContext context) {
    //final Sizee = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: (isReload == false)
            ? SingleChildScrollView(
                child: Container(
                  height: height * 2,
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 0),
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                        width: width,
                        //color: Colors.green,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                _settingModelBottomSheet(context);
                                GetAddress_ApiCall();
                              },
                              child: Container(
                                width: width * 0.78,
                                height: 50,
                                //color: Colors.red,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 7, 3, 0),
                                      width: 33,
                                      height: 33,
                                      child: Image.asset(
                                        "assets/Location.png",
                                        // height: 15,
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Row(
                                            children: [
                                              const Text(
                                                "Office",
                                                maxLines: 2,
                                                // textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  // fontWeight: FontWeight.bold,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Image.asset(
                                                "assets/arrow-down.png",
                                                height: 15,
                                                width: 13,
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            Address,
                                            maxLines: 2,
                                            // textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              // fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                scaffoldKey.currentState?.openDrawer();
                              },
                              child: ClipRRect(
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 4, 0, 0),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle),
                                  width: 45,
                                  height: 45,
                                  // padding: const EdgeInsets.only(right: 10, top: 10),
                                  child: Image.asset(
                                      "assets/user_placeholder.png"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        child: Card(
                          elevation: 4,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: TextFormField(
                            controller: searchcontroller,
                            cursorColor: Colors.black,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 25,
                              ),
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: "Search by Store/Vendor or Service...",
                              hintStyle: TextStyle(
                                color: Colors.black54,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Flexible(
                        child: Container(
                          //height: height * 0.4,
                          // color: Colors.red,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              (topserviceslist.isNotEmpty)
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: const Text(
                                            "Top Safaidaar Services",
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
                                          // padding: const EdgeInsets.only(top: 10),
                                          alignment: Alignment.topLeft,
                                          height: 3,
                                          // width: Sizee.width / 5 - 15,
                                          width: width * 0.15,
                                          color: const Color(0xFF000052),
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
                              (topserviceslist.length > 0)
                                  ? Container(
                                      padding: const EdgeInsets.only(top: 15),
                                      // height: Sizee.height / 2.8,
                                      // width: Sizee.width,
                                      height: topserviceslist.length * 55,
                                      // color: Colors.green,
                                      child: GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          crossAxisSpacing: 30,
                                          mainAxisSpacing: 15,
                                          childAspectRatio: 0.58,
                                        ),
                                        itemCount: (topserviceslist.length >= 5)
                                            ? 5
                                            : topserviceslist.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return InkWell(
                                            onTap: () {
                                              topserviceslist[index]
                                                      ['service_id']
                                                  .toString();
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Servicedetail(
                                                    serviceid:
                                                        topserviceslist[index]
                                                                ['service_id']
                                                            .toString(),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              //color: Colors.red,
                                              padding: const EdgeInsets.only(
                                                bottom: 5,
                                              ),
                                              // width: Sizee.width / 3,
                                              // height: Sizee.height / 4,
                                              // height: height * 0.25,
                                              // width: width * 0.2,
                                              child: Column(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.network(
                                                        topserviceslist[index]
                                                            ['image'],
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    // color: Colors.red,
                                                    // alignment: Alignment.topCenter,
                                                    height: 31,
                                                    child: Text(
                                                      topserviceslist[index]
                                                          ['name'],
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 11.5,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        //width: Sizee.width,
                        width: width * 1,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          color: const Color(0xFF000052),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const BottomNavigationScreen(1),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "View more",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 5),
                                height: 15,
                                width: 15,
                                child: Image.asset(
                                  "assets/arrow-down.png",
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      recommendedlist.length > 0
                          ? Flexible(
                              flex: 0,
                              child: Container(
                                // padding: const EdgeInsets.only(bottom: 10),
                                // height: Sizee.height,
                                color: Colors.transparent,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    (recommendedlist.isNotEmpty)
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 35,
                                                // color:Colors.blue,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: const Text(
                                                        "Recommended for you",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      child: const Text(
                                                        "See all",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF000052),
                                                            fontSize: 17.5,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ),
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (context) {
                                                              return const Recommendedscreen();
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                // padding: const EdgeInsets.only(top: 10),
                                                alignment: Alignment.topLeft,
                                                height: 3,
                                                //width: Sizee.width / 5 - 15,
                                                width: width * 0.15,
                                                color: const Color(0xFF000052),
                                              ),
                                            ],
                                          )
                                        : const SizedBox(),
                                    (recommendedlist.length > 0)
                                        ? Container(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            height: height * 0.35,
                                            width: recommendedlist.length * 220,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                physics:
                                                    const AlwaysScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: (recommendedlist
                                                            .length >=
                                                        5)
                                                    ? 5
                                                    : recommendedlist.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    // color: Colors.blue,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      bottom: 30,
                                                    ),
                                                    width: 220,
                                                    // height: 100,
                                                    child: Card(
                                                      elevation: 4,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        // side: const BorderSide(
                                                        //     color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      color: Colors.white,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          print(recommendedlist[
                                                                      index]
                                                                  ["user_id"]
                                                              .toString());
                                                          print(recommendedlist[
                                                                      index]
                                                                  ["vendor_id"]
                                                              .toString());
                                                          recommendedlist[index]
                                                                  ["user_id"]
                                                              .toString();
                                                          recommendedlist[index]
                                                                  ["vendor_id"]
                                                              .toString();
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  DetailFeatured_Store(
                                                                isFrom:
                                                                    'service',
                                                                userid: recommendedlist[
                                                                            index]
                                                                        [
                                                                        "user_id"]
                                                                    .toString(),
                                                                vendorid: recommendedlist[
                                                                            index]
                                                                        [
                                                                        "vendor_id"]
                                                                    .toString(),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child: Stack(
                                                          children: [
                                                            Positioned(
                                                              left: 0,
                                                              // bottom: Sizee.height / 6.5,
                                                              bottom:
                                                                  height * 0.13,
                                                              right: 0,
                                                              top: 0,
                                                              child: ClipRRect(
                                                                borderRadius: const BorderRadius
                                                                        .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10)),
                                                                child: Image
                                                                    .network(
                                                                  recommendedlist[
                                                                              index]
                                                                          [
                                                                          'vendor_banner_image']
                                                                      .toString(),
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              left: 5,
                                                              // top: 50,
                                                              right: 0,
                                                              bottom: 0,
                                                              // height: Sizee.height / 8,
                                                              height:
                                                                  height * 0.12,
                                                              child: Text(
                                                                recommendedlist[
                                                                            index]
                                                                        [
                                                                        'vendor_name']
                                                                    .toString(),
                                                                maxLines: 2,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 19,
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              bottom: 45,
                                                              height:
                                                                  height * 0.02,
                                                              left: 10,
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top: 5),
                                                                    height: 20,
                                                                    child: Image
                                                                        .asset(
                                                                      "assets/map-blue.png",
                                                                      color: Colors
                                                                          .black87,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            7),
                                                                    child: Text(
                                                                      "Delivery Range: ${recommendedlist[index]['delivery_range'].toString()} KM",
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Positioned(
                                                              bottom: 15,
                                                              left: 10,
                                                              //  height: height * 1,
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    // padding:
                                                                    //     const EdgeInsets.only(top: 5),
                                                                    //height: 10,
                                                                    child:
                                                                        const Icon(
                                                                      Icons
                                                                          .account_balance_wallet,
                                                                      color: Colors
                                                                          .black87,
                                                                      size: 15,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            7),
                                                                    child: Text(
                                                                      "Starting From Rs ${recommendedlist[index]['min_price'].toString()}",
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Positioned(
                                                              top: 8,
                                                              left: 10,
                                                              // right: 0,
                                                              child: recommendedlist[
                                                                              index]
                                                                          [
                                                                          "rating"] ==
                                                                      "0"
                                                                  ? const SizedBox()
                                                                  : Container(
                                                                      decoration: BoxDecoration(
                                                                          color: const Color(
                                                                              0xFF000052),
                                                                          borderRadius:
                                                                              BorderRadius.circular(10)),
                                                                      height:
                                                                          25,
                                                                      width: 70,
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          const Icon(
                                                                            Icons.star,
                                                                            color:
                                                                                Colors.white,
                                                                            size:
                                                                                20,
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                2,
                                                                          ),
                                                                          Text(
                                                                            recommendedlist[index]["rating"].toString(),
                                                                            style:
                                                                                const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 17,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 20,
                      ),
                      featuredstorelist.length > 0
                          ? Flexible(
                              flex: 0,
                              child: Container(
                                // padding: const EdgeInsets.only(bottom: 10),
                                // height: Sizee.height,
                                color: Colors.transparent,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    (featuredstorelist.isNotEmpty)
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 35,
                                                // color:Colors.blue,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: const Text(
                                                        "Featured Store/Vendor",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      child: const Text(
                                                        "See all",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF000052),
                                                            fontSize: 17.5,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ),
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (context) {
                                                              return const Featuredstore();
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                // padding: const EdgeInsets.only(top: 10),
                                                alignment: Alignment.topLeft,
                                                height: 3,
                                                //width: Sizee.width / 5 - 15,
                                                width: width * 0.15,
                                                color: const Color(0xFF000052),
                                              ),
                                            ],
                                          )
                                        : const SizedBox(),
                                    (featuredstorelist.length > 0)
                                        ? Container(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            // height: Sizee.height / 2.5,
                                            height: height * 0.35,
                                            // featuredstorelist.length * 60,
                                            width:
                                                featuredstorelist.length * 220,
                                            // color: Colors.green,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                physics:
                                                    const AlwaysScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: (featuredstorelist
                                                            .length >=
                                                        5)
                                                    ? 5
                                                    : featuredstorelist.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Container(
                                                    // color: Colors.blue,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      bottom: 30,
                                                    ),
                                                    width: 220,
                                                    // height: 100,
                                                    child: Card(
                                                      elevation: 4,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        // side: const BorderSide(
                                                        //     color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      color: Colors.white,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          print(
                                                              featuredstorelist[
                                                                          index]
                                                                      [
                                                                      "user_id"]
                                                                  .toString());
                                                          print(featuredstorelist[
                                                                      index]
                                                                  ["vendor_id"]
                                                              .toString());
                                                          featuredstorelist[
                                                                      index]
                                                                  ["user_id"]
                                                              .toString();
                                                          featuredstorelist[
                                                                      index]
                                                                  ["vendor_id"]
                                                              .toString();
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  DetailFeatured_Store(
                                                                isFrom:
                                                                    'service',
                                                                userid: featuredstorelist[
                                                                            index]
                                                                        [
                                                                        "user_id"]
                                                                    .toString(),
                                                                vendorid: featuredstorelist[
                                                                            index]
                                                                        [
                                                                        "vendor_id"]
                                                                    .toString(),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child: Stack(
                                                          children: [
                                                            Positioned(
                                                              left: 0,
                                                              // bottom: Sizee.height / 6.5,
                                                              bottom:
                                                                  height * 0.13,
                                                              right: 0,
                                                              top: 0,
                                                              child: ClipRRect(
                                                                borderRadius: const BorderRadius
                                                                        .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10)),
                                                                child: Image
                                                                    .network(
                                                                  featuredstorelist[
                                                                              index]
                                                                          [
                                                                          'vendor_banner_image']
                                                                      .toString(),
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              left: 5,
                                                              // top: 50,
                                                              right: 0,
                                                              bottom: 0,
                                                              // height: Sizee.height / 8,
                                                              height:
                                                                  height * 0.12,
                                                              child: Text(
                                                                featuredstorelist[
                                                                            index]
                                                                        [
                                                                        'vendor_name']
                                                                    .toString(),
                                                                maxLines: 2,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 19,
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              bottom: 45,
                                                              height:
                                                                  height * 0.02,
                                                              left: 10,
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top: 5),
                                                                    height: 20,
                                                                    child: Image
                                                                        .asset(
                                                                      "assets/map-blue.png",
                                                                      color: Colors
                                                                          .black87,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            7),
                                                                    child: Text(
                                                                      "Delivery Range: ${featuredstorelist[index]['delivery_range'].toString()} KM",
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Positioned(
                                                              bottom: 15,
                                                              left: 10,
                                                              //  height: height * 1,
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    // padding:
                                                                    //     const EdgeInsets.only(top: 5),
                                                                    //height: 10,
                                                                    child:
                                                                        const Icon(
                                                                      Icons
                                                                          .account_balance_wallet,
                                                                      color: Colors
                                                                          .black87,
                                                                      size: 15,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            7),
                                                                    child: Text(
                                                                      "Starting From Rs ${featuredstorelist[index]['min_price'].toString()}",
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Positioned(
                                                              top: 8,
                                                              left: 10,
                                                              // right: 0,
                                                              child: featuredstorelist[
                                                                              index]
                                                                          [
                                                                          "rating"] ==
                                                                      "0"
                                                                  ? const SizedBox()
                                                                  : Container(
                                                                      decoration: BoxDecoration(
                                                                          color: const Color(
                                                                              0xFF000052),
                                                                          borderRadius:
                                                                              BorderRadius.circular(10)),
                                                                      height:
                                                                          25,
                                                                      width: 70,
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          const Icon(
                                                                            Icons.star,
                                                                            color:
                                                                                Colors.white,
                                                                            size:
                                                                                18,
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                2,
                                                                          ),
                                                                          Text(
                                                                            featuredstorelist[index]["rating"].toString(),
                                                                            style:
                                                                                const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 20,
                      ),
                      crazyofferlist.length > 0
                          ? Flexible(
                              flex: 0,
                              child: Container(
                                // padding: const EdgeInsets.only(bottom: 10),
                                // height: Sizee.height,
                                color: Colors.transparent,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    (crazyofferlist.isNotEmpty)
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 35,
                                                // color:Colors.blue,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: const Text(
                                                        "Crazy Offers",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      child: const Text(
                                                        "See all",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF000052),
                                                            fontSize: 17.5,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ),
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (context) {
                                                              return const BottomNavigationScreen(
                                                                  4);
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                // padding: const EdgeInsets.only(top: 10),
                                                alignment: Alignment.topLeft,
                                                height: 3,
                                                //width: Sizee.width / 5 - 15,
                                                width: width * 0.12,
                                                color: const Color(0xFF000052),
                                              ),
                                            ],
                                          )
                                        : const SizedBox(),
                                    (crazyofferlist.length > 0)
                                        ? Container(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            // height: Sizee.height / 2.5,
                                            height: height * 0.35,
                                            // featuredstorelist.length * 60,
                                            width: crazyofferlist.length * 220,
                                            // width: Sizee.width + 10,
                                            // color: Colors.green,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                physics:
                                                    const AlwaysScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount:
                                                    (crazyofferlist.length >= 5)
                                                        ? 5
                                                        : crazyofferlist.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Container(
                                                    // color: Colors.blue,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      bottom: 30,
                                                    ),
                                                    width: 220,
                                                    // height: 180,
                                                    child: Card(
                                                      elevation: 4,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        // side: const BorderSide(
                                                        //     color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      color: Colors.white,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          crazyofferlist[index]
                                                                  ["offer_id"]
                                                              .toString();
                                                          crazyofferlist[index]
                                                                  ["vendor_id"]
                                                              .toString();
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  DetailFeatured_Store(
                                                                isFrom: 'offer',
                                                                userid: crazyofferlist[
                                                                            index]
                                                                        [
                                                                        "offer_id"]
                                                                    .toString(),
                                                                vendorid: crazyofferlist[
                                                                            index]
                                                                        [
                                                                        "vendor_id"]
                                                                    .toString(),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child: Stack(
                                                          children: [
                                                            Positioned(
                                                              left: 0,
                                                              bottom: height *
                                                                  0.085,
                                                              right: 0,
                                                              top: 0,
                                                              child: ClipRRect(
                                                                // borderRadius:
                                                                //     BorderRadius
                                                                //         .circular(
                                                                //             10.0),
                                                                child: Image
                                                                    .network(
                                                                  crazyofferlist[
                                                                              index]
                                                                          [
                                                                          'offer_image']
                                                                      .toString(),
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              left: 8,
                                                              // top: 50,
                                                              right: 0,
                                                              bottom: 0,
                                                              // height: Sizee.height / 8,
                                                              height:
                                                                  height * 0.08,
                                                              child: Text(
                                                                crazyofferlist[
                                                                            index]
                                                                        [
                                                                        'vendor_name']
                                                                    .toString(),
                                                                maxLines: 2,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 19,
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              bottom: 15,
                                                              // height: Sizee.height / 8.5,
                                                              left: 0,
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            7),
                                                                child: Text(
                                                                  "${crazyofferlist[index]['amount_percentage'].toString()} % off on some services",
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                ),
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
                                                height: 20,
                                              ),
                                              Container(
                                                height: 250,
                                                width: 250,
                                                child: Center(
                                                  child: Image.asset(
                                                      "assets/no_offer.png"),
                                                ),
                                              ),
                                              const Text(
                                                "No Offers Found.",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF000052),
                ),
              ),
        drawer: Drawer(
          child: ListView(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const EditProfile(),
                    ),
                  );
                },
                child: DrawerHeader(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 70,
                        width: 70,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            "assets/user_placeholder.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 17,
                        child: const Text(
                          "Rushita Ramani",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 5),
                        //width: 60,
                        child: const Text(
                          "+91 1234567890",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 30,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const EditProfile(),
                              ),
                            );
                          },
                          child: const Text(
                            "Edit Profile",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF000052),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: CupertinoColors.systemGrey6,
                //  height: Sizee.height,
                height: height * 1.1,
                // padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    const Divider(
                      thickness: 1,
                      color: Colors.black54,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15, bottom: 20),
                      height: menuassets.length * 55,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: menuassets.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 50,
                            // width: 200,
                            child: InkWell(
                              onTap: () async {
                                if (menuname[index] == "Your Orders") {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return const BottomNavigationScreen(3);
                                  }));
                                } else if (menuname[index] == "Address Book") {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return AddressScreen();
                                  }));
                                } else if (menuname[index] == "Notifications") {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return const NotificationScreen();
                                  }));
                                  // GetNotification_ApiCall();
                                } else if (menuname[index] == "About Us") {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return AboutUsScreen(
                                      strURL: 'about',
                                    );
                                  }));
                                } else if (menuname[index] ==
                                    "Safaidaar Videos") {
                                  _launchUrl();
                                } else if (menuname[index] ==
                                    "Terms & Conditions") {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return AboutUsScreen(
                                      strURL: 'terms_and_conditions',
                                    );
                                  }));
                                } else if (menuname[index] ==
                                    "Privacy Policy") {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return AboutUsScreen(
                                      strURL: 'privacy_policy',
                                    );
                                  }));
                                } else if (menuname[index] ==
                                    "Cancellation & Refund Policy") {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return AboutUsScreen(
                                      strURL: 'refund_policy',
                                    );
                                  }));
                                } else if (menuname[index] == "Feedback") {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const feedbackScreen(),
                                    ),
                                  );
                                } else if (menuname[index] ==
                                    "Rating & Review") {
                                  _openAppReview();
                                } else if (menuname[index] == "Share App") {
                                  FlutterShare.share(
                                      title: 'Safaidaar Customer',
                                      text: 'Safaidaar Customer',
                                      linkUrl:
                                          'https://apps.apple.com/in/app/Safaidaar/id6444102906',
                                      chooserTitle: 'Safaidaar Customer');
                                } else if (menuname[index] == "Chat Help") {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const Chatscreen(),
                                    ),
                                  );
                                } else if (menuname[index] == "Log Out") {
                                  LogoutAPIcall();
                                } else if (menuname[index] == "Log In") {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.clear();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const Login(),
                                    ),
                                  );
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 22,
                                    child: Image.asset(
                                      menuassets[index],
                                      // color: Colors.grey,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 13,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      menuname[index],
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const Center(
                      child: Text(
                        "Data and Privacy",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 0,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Closeaccountscreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Close Your Safaidaar Account",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.black,
                            decorationThickness: 1,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
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
  }

  LogoutAPIcall() async {
    setState(() {
      isReload = true;
    });
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token") ?? "";
      print(token);

      final Header = {
        "Authorization": "Bearer ${token.toString()}",
      };
      print(Header);
      var response = await http.get(Uri.parse(Logout_Api), headers: Header);

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        print(decode);
        print(json.decode(response.body)['errors']);
        String errorMsg = json.decode(response.body)["message"].toString();
        print(errorMsg);
        if (json.decode(response.body)['errors'] != null) {
          Map errorMap = json.decode(response.body)["errors"].first;
          for (String k in errorMap.keys) {
            print(errorMap[k]);
            errorMsg = errorMap[k][0] ??
                json.decode(response.body)["message"].toString();
            break;
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

        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.clear();
        sharedPreferences.setString("isLogin", "logOut");

        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            return const Login();
          },
        ));

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

  TopServices_ApiCall() async {
    setState(() {
      isReload = true;
    });
    try {
      // final body = {
      //   "all": true,
      // };
      //   var response = await http.post(Uri.parse(login), body: body);
      var response = await http.get(
        Uri.parse(TopService_Api),
      );
      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);

        if (decode["success"] == true) {
          setState(() {
            topserviceslist.clear();
            topserviceslist = decode["data"];
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

  FeatureStore_ApiCall() async {
    setState(() {
      isReload = true;
    });
    try {
      // final Header = {
      //   'Content-type': 'application/json',
      //   'Accept': 'application/json',
      // };
      print(FeaturedStore_Api +
          "?lattitude=23.03984909999999&longitude=72.5602797");
      var response = await http.get(Uri.parse(FeaturedStore_Api +
          "?lattitude=23.03984909999999&longitude=72.5602797"));
      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        print(decode);
        if (decode["success"] == true) {
          featuredstorelist.clear();
          featuredstorelist = decode["data"]["data"];
          print(decode);
        } else {
          print("Error");
        }
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
      print("Exception in featurestore =>$e");
      throw e;
    }
  }

  Recommended_ApiCall() async {
    setState(() {
      isReload = true;
    });
    try {
      print(Recommended_Api +
          "?lattitude=23.03984909999999&longitude=72.5602797");
      var response = await http.get(Uri.parse(Recommended_Api +
          "?lattitude=23.03984909999999&longitude=72.5602797"));
      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        print(decode);
        if (decode["success"] == true) {
          recommendedlist.clear();
          recommendedlist = decode["data"]["data"];
          print(decode);
        } else {
          print("Error");
        }
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
      print("Exception in featurestore =>$e");
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

  _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  void _settingModelBottomSheet(context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext bc) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
                // height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.only(left: 0, right: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          child: const Text(
                            "Select a Location",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 0, right: 10),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              CupertinoIcons.clear_circled_solid,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      height: 50,
                      child: Card(
                        elevation: 2,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: TextFormField(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AddaddressScreen(),
                              ),
                            );
                          },
                          keyboardType: TextInputType.none,
                          controller: searchcontroller,
                          showCursor: false,
                          // cursorColor: Colors.black,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 25,
                            ),
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "Search by area,street name.....",
                            hintStyle: TextStyle(
                              color: Colors.black54,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        // _searchdialogbox(context);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddaddressScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 25,
                              // width: 20,
                              // color: Colors.red,
                              padding: const EdgeInsets.only(left: 10),
                              child: Image.asset("assets/direction.png"),
                            ),
                            Container(
                              height: 67,
                              // color: Colors.red,
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AddaddressScreen(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "Use your current location",
                                      style: TextStyle(
                                        color: Color(0xFF000052),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                      left: 5,
                                    ),
                                    // color: Colors.blue,
                                    child: Text(
                                      "$Address",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
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
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 1,
                      color: CupertinoColors.systemGrey3,
                    ),
                    addresslist.isEmpty
                        ? Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    // _searchdialogbox(context);
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AddaddressScreen(),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.add_circled,
                                    color: Colors.black,
                                    // size: 22,
                                  ),
                                ),
                                // const SizedBox(
                                //   width: 5,
                                // ),
                                TextButton(
                                  onPressed: () {
                                    // _searchdialogbox(context);
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AddaddressScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Add Address",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: const Text(
                                    "Saved Addresses",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 0,
                                  child: Container(
                                    height: addresslist.length * 200,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: addresslist.length,
                                        itemBuilder:
                                            (BuildContext cntx, int index) {
                                          return InkWell(
                                            onTap: () {},
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  top: 30),
                                              // color: Colors.red,
                                              height: 140,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(
                                                // crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 25,
                                                    // width: 20,
                                                    // color: Colors.red,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Image.asset(
                                                        "assets/direction.png"),
                                                  ),
                                                  const SizedBox(
                                                    width: 12,
                                                  ),
                                                  Container(
                                                    // height: 67,
                                                    // color: Colors.red,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 1),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          addresslist[index][
                                                                  'address_type_text']
                                                              .toString(),
                                                          style: const TextStyle(
                                                              color: Color(
                                                                  0xFF000052),
                                                              fontSize: 16.5,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.05,
                                                          //color: Colors.red,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 0,
                                                          ),
                                                          // color: Colors.blue,
                                                          child: Text(
                                                            addresslist[index]
                                                                    ["address"]
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  GetAddress_ApiCall() async {
    setState(() {
      isReload = true;
    });
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token") ?? "";
      print(token);
      final Header = {
        "Authorization": "Bearer ${token.toString()}",
      };
      print(Header);
      print(GetCustomeraddress_Api);
      var response =
          await http.get(Uri.parse(GetCustomeraddress_Api), headers: Header);

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        print(decode);
        if (decode["success"] = true) {
          addresslist.clear();
          addresslist = decode["data"];
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
      print("Exception in getaddress =>" + e.toString());
      throw e;
    }
  }
}
