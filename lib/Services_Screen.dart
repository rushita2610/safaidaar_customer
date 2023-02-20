import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Api/Api_Url.dart';
import 'Services_detail_Screen.dart';

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

class Servicescreen extends StatefulWidget {
  const Servicescreen({Key? key}) : super(key: key);

  @override
  State<Servicescreen> createState() => _ServicescreenState();
}

class _ServicescreenState extends State<Servicescreen> {
  bool? isReload;

  @override
  void initState() {
    // TODO: implement initState
    TopServices_ApiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    //final Sizee = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: true,
          title: Transform(
            transform: Matrix4.translationValues(-55, 0.0, 0.0),
            child: const Text(
              "Services",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            height: height,
            //   color: Colors.red,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                (topserviceslist.length > 0)
                    ? Container(
                        padding: const EdgeInsets.only(top: 15),
                        height: height * 0.5,
                        width: width,
                        // color: Colors.green,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 35,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.6,
                          ),
                          itemCount: topserviceslist.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Servicedetail(),
                                  ),
                                );
                              },
                              child: Container(
                                // color: Colors.red,
                                padding: const EdgeInsets.only(
                                  bottom: 5,
                                ),
                                width: width * 0.3,
                                // height:height * 0.1,
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(
                                          70),
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
                                      height: 15,
                                    ),
                                    Container(
                                      height: 35,
                                      child: Text(
                                        topserviceslist[index]['name'],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
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
      ),
    );
  }

  TopServices_ApiCall() async {
    setState(() {
      isReload = true;
    });
    try {
      final body = {
        "all": true,
      };
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

}
