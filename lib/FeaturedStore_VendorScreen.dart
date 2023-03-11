// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:safaidaar_customer/FeaturedStore_Detail_Screen.dart';
import 'package:http/http.dart' as http;
import 'Api/Api_Url.dart';

class Featuredstore extends StatefulWidget {
  const Featuredstore({Key? key}) : super(key: key);

  @override
  State<Featuredstore> createState() => _FeaturedstoreState();
}

class _FeaturedstoreState extends State<Featuredstore> {
  bool isReload = false;

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

  int currentPage = 0;
  int lastPage = 0;
  int pageIndex = 0;
  bool isReloadPagination = false;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    FeatureStore_ApiCall(false);
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if (currentPage != lastPage) {
          FeatureStore_ApiCall(true);
        }
        print("orderlist pagination");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Sizee = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: Transform(
            transform: Matrix4.translationValues(-20, 0.0, 0.0),
            child: const Text(
              "Featured Store/Vendor",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ),
        body: (isReload == false)
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  // height: Sizee.height * 1.9,
                  // width: Sizee.width,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "All Vendors Providing Featured Store/ ...",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 15),
                        height: featuredstorelist.length * 305,
                        width: Sizee.width,
                        //     color: Colors.green,
                        child: ListView.builder(
                          // scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: featuredstorelist.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              // color: Colors.blue,
                              padding: const EdgeInsets.only(
                                bottom: 10,
                              ),
                              width: 180,
                              height: 300,
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  // side: const BorderSide(
                                  //     color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: Colors.white,
                                child: GestureDetector(
                                  onTap: () {
                                    print(featuredstorelist[index]["user_id"]
                                        .toString());
                                    print(featuredstorelist[index]["vendor_id"]
                                        .toString());
                                    featuredstorelist[index]["user_id"]
                                        .toString();
                                    featuredstorelist[index]["vendor_id"]
                                        .toString();
                                    // featuredstorelist[index]
                                    // ["vendor_id"]
                                    //     .toString();
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailFeatured_Store(
                                          isFrom: 'service',
                                          userid: featuredstorelist[index]
                                                  ["user_id"]
                                              .toString(),
                                          vendorid: featuredstorelist[index]
                                                  ["vendor_id"]
                                              .toString(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        bottom: Sizee.height / 10,
                                        right: 0,
                                        top: 0,
                                        child: Container(
                                          height: 10,
                                          child: ClipRRect(
                                            borderRadius:
                                            const BorderRadius
                                                .only(
                                                topLeft: Radius
                                                    .circular(
                                                    10),
                                                topRight: Radius
                                                    .circular(
                                                    10)),
                                            child: Image.network(
                                              featuredstorelist[index]
                                                      ['vendor_banner_image']
                                                  .toString(),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 10,
                                        // top: 50,
                                        right: 10,
                                        bottom: 0,
                                        height: Sizee.height / 12,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 30,
                                              child: Text(
                                                featuredstorelist[index]
                                                        ['vendor_name']
                                                    .toString(),
                                                maxLines: 2,
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 19,
                                                ),
                                              ),
                                            ),
                                            featuredstorelist[index]
                                                        ["rating"] ==
                                                    "0"
                                                ? SizedBox()
                                                : Container(
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xFF000052),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7)),
                                                    height: 25,
                                                    width: 55,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Icon(
                                                          Icons.star,
                                                          color: Colors.white,
                                                          size: 13,
                                                        ),
                                                        const SizedBox(
                                                          width: 2,
                                                        ),
                                                        Text(
                                                          featuredstorelist[
                                                                      index]
                                                                  ["rating"]
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        height: 70,
                                        left: 10,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              // color:Colors.red,
                                              width: Sizee.width / 2,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5),
                                                    height: 20,
                                                    child: Image.asset(
                                                      "assets/map-blue.png",
                                                      color: const Color(
                                                          0xFF000052),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 7),
                                                    child: Text(
                                                      "Delivery Range: ${featuredstorelist[index]['delivery_range'].toString()} KM",
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: Sizee.width / 2 - 45,
                                              //  color:Colors.grey,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    // padding:
                                                    //     const EdgeInsets.only(top: 5),
                                                    height: 20,
                                                    child: const Icon(
                                                      Icons
                                                          .account_balance_wallet,
                                                      color: Color(0xFF000052),
                                                      size: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 7),
                                                    child: Text(
                                                      "Starting From Rs ${featuredstorelist[index]['min_price'].toString()}",
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                ],
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

  FeatureStore_ApiCall(bool isPaginate) async {
    setState(() {
      if (!isPaginate) {
        isReload = true;
      } else {
        isReloadPagination = true;
      }
    });
    try {
      // final Header = {
      //   'Content-type': 'application/json',
      //   'Accept': 'application/json',
      // };
      print(FeaturedStore_Api +
          "?lattitude=23.03984909999999&longitude=72.5602797&page=${currentPage + 1}");
      var response = await http.get(Uri.parse(FeaturedStore_Api +
          "?lattitude=23.03984909999999&longitude=72.5602797&page=${currentPage + 1}"));
      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        print(decode);
        if (decode["success"] == true) {
          setState(() {
            currentPage = decode["data"]["current_page"];
            lastPage = decode["data"]["last_page"];
            if (currentPage == 1) {
              featuredstorelist.clear();
            }

            for (int i = 0; i < decode["data"]["data"].length; i++) {
              featuredstorelist.add(decode['data']['data'][i]);
            }
            //print("decode ${decode["data"][0]["data"]} " );
            // orderlist.clear();
            // orderlist = decode["data"]["data"];
          });
          // featuredstorelist.clear();
          // featuredstorelist = decode["data"]["data"];
          print(decode);
        } else {
          print("Error");
        }
        setState(() {
          if (!isPaginate) {
            isReload = false;
          } else {
            isReloadPagination = false;
          }
        });
      } else {
        print("Error" + response.statusCode.toString());
        print("Error" + response.body.toString());
      }
    } catch (e) {
      setState(() {
        if (!isPaginate) {
          isReload = false;
        } else {
          isReloadPagination = false;
        }
      });
      print("Exception in featurestore =>$e");
      throw e;
    }
  }
}
