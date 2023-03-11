import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safaidaar_customer/Api/Api_Url.dart';
import 'package:safaidaar_customer/Deliverydetail_CartScreen.dart';
import 'package:http/http.dart' as http;
import 'Add_Address_Screen.dart';
import 'Cart Details_Screen.dart';

List<String> selecttime = <String>[
  '10:00 AM to 11:00 AM',
  '01:00 AM to 02:00 AM',
];

class SchedulePickupScreen extends StatefulWidget {
  const SchedulePickupScreen({Key? key}) : super(key: key);

  @override
  State<SchedulePickupScreen> createState() => _SchedulePickupScreenState();
}

class _SchedulePickupScreenState extends State<SchedulePickupScreen> {
  bool isReload = false;
  List<dynamic> selectdate = <String>[
    'February 01, 2023',
    'February 02, 2023',
    'February 03, 2023',
    'February 04, 2023',
    'February 05, 2023',
    'February 06, 2023',
    'February 07, 2023',
    'February 08, 2023',
    'February 09, 2023',
    'February 10, 2023',
  ];

  // String dropdownValue = selectdate.first;
  String? dropdownValue;
  String dropdownValuedata = "";
  String? dropdownValuetime;
  String dropdownValuetimeselect = "";

  String deliveryway = '1';
  List<dynamic> deliveryData = [
    // {"name": "Superfast Delivery in 1 Working Day", "id": 1},
    // {"name": "Express Delivery in 1 Working Day", "id": 2},
    // {"name": "Regular Delivery in 1 Working Day", "id": 3},
  ];

  int deliverywayid = 1;

  TextEditingController searchcontroller = TextEditingController();

  void _settingModelBottomSheet(context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext bc) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.only(left: 15, right: 10),
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
                        child: const Text(
                          "Select a Location",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
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
                    height: 50,
                    child: Card(
                      elevation: 2,
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
                                      builder: (context) => AddaddressScreen(),
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
                                child: const Text(
                                  "User location",
                                  style: TextStyle(
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
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    thickness: 1,
                    color: CupertinoColors.systemGrey3,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            // _searchdialogbox(context);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => AddaddressScreen(),
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
                                builder: (context) => AddaddressScreen(),
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
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    // Getdeliveryoptions_ApiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Sizee = MediaQuery.of(context).size;
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
              "Schedule PickUp",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
        body: (isReload == false)
            ? SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Container(
                  padding: const EdgeInsets.only(left: 6, right: 6),
                  height: Sizee.height - 100,
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        width: Sizee.width,
                        child: Card(
                          elevation: 15,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 15,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 20,
                                      child: const Text(
                                        "DELIVERS TO",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        _settingModelBottomSheet(context);
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 15, bottom: 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // width: 15,
                                          // height: 15,
                                          height: 40,
                                          child: Image.asset(
                                            "assets/Location.png",
                                            // height: 15,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          "0.05 KM",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF000052),
                                            fontSize: 17,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 25,
                                          child: const Text(
                                            "Office",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              color: Color(0xFF000052),
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          // color: Colors.red,
                                          height: 90,
                                          width: Sizee.width - 130,
                                          child: const Text(
                                            "4th Floor, Sunrise Avenue, Stadium - Commerce Six Road, Opp: Saraspur Nagrik Bank, Navrangpura, Ahmedabad, Gujarat 380009",
                                            maxLines: 5,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
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
                      const SizedBox(
                        height: 20,
                      ),
                      // Container(
                      //   height: 110,
                      //   width: Sizee.width,
                      //   child:
                      Card(
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              height: 30,
                              padding: const EdgeInsets.only(left: 15, top: 8),
                              child: const Text(
                                "PICKUP DATE & TIME",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              padding: const EdgeInsets.only(
                                  left: 15, right: 20, bottom: 10, top: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      value: dropdownValue,
                                      offset: const Offset(0, 20),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      hint: const Text(
                                        "Select Pickup Date",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      icon: const SizedBox.shrink(),
                                      onChanged: (String? value) {
                                        // This is called when the user selects an item.
                                        setState(() {
                                          dropdownValue = value!;
                                          dropdownValuedata = value;
                                        });
                                        print(dropdownValuedata);
                                      },
                                      items: selectdate
                                          .map<DropdownMenuItem<String>>(
                                              (dynamic value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.calendar_view_month,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                            dropdownValuedata == ""
                                ? const SizedBox()
                                : Container(
                                    width: Sizee.width,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 20, bottom: 10),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2<String>(
                                        value: dropdownValuetime,
                                        offset: const Offset(0, 10),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        hint: const Text(
                                          "Select Pickup Time Slot",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black,
                                        ),
                                        onChanged: (String? value) {
                                          // This is called when the user selects an item.
                                          setState(() {
                                            dropdownValuetime = value!;
                                            dropdownValuetimeselect = value;
                                          });
                                          print(dropdownValuetimeselect);
                                        },
                                        items: selecttime
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 175,
                        width: Sizee.width,
                        child: Card(
                          elevation: 15,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 20),
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  height: 20,
                                  child: const Text(
                                    "DELIVERY OPTIONS",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                // color: Colors.red,
                                padding: const EdgeInsets.fromLTRB(8, 10, 0, 0),
                                height: deliveryData.length * 38,
                                child: ListView.builder(
                                    itemCount: deliveryData.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            print("tap");
                                            // deliveryway = deliveryData[index]
                                            //         ["delivery_option_label"]
                                            //     .toString();
                                            deliveryway = deliveryData[index]
                                                    ["name"]
                                                .toString();
                                            deliverywayid = deliveryData[index]
                                                ["id"] as int;
                                            print(deliveryway);
                                          });
                                        },
                                        child: Container(
                                          // color: Colors.red,
                                          height: 30,
                                          child: Row(
                                            // crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                child: (deliveryway ==
                                                        deliveryData[index]
                                                                ["name"]
                                                            .toString())
                                                    ? const Icon(
                                                        Icons.radio_button_on,
                                                        size: 17,
                                                        color:
                                                            Color(0xFF000052),
                                                      )
                                                    : const Icon(
                                                        Icons.radio_button_off,
                                                        size: 17,
                                                        color: Colors.black,
                                                      ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                deliveryData[index]["name"] ??
                                                    "",
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
        bottomNavigationBar: SizedBox(
          height: 50,
          width: Sizee.width,
          child: RaisedButton(
            color: const Color(0xFF000052),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DeliverdetailCartScreen(
                    dropdownValuedata: dropdownValuedata,
                    dropdownValuetimeselect: dropdownValuetimeselect,
                    deliveryway: deliveryway,
                  ),
                ),
              );
            },
            child: const Text(
              "Continue",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Getdeliveryoptions_ApiCall() async {
    setState(() {
      isReload = true;
    });
    try {
      print(Getdeliveryoption_Api);
      var response = await http.get(Uri.parse(Getdeliveryoption_Api));

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        print(decode);
        if (decode["success"] == true) {
          setState(() {
            deliveryData.clear();
            deliveryData = decode["data"];
            deliveryway = deliveryData[0]["delivery_option_label"];
          });
        } else {}
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
      print("Exception in getdeliveryoption =>" + e.toString());
      throw e;
    }
  }
}
