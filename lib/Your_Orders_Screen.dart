import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:safaidaar_customer/Api/Api_Url.dart';
import 'package:safaidaar_customer/Your_Order_Detail_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'BottomNavigationScreen.dart';

class Your_orders extends StatefulWidget {
  const Your_orders({Key? key}) : super(key: key);

  @override
  State<Your_orders> createState() => _Your_ordersState();
}

class _Your_ordersState extends State<Your_orders> {
  bool isReload = false;
  bool isReloadPagination = false;

  ScrollController scrollController = ScrollController();
  TextEditingController fromdate = TextEditingController();
  TextEditingController todate = TextEditingController();

  int currentPage = 0;
  int lastPage = 0;
  int pageIndex = 0;

  List<dynamic> orderlist = [
    // {
    //   'image': 'assets/exp1.jpg',
    //   'name': 'Namita',
    //   'state': 'Maharashtra',
    //   'order id': '22-23/181',
    //   'img2': 'assets/Shirt-1.png',
    //   'price': 2140,
    //   'QTY': 4,
    //   'payment status': 'Pay to Dispatch',
    // },
    // {
    //   'image': 'assets/exp1.jpg',
    //   'name': 'Shiva',
    //   'state': 'Maharashtra',
    //   'order id': '22-23/180',
    //   'img2': 'assets/Shirt-1.png',
    //   'price': 1439,
    //   'QTY': 10,
    //   'payment status': 'Paid',
    // },
    // {
    //   'image': 'assets/exp1.jpg',
    //   'name': 'Diyanshi',
    //   'state': 'Maharashtra',
    //   'order id': '22-23/178',
    //   'img2': 'assets/Shirt-1.png',
    //   'price': 1439,
    //   'QTY': 7,
    //   'payment status': 'Pay to Dispatch',
    // },
    // {
    //   'image': 'assets/exp1.jpg',
    //   'name': 'Hiransh',
    //   'state': 'Maharashtra',
    //   'order id': '22-23/256',
    //   'img2': 'assets/Shirt-1.png',
    //   'price': 8597,
    //   'QTY': 2,
    //   'payment status': 'Paid',
    // },
  ];

