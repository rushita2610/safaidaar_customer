import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safaidaar_customer/Edit_Address_Screen.dart';

import 'Add_Address_Screen.dart';

class AddressScreen extends StatefulWidget {
  String Address = "";

  AddressScreen({Key? key, required this.Address}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  bool? isReload;

  List<dynamic> addresslist = [
    {
      'addrstype': 'Other',
    },
    {
      'addrstype': 'Office',
    },
  ];

  String strPlaceId = '';
  String strLatt = '';
  String strLong = '';

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
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(2),
            height: height,
            child: Column(
              children: [
                Container(
                  height: addresslist.length * 200,
                  width: width,
                  child: ListView.builder(
                      itemCount: addresslist.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext cntx, int index) {
                        return Container(
                          // color: Colors.red,
                          height: height * 0.2,
                          width: width,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 20, right: 15, bottom: 5),
                              child: Row(
                                children: [
                                  Container(
                                    width: 30,
                                    child: const Icon(
                                      CupertinoIcons.location_solid,
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 23,
                                              child: Text(
                                                addresslist[index]['addrstype'],
                                                style: const TextStyle(
                                                  color: Color(0xFF000052),
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
                                                    child: IconButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                const EditaddressScreen(),
                                                          ),
                                                        );
                                                      },
                                                      icon: const Icon(
                                                        Icons
                                                            .edit_location_alt_rounded,
                                                        color:
                                                            Color(0xFF000052),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 30,
                                                    child: IconButton(
                                                      onPressed: () {
                                                        _confirmdialogbox();
                                                      },
                                                      icon: const Icon(
                                                        Icons.delete,
                                                        color:
                                                            Color(0xFF000052),
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
                                        height: height * 0.0875,
                                        // color: Colors.red,
                                        width: width * 0.8,
                                        child: Text(
                                          widget.Address,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmdialogbox() async {
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
                      onPressed: () {},
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
