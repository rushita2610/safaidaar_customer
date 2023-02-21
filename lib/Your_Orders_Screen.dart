import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:safaidaar_customer/Api/Api_Url.dart';
import 'package:safaidaar_customer/Your_Order_Detail_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Your_orders extends StatefulWidget {
  const Your_orders({Key? key}) : super(key: key);

  @override
  State<Your_orders> createState() => _Your_ordersState();
}

class _Your_ordersState extends State<Your_orders> {
  bool isReload = false;

  TextEditingController DOBdateinput = TextEditingController();
  TextEditingController Annidateinput = TextEditingController();

  List<dynamic> orderlist = [
    {
      'image': 'assets/exp1.jpg',
      'name': 'Namita',
      'state': 'Maharashtra',
      'order id': '22-23/181',
      'img2': 'assets/Shirt-1.png',
      'price': 2140,
      'QTY': 4,
      'payment status': 'Pay to Dispatch',
    },
    {
      'image': 'assets/exp1.jpg',
      'name': 'Shiva',
      'state': 'Maharashtra',
      'order id': '22-23/180',
      'img2': 'assets/Shirt-1.png',
      'price': 1439,
      'QTY': 10,
      'payment status': 'Paid',
    },
    {
      'image': 'assets/exp1.jpg',
      'name': 'Diyanshi',
      'state': 'Maharashtra',
      'order id': '22-23/178',
      'img2': 'assets/Shirt-1.png',
      'price': 1439,
      'QTY': 7,
      'payment status': 'Pay to Dispatch',
    },
    {
      'image': 'assets/exp1.jpg',
      'name': 'Hiransh',
      'state': 'Maharashtra',
      'order id': '22-23/256',
      'img2': 'assets/Shirt-1.png',
      'price': 8597,
      'QTY': 2,
      'payment status': 'Paid',
    },
  ];