  @override
  void initState() {
    fromdate.text = "";
    todate.text = "";
    GetCustomerOrder_ApiCall(false);

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if (currentPage != lastPage) {
          GetCustomerOrder_ApiCall(true);
        }
        print("orderlist pagination");
      }
    });

    //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    print(width);
    double height = MediaQuery.of(context).size.height;
    print(height);
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
              "Your Orders",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ),
        body: isReload
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF000052),
                ),
              )
            : Container(
                child: Stack(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(top: 15, left: 20, right: 20),
                      // height: height,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        controller: scrollController,
                        child: Container(
                          height: height * 2.5,
                          child: Column(
                            children: [
                              Container(
                                height: 45,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      "From Date",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      "To Date",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    //  color: CupertinoColors.systemGrey3,
                                    width: width * 0.4,
                                    height: 45,
                                    child: TextFormField(
                                      readOnly: true,
                                      onTap: () async {
                                        DateTime? pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1950),
                                            //DateTime.now() - not to allow to choose before today.
                                            lastDate: DateTime.now(),
                                            builder: (context, child) {
                                              return Theme(
                                                  data: Theme.of(context)
                                                      .copyWith(
                                                    colorScheme:
                                                        const ColorScheme.light(
                                                      primary:
                                                          Color(0xFF000052),
                                                      // <-- SEE HERE
                                                      onPrimary: Colors.white,
                                                      // <-- SEE HERE
                                                      onSurface: Colors
                                                          .black, // <-- SEE HERE
                                                    ),
                                                    textButtonTheme:
                                                        TextButtonThemeData(
                                                      style: TextButton.styleFrom(
                                                          primary: const Color(
                                                              0xFF000052) // button text color
                                                          ),
                                                    ),
                                                  ),
                                                  child: child!);
                                            }); //DateTime(2023));
                                        if (pickedDate != null) {
                                          print(
                                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                          String formattedDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(pickedDate);
                                          print(
                                              formattedDate); //formatted date output using intl package =>  2021-03-16
                                          setState(() {
                                            fromdate.text = formattedDate;
                                            String datePattern = "yyyy-MM-dd";
                                            DateTime birthDate =
                                                DateFormat(datePattern)
                                                    .parse(fromdate.text);
                                            DateTime today = DateTime.now();
                                            int yearDiff =
                                                today.year - birthDate.year;
                                            print("year $yearDiff");
                                            //set output date to TextField value.
                                          });
                                        } else {}

                                        if (todate.text != "") {
                                          pageIndex = 0;
                                          GetCustomerOrder_ApiCall(false);
                                        }
                                      },
                                      controller: fromdate,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: CupertinoColors
                                                    .systemGrey4),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: CupertinoColors
                                                    .systemGrey4),
                                          ),
                                          suffixIcon: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.calendar_today_outlined,
                                              color: Colors.grey,
                                              size: 25,
                                            ),
                                          ),
                                          hintText: 'dd-MM-YYYY',
                                          hintStyle: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal)),
                                    ),
                                  ),
                                  // const SizedBox(width: 20,),
                                  Container(
                                    //  color: Colors.red,
                                    width: width * 0.4,
                                    height: 45,
                                    child: TextFormField(
                                      readOnly: true,
                                      onTap: () async {
                                        DateTime? pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1950),
                                            //DateTime.now() - not to allow to choose before today.
                                            lastDate: DateTime.now(),
                                            builder: (context, child) {
                                              return Theme(
                                                  data: Theme.of(context)
                                                      .copyWith(
                                                    colorScheme:
                                                        const ColorScheme.light(
                                                      primary:
                                                          Color(0xFF000052),
                                                      // <-- SEE HERE
                                                      onPrimary: Colors.white,
                                                      // <-- SEE HERE
                                                      onSurface: Colors
                                                          .black, // <-- SEE HERE
                                                    ),
                                                    textButtonTheme:
                                                        TextButtonThemeData(
                                                      style:
                                                          TextButton.styleFrom(
                                                        primary: const Color(
                                                            0xFF000052), // button text color
                                                      ),
                                                    ),
                                                  ),
                                                  child: child!);
                                            }); //DateTime(2023));
                                        if (pickedDate != null) {
                                          print(
                                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                          String formattedDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(pickedDate);
                                          print(
                                              formattedDate); //formatted date output using intl package =>  2021-03-16
                                          setState(() {
                                            todate.text = formattedDate;
                                            String datePattern = "yyyy-MM-dd";
                                            DateTime birthDate =
                                                DateFormat(datePattern)
                                                    .parse(todate.text);
                                            DateTime today = DateTime.now();
                                            int yearDiff =
                                                today.year - birthDate.year;
                                            print("year $yearDiff");
                                            //set output date to TextField value.
                                          });

                                          if (fromdate.text != "") {
                                            pageIndex = 0;
                                            GetCustomerOrder_ApiCall(false);
                                          }
                                        } else {}
                                      },
                                      controller: todate,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color:
                                                  CupertinoColors.systemGrey4),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color:
                                                  CupertinoColors.systemGrey4),
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.calendar_today_outlined,
                                            color: Colors.grey,
                                            size: 25,
                                          ),
                                        ),
                                        hintText: 'dd-MM-YYYY',
                                        hintStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Flexible(
                                flex: 5,
                                child: orderlist.length > 0
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: orderlist.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                            height: 320,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Yourorderdetail(),
                                                  ),
                                                );
                                              },
                                              child: Card(
                                                elevation: 3,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Container(
                                                      // color:Colors.blue,
                                                      height: 125,
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 10,
                                                        top: 20,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child: Container(
                                                              height: 80,
                                                              width: 95,
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: const Color(
                                                                          0xFF000052),
                                                                      width:
                                                                          2.5),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              child:
                                                                  Image.network(
                                                                // "",
                                                                orderlist[index]['order_detail']
                                                                            [
                                                                            'vendor_information']
                                                                        [
                                                                        'vendor_banner_image']
                                                                    .toString(),
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Container(
                                                            // color: Colors.red,
                                                            height: 100,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Text(
                                                                  orderlist[index]['order_detail']
                                                                              [
                                                                              'vendor_information']
                                                                          [
                                                                          'vendor_name']
                                                                      .toString(),
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  // color: Colors.red,
                                                                  width: width *
                                                                      0.52,
                                                                  child: Text(
                                                                    "${orderlist[index]['order_detail']['customer_address_information']['city'].toString()}, ${orderlist[index]['order_detail']['customer_address_information']['state'].toString()}",
                                                                    // maxLines: 4,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          16,
                                                                      // fontWeight: FontWeight.bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  // "",
                                                                  "Order ID: ${orderlist[index]['order_barcode_no'].toString()}",
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 25,
                                                                  // width: Sizee.width / 3,
                                                                  width: width *
                                                                      0.35,
                                                                  child:
                                                                      RaisedButton(
                                                                    elevation:
                                                                        0,
                                                                    color: const Color(
                                                                        0xFF000052),
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .push(
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              const Yourorderdetail(),
                                                                        ),
                                                                      );
                                                                    },
                                                                    child: Text(
                                                                      // "",
                                                                      orderlist[index]
                                                                              [
                                                                              'order_status_text']
                                                                          .toString(),
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w500,
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
                                                    const Divider(
                                                      thickness: 1,
                                                      color: CupertinoColors
                                                          .systemGrey6,
                                                    ),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5),
                                                      height: 25,
                                                      child: Row(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        60),
                                                            child:
                                                                Image.network(
                                                              //"",
                                                              orderlist[index][
                                                                          'order_item_detail'][0]
                                                                      [
                                                                      'item_image']
                                                                  .toString(),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            // "",
                                                            "${orderlist[index]['order_item_detail'][0]['item_name'].toString()} x ${orderlist[index]['order_item_detail'][0]['quantity'].toString()}",
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const Divider(
                                                      thickness: 1,
                                                      color: CupertinoColors
                                                          .systemGrey6,
                                                    ),
                                                    Container(
                                                      height: 50,
                                                      // color: Colors.red,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 12,
                                                              right: 15),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                orderlist[index]
                                                                        [
                                                                        'order_date_text']
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black54,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              const Text(
                                                                "Payment Status",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black54,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                // color: Colors.red,
                                                                width: width *
                                                                    0.25,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .bottomCenter,
                                                                      height:
                                                                          20,
                                                                      //color: Colors.green,
                                                                      child:
                                                                          Text(
                                                                        // "",
                                                                        "Rs ${orderlist[index]['total_amount'].toString()}",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              Color(0xFF000052),
                                                                          fontSize:
                                                                              14,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      // color: Colors.blue,
                                                                      height:
                                                                          20,
                                                                      width: 20,
                                                                      child:
                                                                          const Icon(
                                                                        Icons
                                                                            .arrow_forward_ios,
                                                                        color: Colors
                                                                            .black,
                                                                        size:
                                                                            13,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                // "",
                                                                orderlist[index]
                                                                            [
                                                                            'order_payment_detail']
                                                                        [
                                                                        'payment_status_text']
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  color: orderlist[index]['order_payment_detail']
                                                                              [
                                                                              'payment_status_text'] ==
                                                                          "Paid"
                                                                      ? Colors
                                                                          .green
                                                                      : Colors
                                                                          .red,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    orderlist[index][
                                                                    'order_payment_detail']
                                                                [
                                                                'payment_status_text'] ==
                                                            "Paid"
                                                        ? SizedBox()
                                                        : Column(
                                                            children: [
                                                              const Divider(
                                                                thickness: 1,
                                                                color: CupertinoColors
                                                                    .systemGrey6,
                                                              ),
                                                              Container(
                                                                height: 30,
                                                                // width: Sizee.width / 3,
                                                                width:
                                                                    width * 0.3,
                                                                child:
                                                                    RaisedButton(
                                                                  elevation: 0,
                                                                  color: const Color(
                                                                      0xFF000052),
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .push(
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                const Yourorderdetail(),
                                                                      ),
                                                                    );
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    "Pay Now",
                                                                    // orderlist[index][
                                                                    // 'order_status_text']
                                                                    //     .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              RichText(
                                                                text:
                                                                    const TextSpan(
                                                                  text: "*",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                  children: <
                                                                      TextSpan>[
                                                                    TextSpan(
                                                                      text:
                                                                          "No Cash Payments Allowed",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .red,
                                                                        fontSize:
                                                                            12,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                            ],
                                                          ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        })
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
                                          Container(
                                            height: 40,
                                            //width: Sizee.width,
                                            width: width * 0.6,
                                            child: RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              color: const Color(0xFF000052),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const BottomNavigationScreen(
                                                            0),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                "Order Now",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
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
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      top: 0,
                      child: isReloadPagination
                          ? Container(
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xFF000052),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  GetCustomerOrder_ApiCall(bool isPaginate) async {
    setState(() {
      if (!isPaginate) {
        isReload = true;
      } else {
        isReloadPagination = true;
      }
    });
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token") ?? "";
      // var user_id = prefs.getString("id") ?? "";
      print(token);
      final Header = {
        "Authorization": "Bearer ${token.toString()}",
      };
      print(Header);
      //   var response = await http.post(Uri.parse(login), body: body);
      print(GetCustomerorder_Api +
          "?from_date=${fromdate.text}&to_date=${todate.text}&order_status=&search=&paginate=${true}&page=${pageIndex}");
      var response = await http.get(
          Uri.parse(
            GetCustomerorder_Api +
                "?from_date=${fromdate.text}&to_date=${todate.text}&order_status=&search=&paginate=${true}&page=${pageIndex}",
          ),
          headers: Header);

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        print(decode);

        if (decode["success"] == true) {
          setState(() {
            currentPage = decode["data"]["current_page"];
            lastPage = decode["data"]["last_page"];
            if (currentPage == 1) {
              orderlist.clear();
            }

            for (int i = 0; i < decode["data"]["data"].length; i++) {
              orderlist.add(decode['data']['data'][i]);
            }
            //print("decode ${decode["data"][0]["data"]} " );
            // orderlist.clear();
            // orderlist = decode["data"]["data"];
          });
        } else {
          final snackBar = SnackBar(
            content: Text(
              decode["message"].toString(),
            ),
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
      print("Exception in Today Attendance=>" + e.toString());
      throw e;
    }
  }
}
