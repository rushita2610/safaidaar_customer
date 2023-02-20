// // ignore_for_file: file_names
//
// import 'package:flutter/material.dart';
//
// class AboutUsScreen extends StatefulWidget {
//   const AboutUsScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AboutUsScreen> createState() => _AboutUsScreenState();
// }
//
// class _AboutUsScreenState extends State<AboutUsScreen> {
//   bool? isReload;
//
//   @override
//   Widget build(BuildContext context) {
//     final Sizee = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.white,
//           leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(
//               Icons.arrow_back_ios,
//               color: Colors.black,
//             ),
//           ),
//           title: const Text(
//             "About Us",
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 22,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Container(
//             padding: const EdgeInsets.all(20),
//             height: Sizee.height,
//             child: Column(
//               children: [],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
//
// class AboutUsScreen extends StatefulWidget {
//   AboutUsScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AboutUsScreen> createState() => _AboutUsScreenState();
// }
//
// class _AboutUsScreenState extends State<AboutUsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final Sizee = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.white,
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back_ios, color: Colors.black),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           titleSpacing: 5.0,
//           title: Transform(
//             // you can forcefully translate values left side using Transform
//             transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
//             child: const Text(
//               "Privacy Policy",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.only(left: 15, right: 15),
//             width: Sizee.width,
//             height: Sizee.height,
//             child: Column(
//               children: [
//                 HtmlWidget(
//                   // the first parameter (`html`) is required
//                   '''
//   <h3>Privacy</h3>
//   <p>
//     A paragraph with <strong>strong</strong>, <em>emphasized</em>
//     and <span style="color: red">colored</span> text.
//     Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
//   </p>
//   <p>
//   A paragraph with <strong>strong</strong>, <em>emphasized</em>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been  since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the Lorem.
//
//   </p>
//     <p>
//     A paragraph with <strong>strong</strong>, <em>emphasized</em>
//     and <span style="color: red">colored</span> text.
//     Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
//   </p>
//   <!-- anything goes here -->
//   ''',
//                 ),
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
//
// class Privacy extends StatefulWidget {
//   const Privacy({Key? key}) : super(key: key);
//
//   @override
//   State<Privacy> createState() => _PrivacyState();
// }
//
// class _PrivacyState extends State<Privacy> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(child: Scaffold(
//       appBar: AppBar(
//         flexibleSpace: Image(
//           image: AssetImage('assets/img_2.png'),
//           fit: BoxFit.fill,
//         ),
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios, color: Colors.black),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//
//         titleSpacing: 0.0,
//         title: Transform(
//           // you can forcefully translate values left side using Transform
//           transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
//           child: Text(
//             "Privacy Policy",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         //centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.all(10),
//           child: Column(
//
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Lorem Ipsum is simply dummy text of the printing and",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
//                   Text("Lorem Ipsum is simply dummy text of the printing tyIt has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
//                 ],
//               ),
//               SizedBox(height: 20,),
//               Container(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Lorem Ipsum is simply dummy text of the printing and",style: TextStyle(fontWeight: FontWeight.bold),),
//                     Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy tof tyIt has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20,),
//               Container(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Lorem Ipsum is simply dummy text of the printing and",style: TextStyle(fontWeight: FontWeight.bold),),
//                     Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy tof tyIt has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20,),
//               Container(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Lorem Ipsum is simply dummy text of the printing and",style: TextStyle(fontWeight: FontWeight.bold),),
//                     Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy tof tyIt has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
//
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:http/http.dart' as http;
import 'package:safaidaar_customer/Api/Api_Url.dart';

class AboutUsScreen extends StatefulWidget {
  // const PrivacyPolicyScreen({Key? key}) : super(key: key);
  String strURL;

  AboutUsScreen({
    Key? key,
    required this.strURL,
  }) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  bool isReload = false;
  var data;
  String strtitle = "";
  String strPageContent = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  }

  String strhtml =
  """<!DOCTYPE html><html><head><title>Page Title</title></head><body><strong style="margin: 0px; padding: 0px; color: rgb(0, 0, 0); font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 14px; text-align: justify;">Lorem Ipsum</strong><span style="color: rgb(0, 0, 0); font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 14px; text-align: justify;">&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</span>}</body></html>""";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            titleSpacing: 0.0,
            title: Transform(
              // you can forcefully translate values left side using Transform
              transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
              child: Text(
                strtitle,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            //centerTitle: true,
          ),
          body: isReload
              ? Center(
            child: CircularProgressIndicator(color: Color(0xFF000052),),
          )
              : SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                shrinkWrap: true,
                padding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                children: [
                  HtmlWidget(
                    strPageContent,
                  ),
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> setData() async {
    setState(() {
      isReload = true;
    });
    try {
      var response = await http.get(
        Uri.parse(Pageblock_Api + widget.strURL),
      );
      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        setState(() {
          data = decode;
          print(decode);
          strtitle = decode["data"][0]["page_title"].toString();
          strPageContent = decode["data"][0]["page_content"].toString();
          print("page detail === $strtitle === $strPageContent");
          isReload = false;
        });
      } else {
        setState(() {
          isReload = false;
        });
        print("Error");
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


