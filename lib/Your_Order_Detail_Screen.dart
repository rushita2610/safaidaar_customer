import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safaidaar_customer/PaymentMethod_Screen.dart';
import 'package:safaidaar_customer/Support_Screen.dart';

class Yourorderdetail extends StatefulWidget {
  const Yourorderdetail({Key? key}) : super(key: key);

  @override
  State<Yourorderdetail> createState() => _YourorderdetailState();
}

class _YourorderdetailState extends State<Yourorderdetail> {
  bool isReload = true;
  String statusitem = '1';
  List<dynamic> statusData = [
    {"name": "Order Created By Mistake", "id": 1},
    {"name": "Item(s) would Not Arrive On Time", "id": 2},
    {"name": "Shipping Cost Too High", "id": 3},
  ];

  int statusid = 1;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    print(width);
    double height = MediaQuery.of(context).size.height;
    print(height);
    return SafeArea(
      child: Scaffold(
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
            "Your Orders",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: height * 1.3,
            width: width,
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Diyanshi",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    alignment: Alignment.topLeft,
                    height: 3,
                    width: 30,
                    color: const Color(0xFF000052),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width * 0.4,
                      //color: Colors.red,
                      child: const Text(
                        "Ahmedabad, Gujarat",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ),
                    Container(
                      height: 25,
                      width: MediaQuery.of(context).size.width / 3 - 30,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: CupertinoColors.systemGrey6,
                        //textColor: Color(0xFF000052)[900],
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Color(0xFF000052)),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Text('Pending',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.5,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: const [
                      Text(
                        "Download invoice",
                        style:
                            TextStyle(color: Color(0xFF000052), fontSize: 15),
                      ),
                      Icon(
                        Icons.download,
                        color: Color(0xFF000052),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Your Order",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    alignment: Alignment.topLeft,
                    height: 3,
                    width: 30,
                    color: const Color(0xFF000052),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Text(
                          "T-Shirt",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("(1 x Rs 30)",
                            style: TextStyle(fontSize: 15, color: Colors.blue)),
                      ],
                    ),
                    const Text("Rs 30",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold))
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 4),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Dry Cleaning With Ironing (Men's)",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 2,
                  color: CupertinoColors.systemGrey5,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Item Total",
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                    Text(
                      "Rs 30",
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Delivery Charges",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Rs 106.11",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Regular Vendor Delivery Option Delivery Charg",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Tax",
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => Container(
                                child: AlertDialog(
                                  title: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text(
                                            "SGST (9 %)",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            "Rs 10.45",
                                            style: TextStyle(fontSize: 15),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text(
                                            "CGST (9 %)",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            "Rs 10.45",
                                            style: TextStyle(fontSize: 15),
                                          )
                                        ],
                                      ),
                                      const Divider(
                                        thickness: 2,
                                        color: CupertinoColors.systemGrey5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text(
                                            "Total Tex",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            "Rs 20.9",
                                            style: TextStyle(fontSize: 15),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.info_outline,
                            color: Color(0xFF000052),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "Rs 200",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Grand Total",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "Rs 579.51",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black54,
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Order Details",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    alignment: Alignment.topLeft,
                    height: 3,
                    width: 50,
                    color: const Color(0xFF000052),
                  ),
                ),
                const SizedBox(height: 15),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "Order ID:",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "22-23/122",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "PAYMENT STATUS",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "Pay to Dispatch (No Cash Payments Allowed)",
                        style: TextStyle(fontSize: 13, color: Colors.red),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "ORDER DATE:",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "January 27, 2023, 02:03 PM",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "PICKUP DATE:",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "February 02, 2023",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "PICKUP TIME:",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "01:00 AM - 02:00 AM",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "DELIVERY DATE:",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "February 10, 2023",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "DELIVERY OPTION:",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "Regular delivery in 7 Working Day",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 150,
          width: width,
          child: Column(
            children: [
              Container(
                height: 50,
                width: width,
                child: RaisedButton(
                  elevation: 0,
                  color: const Color(0xFF000052),
                  shape: const RoundedRectangleBorder(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Paymentmethod(),
                      ),
                    );
                  },
                  child: const Text(
                    "Pay Now",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: width,
                child: TextButton(
                  onPressed: () {
                    _cancelordersheet();
                  },
                  child: const Text(
                    "Cancel Order",
                    style: TextStyle(color: Color(0xFF000052), fontSize: 20),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: width,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SupportScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Support",
                    style: TextStyle(color: Color(0xFF000052), fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _cancelordersheet() async {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: MediaQuery.of(context).size.height / 3 + 44,
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 0, 10),
                                  child: const Text(
                                    "Cancel Order",
                                    style: TextStyle(
                                        fontSize: 18.5,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 0, 10),
                                  child: const Text(
                                    "(Order Id: 22-23/207)",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                CupertinoIcons.clear_circled_solid,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                          color: CupertinoColors.systemGrey6,
                        ),
                        Container(
                          // color: Colors.red,
                          padding: const EdgeInsets.fromLTRB(8, 10, 0, 0),
                          height: statusData.length * 50,
                          child: ListView.builder(
                              itemCount: statusData.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      print("tap");
                                      statusitem =
                                          statusData[index]["name"].toString();
                                      statusid = statusData[index]["id"] as int;
                                      print(statusitem);
                                    });
                                  },
                                  child: Container(
                                    height: 30,
                                    child: Row(
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: (statusitem ==
                                                  statusData[index]["name"]
                                                      .toString())
                                              ? const Icon(
                                                  Icons.radio_button_on,
                                                  size: 18,
                                                  color: Color(0xFF000052),
                                                )
                                              : const Icon(
                                                  Icons.radio_button_off,
                                                  size: 18,
                                                  color: Color(0xFF000052),
                                                ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          statusData[index]["name"] ?? "",
                                          style: const TextStyle(
                                            fontSize: 18.5,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                    Container(
                      //alignment: Alignment.bottomCenter,
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        elevation: 0,
                        color: const Color(0xFF000052),
                        shape: const RoundedRectangleBorder(),
                        onPressed: () {},
                        child: const Text(
                          "Cancel Order",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
