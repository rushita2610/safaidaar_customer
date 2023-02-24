// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safaidaar_customer/FeaturedStore_Detail_Screen.dart';
import 'package:safaidaar_customer/SchedulePickUp_Screen.dart';

import 'FeaturedStore_VendorScreen.dart';

class Cartdetails extends StatefulWidget {
  const Cartdetails({Key? key}) : super(key: key);

  @override
  State<Cartdetails> createState() => _CartdetailsState();
}

class _CartdetailsState extends State<Cartdetails> {
  bool? isReload;

  int cartQTY = 0;
  double cartToTal = 0.0;
  double deliverycharge = 20;
  double grandtotal = 0.0;

  double sgst = 0;
  double cgst = 0;
  double sgstPercent = 9;
  double cgstPercent = 9;
  double totalgst = 0.0;

  List<dynamic> productList = [
    {
      'clean': "In Dry Cleaning with Ironing (Men's)",
      'name': "T-shirt",
      "image": "assets/Shirt-1.png",
      'QTY': 0,
      'price': 30
    },
    {
      'clean': "In Dry Cleaning with Ironing (Men's)",
      'name': "Shirt",
      "image": "assets/Shirt.png",
      'QTY': 0,
      'price': 50
    },
  ];

  UpdateCartPrice() {
    setState(() {
      cartQTY = 0;
      cartToTal = 0.0;
      deliverycharge = 20;
      grandtotal = 0.0;

      for (var i = 0; i < productList.length; i++) {
        print(productList[i]["QTY"].toString());
        cartQTY = cartQTY + int.parse(productList[i]["QTY"].toString());
        cartToTal =
            cartToTal + (productList[i]["QTY"] * productList[i]["price"]);

        // grandtotal = grandtotal + (productList[i]["QTY"] * productList[i]["price"]) + deliverycharge;
      }

      sgst = ((cartToTal + deliverycharge) * sgstPercent) / 100;
      cgst = ((cartToTal + deliverycharge) * cgstPercent) / 100;
      totalgst = sgst + cgst;

      grandtotal = totalgst + cartToTal + deliverycharge;

      print("$cartQTY, $cartToTal, $grandtotal");
    });
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

  Future<void> _showtaxdialogbox(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => Container(
        height: 70,
        // width: MediaQuery.of(context).size.width - 40,
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "SGST ($sgstPercent%)",
                    style: TextStyle(
                      fontSize: 18,
                      // fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Rs $sgst",
                    style: TextStyle(
                      fontSize: 18,
                      // fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "CGST ($cgstPercent%)",
                    style: TextStyle(
                      fontSize: 18,
                      // fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Rs $cgst",
                    style: TextStyle(
                      fontSize: 18,
                      // fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const Divider(
                thickness: 1,
                color: CupertinoColors.systemGrey6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Tax",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Rs $totalgst",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextEditingController PromoCode = TextEditingController();
  TextEditingController Addproductcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // final Sizee = MediaQuery.of(context).size;
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
              "Cart Details",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15),
            height: height,
            child: Column(
              children: [
                Container(
                  // color: Colors.red,
                  height: 43,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              "Your Order",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            height: 3,
                            width: width * 0.15,
                            color: const Color(0xFF000052),
                          ),
                        ],
                      ),
                      Container(
                        // color: Colors.grey,
                        height: 20,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.delete_rounded,
                            color: Colors.blue,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                // const SizedBox(
                //   height: 8,
                // ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: productList.length * 120, minHeight: 125),
                  // height: productList.length * 120,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: productList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          //  color: Colors.red,
                          width: width,
                          height: height * 0.15,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _showproductdialogbox(context);
                                    },
                                    child: Container(
                                      height: height * 0.09,
                                      width: width * 0.2,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Image.asset(
                                          productList[index]["image"]),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // color: Colors.blue,
                                        width: width * 0.45,
                                        height: height * 0.04,
                                        child: Text(
                                          productList[index]["clean"],
                                          maxLines: 2,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        productList[index]["name"],
                                        maxLines: 2,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Container(
                                        // color: Colors.red,
                                        width: width * 0.3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              height: 30,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF000052),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          9.5)),
                                              child: Text(
                                                productList[index]['QTY'].toString(),
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  // fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "x Rs ${productList[index]["price"]}",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 17,
                                                // fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    // color: Colors.red,
                                    height: height * 0.1,
                                    width: width * 0.25,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              // color: Colors.blue,
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          height: height * 0.05,
                                          width: width * 0.25,
                                          child: Row(
                                            children: [
                                              Container(
                                                height: height * 0.05,
                                                width: width * 0.084,
                                                child: RaisedButton(
                                                  elevation: 0,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(5),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    5)),
                                                  ),
                                                  color:
                                                      const Color(0xFF000052),
                                                  onPressed: () {
                                                    setState(() {
                                                     if(productList[index]['QTY'] > 0) {
                                                       productList[index]
                                                       ["QTY"] = int.parse(
                                                           productList[index]
                                                           ["QTY"]
                                                               .toString()) -
                                                           1;
                                                     } else {
                                                       productList[index]['QTY'] == 0;
                                                     }
                                                      print(
                                                        productList[index]
                                                            ["QTY"],
                                                      );
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
                                                alignment: Alignment.center,
                                                color: Colors.white,
                                                height: height * 0.05,
                                                width: width * 0.074,
                                                child: Text(
                                                  productList[index]["QTY"]
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.05,
                                                width: width * 0.084,
                                                child: RaisedButton(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight: Radius
                                                                .circular(5),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5)),
                                                  ),
                                                  color:
                                                      const Color(0xFF000052),
                                                  onPressed: () {
                                                    setState(() {
                                                      productList[index]
                                                          ["QTY"] = int.parse(
                                                              productList[index]
                                                                      ["QTY"]
                                                                  .toString()) +
                                                          1;
                                                      print(productList[index]
                                                          ["QTY"]);
                                                      UpdateCartPrice();
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
                                        ),
                                        Container(
                                          // color: Colors.red,
                                          child: Text(
                                            "Rs ${productList[index]["price"] * productList[index]["QTY"]}",
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              // fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                Container(
                  // color: Colors.red,
                  width: width * 0.5,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          // _searchdialogbox(context);
                          // Navigator.of(context).pushReplacement(
                          //   MaterialPageRoute(
                          //     builder: (context) => DetailFeatured_Store(
                          //       isFrom: 'service', userid: featuredstorelist[index]["user_id"].toString(),
                          //     ),
                          //   ),
                          // );
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Color(0xFF000052),
                          size: 22,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // _searchdialogbox(context);
                          // Navigator.of(context).pushReplacement(
                          //   MaterialPageRoute(
                          //     builder: (context) => DetailFeatured_Store(
                          //       isFrom: 'service', userid: featuredstorelist[index]["user_id"].toString(),
                          //     ),
                          //   ),
                          // );
                        },
                        child: const Text(
                          "Add More Items",
                          style: TextStyle(
                            color: Color(0xFF000052),
                            fontSize: 17,
                            // fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  // color: Colors.red,
                  height: height * 0.07,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.local_offer_rounded,
                        color: Color(0xFF000052),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        width: width * 0.55,
                        height: height * 0.06,
                        child: TextFormField(
                          // readOnly: true,
                          controller: PromoCode,
                          // keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              hintText: "Enter Promo Code"),
                          textAlign: TextAlign.left,
                          // validator: (text) {
                          //   if (text == null || text.isEmpty) {
                          //     return 'Please enter Full Name ';
                          //   }
                          //   return null;
                          // },
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        height: height * 0.06,
                        width: width * 0.27,
                        child: RaisedButton(
                          elevation: 0,
                          color: const Color(0xFF000052),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          onPressed: () {
                            // Navigator.pop(context);
                          },
                          child: const Text(
                            "Offers",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  // color: Colors.red,
                  height: height * 0.3,
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Item Total",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "Rs $cartToTal",
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Delivery Charges",
                            style: TextStyle(
                              // fontWeight: FontWeight.w900,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "Rs 20",
                            style: TextStyle(
                              // fontWeight: FontWeight.w900,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Tax",
                                style: TextStyle(
                                  // fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _showtaxdialogbox(context);
                                },
                                icon: const Icon(
                                  Icons.info_outline_rounded,
                                  color: Color(0xFF000052),
                                  size: 25,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Rs $totalgst",
                            style: const TextStyle(
                              // fontWeight: FontWeight.w900,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Discount",
                            style: TextStyle(
                              // fontWeight: FontWeight.w900,
                              color: Colors.blue,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "-Rs 0",
                            style: TextStyle(
                              // fontWeight: FontWeight.w900,
                              color: Colors.blue,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.black54,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Grand Total",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                              fontSize: 19,
                            ),
                          ),
                          Text(
                            "Rs $grandtotal",
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                              fontSize: 19,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: width,
                  child: RaisedButton(
                    elevation: 0,
                    color: const Color(0xFF000052),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SchedulePickupScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Schedule a pickup",
                      style: TextStyle(
                        fontSize: 20,
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
      ),
    );
  }
}
