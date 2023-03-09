// ignore_for_file: deprecated_member_use, use_build_context_synchronously
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safaidaar_customer/Api/Api_Url.dart';
import 'package:safaidaar_customer/Edit_Address_Screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'Add_Address_Screen.dart';

class AddressScreen extends StatefulWidget {
  // String Address = "";

  AddressScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  bool isReload = false;

  List<dynamic> addresslist = [
    // {
    //   'addrstype': 'Other',
    // },
    // {
    //   'addrstype': 'Office',
    // },
  ];

  String strPlaceId = '';
  String strLatt = '';
  String strLong = '';

  @override
  void initState() {
    GetAddress_ApiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddaddressScreen(),
                  ),
                );
              },
              icon: const Icon(
                CupertinoIcons.add_circled,
                color: Colors.black,
              ),
            ),
          ],
          title: const Text(
            "Address",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: (isReload == false)
            ? SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(2),
                  // height: height,
                  child: Column(
                    children: [
                      addresslist.length > 0
                          ? Flexible(
                              flex: 0,
                              child: Container(
                                height: addresslist.length * 180,
                                width: width,
                                child: ListView.builder(
                                    itemCount: addresslist.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext cntx, int index) {
                                      return Container(
                                        // color: Colors.red,
                                        height: 180,
                                        width: width,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                top: 20,
                                                right: 15,
                                                bottom: 5),
                                            child: Row(
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  width: 30,
                                                  child: const Icon(
                                                    CupertinoIcons
                                                        .location_solid,
                                                    color: Color(0xFF000052),
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
                                                      height: 35,
                                                      width: width * 0.8,
                                                      //padding: EdgeInsets.only(top: 0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            height: 23,
                                                            child: Text(
                                                              addresslist[index]
                                                                      [
                                                                      'address_type_text']
                                                                  .toString(),
                                                              style:
                                                                  const TextStyle(
                                                                color: Color(
                                                                    0xFF000052),
                                                                fontSize: 16.5,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: width * 0.25,
                                                            // color: Colors.red,
                                                            child: Row(
                                                              // crossAxisAlignment:
                                                              //     CrossAxisAlignment.start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  width: 30,
                                                                  child:
                                                                      IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      addresslist[index]
                                                                              [
                                                                              "address_id"]
                                                                          .toString();
                                                                      addresslist[index]
                                                                              [
                                                                              "address"]
                                                                          .toString();
                                                                      addresslist[index]
                                                                              [
                                                                              "address_type"]
                                                                          .toString();
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              EditaddressScreen(
                                                                            addressid:
                                                                                addresslist[index]["address_id"].toString(),
                                                                            address:
                                                                                addresslist[index]["address"].toString(),
                                                                            addresstype:
                                                                                addresslist[index]["address_type"].toString(),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .edit_location_alt_rounded,
                                                                      color: Color(
                                                                          0xFF000052),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 30,
                                                                  child:
                                                                      IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      addresslist[index]
                                                                              [
                                                                              "address_id"]
                                                                          .toString();
                                                                      print(addresslist[index]
                                                                              [
                                                                              "address_id"]
                                                                          .toString());
                                                                      //_confirmdialogbox();
                                                                      _confirmdialogbox(
                                                                          Addressid:
                                                                              addresslist[index]["address_id"].toString());
                                                                    },
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .delete,
                                                                      color: Color(
                                                                          0xFF000052),
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
                                                      height: 15,
                                                    ),
                                                    Container(
                                                      height: height * 0.088,
                                                      // color: Colors.red,
                                                      width: width * 0.8,
                                                      child: Text(
                                                        addresslist[index]
                                                                ["address"]
                                                            .toString(),
                                                        maxLines: 5,
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
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
                                    child: Image.asset("assets/no_offer.png"),
                                  ),
                                ),
                                const Text(
                                  "No results Found.",
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
                              ],
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

  DeleteAddress_Apicall({required Addressid}) async {
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
      print(DeleteAddress_Api + "/${Addressid}");
      var response = await http.delete(
          Uri.parse(DeleteAddress_Api + "/${Addressid}"),
          headers: Header);

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        print(decode);
        if (decode["success"] = true) {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => AddressScreen(),
          //   ),
          // );
          Navigator.pop(context);
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
                      decode["message"].toString(),
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
      print("Exception in editaddressa =>" + e.toString());
    }
  }

  Future<void> _confirmdialogbox({required Addressid}) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => Container(
        height: 100,
        // width: MediaQuery.of(context).size.width,
        // width: MediaQuery.of(context).size.width - 40,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          title: Column(
            children: [
              const Text(
                "Are you sure want to delete address",
                style: TextStyle(
                  fontSize: 16,
                  // fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 3 - 35,
                    child: RaisedButton(
                      elevation: 0,
                      color: const Color(0xFF000052),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "No",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 3 - 35,
                    child: RaisedButton(
                      elevation: 0,
                      color: const Color(0xFF000052),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onPressed: () {
                        DeleteAddress_Apicall(Addressid: Addressid);
                      },
                      child: const Text(
                        "Yes",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
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
}