  @override
  void initState() {
    DOBdateinput.text = "";
    Annidateinput.text = "";
    GetCustomerOrder_ApiCall(); //set the initial value of text field
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
        body: (isReload == false)
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  //height: Sizee.height * 2,
                  height: height * 1.5,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "From Date",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            "To Date",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            // width: Sizee.width / 2 - 30,
                            width: width * 0.42,
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
                                          data: Theme.of(context).copyWith(
                                            colorScheme:
                                                const ColorScheme.light(
                                              primary: Color(0xFF000052),
                                              // <-- SEE HERE
                                              onPrimary: Colors.white,
                                              // <-- SEE HERE
                                              onSurface:
                                                  Colors.black, // <-- SEE HERE
                                            ),
                                            textButtonTheme:
                                                TextButtonThemeData(
                                              style: TextButton.styleFrom(
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
                                    DOBdateinput.text = formattedDate;
                                    String datePattern = "yyyy-MM-dd";
                                    DateTime birthDate = DateFormat(datePattern)
                                        .parse(DOBdateinput.text);
                                    DateTime today = DateTime.now();
                                    int yearDiff = today.year - birthDate.year;
                                    print("year $yearDiff");
                                    //set output date to TextField value.
                                  });
                                } else {}
                              },
                              controller: DOBdateinput,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: CupertinoColors.systemGrey4),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: CupertinoColors.systemGrey4),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.calendar_today_outlined,
                                    color: Colors.grey,
                                  ),
                                ),
                                hintText: 'dd/mm/yyyy',
                              ),
                            ),
                          ),
                          // const SizedBox(width: 20,),
                          Container(
                            // width: Sizee.width / 2 - 30,
                            width: width * 0.42,
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
                                          data: Theme.of(context).copyWith(
                                            colorScheme:
                                                const ColorScheme.light(
                                              primary: Color(0xFF000052),
                                              // <-- SEE HERE
                                              onPrimary: Colors.white,
                                              // <-- SEE HERE
                                              onSurface:
                                                  Colors.black, // <-- SEE HERE
                                            ),
                                            textButtonTheme:
                                                TextButtonThemeData(
                                              style: TextButton.styleFrom(
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
                                    Annidateinput.text = formattedDate;
                                    String datePattern = "yyyy-MM-dd";
                                    DateTime birthDate = DateFormat(datePattern)
                                        .parse(Annidateinput.text);
                                    DateTime today = DateTime.now();
                                    int yearDiff = today.year - birthDate.year;
                                    print("year $yearDiff");
                                    //set output date to TextField value.
                                  });
                                } else {}
                              },
                              controller: Annidateinput,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: CupertinoColors.systemGrey4),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: CupertinoColors.systemGrey4),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.calendar_today_outlined,
                                    color: Colors.grey,
                                  ),
                                ),
                                hintText: 'dd/mm/yyyy',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight: orderlist.length * 250, minHeight: 255),
                        // height: orderlist.length * 250,
                        // width: Sizee.width,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: orderlist.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: 250,
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
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          // color:Colors.blue,
                                          height: 125,
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                            top: 20,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 80,
                                                width: 95,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: const Color(
                                                          0xFF000052),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Image.asset(
                                                    orderlist[index]['image']),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                // color: Colors.red,
                                                height: 100,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text(
                                                      orderlist[index]['name'],
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      orderlist[index]['state'],
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 17,
                                                        // fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Order ID: ${orderlist[index]['order id']}",
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 25,
                                                      // width: Sizee.width / 3,
                                                      width: width * 0.35,
                                                      child: RaisedButton(
                                                        elevation: 0,
                                                        color: const Color(
                                                            0xFF000052),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const Yourorderdetail(),
                                                            ),
                                                          );
                                                        },
                                                        child: const Text(
                                                          "PROCESSING",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
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
                                          color: CupertinoColors.systemGrey6,
                                        ),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          height: 35,
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(60),
                                                child: Image.asset(
                                                    orderlist[index]['img2']),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "T-Shirt x ${orderlist[index]['QTY']}",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Divider(
                                          thickness: 1,
                                          color: CupertinoColors.systemGrey6,
                                        ),
                                        Container(
                                          height: 50,
                                          // color: Colors.red,
                                          padding: const EdgeInsets.only(
                                              left: 12, right: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: const [
                                                  Text(
                                                    "January 27, 2023 at 07:02 AM",
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "Payment Status",
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    // color: Colors.red,
                                                    width: width * 0.2,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          alignment: Alignment
                                                              .bottomCenter,
                                                          height: 20,
                                                          //color: Colors.green,
                                                          child: Text(
                                                            "Rs ${orderlist[index]['price']}",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                              color: Color(
                                                                  0xFF000052),
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          // color: Colors.blue,
                                                          height: 20,
                                                          width: 20,
                                                          child: IconButton(
                                                            onPressed: () {
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
                                                            icon: const Icon(
                                                              Icons
                                                                  .arrow_forward_ios,
                                                              color:
                                                                  Colors.black,
                                                              size: 15,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    orderlist[index]
                                                        ['payment status'],
                                                    style: const TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 14,
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

  GetCustomerOrder_ApiCall() async {
    setState(() {
      isReload = true;
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
      var response = await http.get(
        Uri.parse(
            "$GetCustomerorder_Api?from_date=$DOBdateinput&to_date=$Annidateinput&order_status=&search=null&paginate=false"),
        headers: Header,
      );

      if (response.statusCode == 200) {
        var decode = jsonDecode((response.body));
        print(decode);
        if (decode["success"] = true) {
          print(decode);
          orderlist.clear();
          orderlist = decode["data"][0]["data"];
        } else {
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
        }
        setState(() {
          isReload = false;
        });
      }
    } catch (e) {
      setState(() {
        isReload = false;
      });
      print("Exception in Customerorder =>$e");
      throw e;
    }
  }
}
