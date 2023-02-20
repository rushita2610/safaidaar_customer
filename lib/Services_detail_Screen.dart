// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:safaidaar_customer/FeaturedStore_Detail_Screen.dart';

class Servicedetail extends StatefulWidget {
  const Servicedetail({Key? key}) : super(key: key);

  @override
  State<Servicedetail> createState() => _ServicedetailState();
}

class _ServicedetailState extends State<Servicedetail> {
  bool? isReload;
  List<dynamic> featuredstorelist = [
    {
      'image': 'assets/exp1.jpg',
      'name': 'Exp-1',
      'deliveryrange': 66,
      'starting': 52.5,
    },
    {
      'image': 'assets/exp2.jpg',
      'name': 'Exp-2',
      'deliveryrange': 50,
      'starting': 65.5,
    },
    {
      'image': 'assets/exp1.jpg',
      'name': 'Exp-3',
      'deliveryrange': 55,
      'starting': 89.5,
    },
    {
      'image': 'assets/exp1.jpg',
      'name': 'Exp-4',
      'deliveryrange': 72,
      'starting': 40.5,
    },
  ];

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
              "Laundry",
              style: TextStyle(
                // fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: Sizee.height * 1.9,
            width: Sizee.width,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "All Vendors Providing Laundry",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 15),
                  height: featuredstorelist.length * 355,
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
                        height: 350,
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            // side: const BorderSide(
                            //     color: Colors.grey),
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          color: Colors.white,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DetailFeatured_Store(
                                    isFrom: 'service',
                                  ),
                                ),
                              );
                            },
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  bottom: Sizee.height / 6,
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    height: 10,
                                    child: ClipRRect(
                                      child: Image.asset(
                                        featuredstorelist[index]['image'],
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
                                  height: Sizee.height / 6.5,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        featuredstorelist[index]['name'],
                                        maxLines: 2,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: const Color(0xFF000052),
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        height: 25,
                                        width: 55,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              Icons.star,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              "3",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
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
                                                  const EdgeInsets.only(top: 5),
                                              height: 20,
                                              child: Image.asset(
                                                "assets/map-blue.png",
                                                color: const Color(0xFF000052),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 7),
                                              child: Text(
                                                "Delivery Range: ${featuredstorelist[index]['deliveryrange']} KM",
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
                                        width: Sizee.width / 2 - 55,
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
                                                Icons.account_balance_wallet,
                                                color: Color(0xFF000052),
                                                size: 15,
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 7),
                                              child: Text(
                                                "Starting From Rs ${featuredstorelist[index]['starting']}",
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
        ),
      ),
    );
  }
}
