// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'EditProfile_Screen.dart';
//
// List<dynamic> menuassets = [
//   "assets/your-orders.png",
//   "assets/address-book.png",
//   "assets/notification.png",
//   "assets/about-us.png",
//   "assets/play.png",
//   "assets/T&C.png",
//   "assets/privacy.png",
//   "assets/T&C.png",
//   "assets/contact-us.png",
//   "assets/rating.png",
//   "assets/share.png",
//   "assets/chat.png",
//   "assets/log-out.png",
// ];
//
// List<dynamic> menuname = [
//   "Your Orders",
//   "Address Book",
//   "Notifications",
//   "About Us",
//   "Safaidaar Videos",
//   "Terms & Conditions",
//   "Privacy Policy",
//   "Cancellation & Refund Policy",
//   "Feedback",
//   "Rating & Review",
//   "Share App",
//   "Chat Help",
//   "Log Out",
// ];
//
// class drawerScreen extends StatefulWidget {
//   const drawerScreen({Key? key}) : super(key: key);
//
//   @override
//   State<drawerScreen> createState() => _drawerScreenState();
// }
//
// class _drawerScreenState extends State<drawerScreen> {
//   var scaffoldKey = GlobalKey<ScaffoldState>();
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       key: scaffoldKey,
//       drawer: Drawer(
//
//         child: ListView(
//           children: [
//             GestureDetector(
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => const EditProfile(),
//                   ),
//                 );
//               },
//               child: DrawerHeader(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Container(
//                       alignment: Alignment.center,
//                       height: 70,
//                       width: 70,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(50),
//                         child: Image.asset(
//                           "assets/user_placeholder.png",
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       alignment: Alignment.center,
//                       height: 17,
//                       child: const Text(
//                         "Rushita Ramani",
//                         textAlign: TextAlign.left,
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 17,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       alignment: Alignment.center,
//                       padding: const EdgeInsets.only(top: 5),
//                       //width: 60,
//                       child: const Text(
//                         "+91 1234567890",
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.w500,
//                           fontSize: 13,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       alignment: Alignment.center,
//                       height: 30,
//                       child: TextButton(
//                         onPressed: () {
//                           Navigator.of(context).push(
//                             MaterialPageRoute(
//                               builder: (context) => const EditProfile(),
//                             ),
//                           );
//                         },
//                         child: const Text(
//                           "Edit Profile",
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500,
//                             color: Color(0xFF000052),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               color: CupertinoColors.systemGrey6,
//               //  height: Sizee.height,
//               height: height,
//               // padding: const EdgeInsets.all(15),
//               child: Column(
//                 children: [
//                   const Divider(
//                     thickness: 1,
//                     color: Colors.black54,
//                   ),
//                   Container(
//                     padding: const EdgeInsets.only(left: 15, bottom: 20),
//                     height: menuassets.length * 53,
//                     child: ListView.builder(
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: menuassets.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Container(
//                           height: 50,
//                           // width: 200,
//                           child: InkWell(
//                             // onTap: () {
//                             //   if (menuname[index] == "Your Orders") {
//                             //     Navigator.of(context).push(
//                             //         MaterialPageRoute(builder: (context) {
//                             //           return const BottomNavigationScreen(3);
//                             //         }));
//                             //   } else if (menuname[index] == "Address Book") {
//                             //     Navigator.of(context).push(
//                             //         MaterialPageRoute(builder: (context) {
//                             //           return const AddressScreen();
//                             //         }));
//                             //   } else if (menuname[index] == "Notifications") {
//                             //     Navigator.of(context).push(
//                             //         MaterialPageRoute(builder: (context) {
//                             //           return const NotificationScreen();
//                             //         }));
//                             //   } else if (menuname[index] == "About Us") {
//                             //     Navigator.of(context).push(
//                             //         MaterialPageRoute(builder: (context) {
//                             //           return const AboutUsScreen();
//                             //         }));
//                             //   } else if (menuname[index] ==
//                             //       "Safaidaar Videos") {
//                             //     _launchUrl();
//                             //   } else if (menuname[index] ==
//                             //       "Terms & Conditions") {
//                             //     Navigator.of(context).push(
//                             //         MaterialPageRoute(builder: (context) {
//                             //           return const termsandconditions();
//                             //         }));
//                             //   } else if (menuname[index] ==
//                             //       "Privacy Policy") {
//                             //     Navigator.of(context).push(
//                             //         MaterialPageRoute(builder: (context) {
//                             //           return const privacypolicy();
//                             //         }));
//                             //   } else if (menuname[index] ==
//                             //       "Cancellation & Refund Policy") {
//                             //     Navigator.of(context).push(
//                             //         MaterialPageRoute(builder: (context) {
//                             //           return const canandrefund();
//                             //         }));
//                             //   } else if (menuname[index] == "Feedback") {
//                             //     Navigator.of(context).push(
//                             //       MaterialPageRoute(
//                             //         builder: (context) =>
//                             //         const feedbackScreen(),
//                             //       ),
//                             //     );
//                             //   } else if (menuname[index] ==
//                             //       "Rating & Review") {
//                             //     _openAppReview();
//                             //   } else if (menuname[index] == "Share App") {
//                             //     FlutterShare.share(
//                             //         title: 'Safaidaar Customer',
//                             //         text: 'Safaidaar Customer',
//                             //         linkUrl:
//                             //         'https://apps.apple.com/in/app/Safaidaar/id6444102906',
//                             //         chooserTitle: 'Safaidaar Customer');
//                             //   } else if (menuname[index] == "Chat Help") {
//                             //     Navigator.of(context).push(
//                             //       MaterialPageRoute(
//                             //         builder: (context) => const Chatscreen(),
//                             //       ),
//                             //     );
//                             //   } else if (menuname[index] == "Logout") {}
//                             // },
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   height: 22,
//                                   child: Image.asset(
//                                     menuassets[index],
//                                     // color: Colors.grey,
//                                     fit: BoxFit.fill,
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 13,
//                                 ),
//                                 Align(
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                     menuname[index],
//                                     style: const TextStyle(
//                                       fontSize: 15,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
