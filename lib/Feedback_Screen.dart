import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:in_app_review/in_app_review.dart';

class feedbackScreen extends StatefulWidget {
  const feedbackScreen({Key? key}) : super(key: key);

  @override
  State<feedbackScreen> createState() => _feedbackScreenState();
}

class _feedbackScreenState extends State<feedbackScreen> {
  bool isReload = true;
  final GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController Fullname = TextEditingController();
  TextEditingController MobileNumber = TextEditingController();
  String isvalidMobile = "";
  String strMobilevalidator = "";

  TextEditingController UploadImage = TextEditingController();
  String photo = "";
  File? imgFile = null;
  final imgPicker = ImagePicker();

  Future _pickProfileImage(ImageSource source) async {
    final imageLogo = await ImagePicker().getImage(
        source: source, imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    setState(() {
      imgFile = File(imageLogo!.path);
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(
                      Icons.photo_library,
                      color: Colors.black,
                    ),
                    title: const Text('Photo Library',
                        style: TextStyle(
                          color: Colors.black,
                        )),
                    onTap: () {
                      _pickProfileImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(
                    Icons.photo_camera,
                    color: Colors.black,
                  ),
                  title: const Text('Camera',
                      style: TextStyle(
                        color: Colors.black,
                      )),
                  onTap: () {
                    _pickProfileImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  TextEditingController YourFeedback = TextEditingController();

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
          title: const Text(
            "Feedback",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              height: Sizee.height,
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    child: const Text(
                      "Let us know your feedback, queries or issue regarding order and other things",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(color: Colors.black87, fontSize: 15),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(top: 20),
                    child: const Text(
                      "Full NAME",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: TextFormField(
                      controller: Fullname,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        hintText: 'Full Name',
                        // label: Text(
                        //   "Enter your Name",
                        //   style: TextStyle(
                        //     color: Colors.grey,
                        //     fontSize: 17,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                        // labelText: "Enter your Mobile Number",
                        // labelStyle: TextStyle(
                        //   color: Colors.grey,
                        //   fontWeight: FontWeight.bold,
                        //   fontSize: 15,
                        // ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter full name';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    // padding: const EdgeInsets.only(left: 5, top: 15),
                    child: const Text(
                      "MOBILE NUMBER",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: TextFormField(
                      controller: MobileNumber,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        counterText: "",
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        hintText: 'Enter Your Mobile Number',
                        // label: Text(
                        //   "Enter your Name",
                        //   style: TextStyle(
                        //     color: Colors.grey,
                        //     fontSize: 17,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                        // labelText: "Enter your Mobile Number",
                        // labelStyle: TextStyle(
                        //   color: Colors.grey,
                        //   fontWeight: FontWeight.bold,
                        //   fontSize: 15,
                        // ),
                      ),
                      validator: (text) {
                        if (text == null || text == "") {
                          return 'Please enter Mobile Number ';
                        } else if (text.length != 10) {
                          setState(() {
                            isvalidMobile = false as String;
                            strMobilevalidator = '';
                          });
                          return "Mobile Number must be of 10 digit";
                        } else {
                          setState(() {
                            isvalidMobile = true as String;
                            strMobilevalidator = '';
                          });
                          return null;
                        }
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    // padding: const EdgeInsets.only(top: 20),
                    child: const Text(
                      "UPLOAD IMAGE",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  imgFile == null
                      ? Container(
                          padding: const EdgeInsets.only(
                            bottom: 20,
                          ),
                          child: TextFormField(
                            onTap: () {
                              _showPicker(context);
                            },
                            controller: UploadImage,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            keyboardType: TextInputType.none,
                            readOnly: true,
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              hintText: 'Choose File',
                              // label: Text(
                              //   "Enter your Name",
                              //   style: TextStyle(
                              //     color: Colors.grey,
                              //     fontSize: 17,
                              //     fontWeight: FontWeight.w500,
                              //   ),
                              // ),
                              // labelText: "Enter your Mobile Number",
                              // labelStyle: TextStyle(
                              //   color: Colors.grey,
                              //   fontWeight: FontWeight.bold,
                              //   fontSize: 15,
                              // ),
                            ),
                            // validator: (text) {
                            //   if (text == null || text == "") {
                            //     return 'Please enter Mobile Number ';
                            //   } else if (text.length != 10) {
                            //     setState(() {
                            //       isvalidMobile = false as String;
                            //       strMobilevalidator = '';
                            //     });
                            //     return "Mobile Number must be of 10 digit";
                            //   } else {
                            //     setState(() {
                            //       isvalidMobile = true as String;
                            //       strMobilevalidator = '';
                            //     });
                            //     return null;
                            //   }
                            // },
                          ),
                        )
                      : Container(
                          height: 180,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                height: 180,
                                left: 0,
                                //(MediaQuery.of(context).size.width/2) -70,
                                child: ClipRRect(
                                  //borderRadius: BorderRadius.circular(85),
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        bottom: 20, top: 20, left: 10),
                                    alignment: Alignment.topLeft,
                                    height: 180,
                                    child: Image.file(
                                      imgFile!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 95,
                                child: Container(
                                  height: 24,
                                  width: 24,
                                  decoration: const BoxDecoration(
                                    //color: Color(0xFF000052),
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        // imageCache.clear();
                                        // print("remove $imgFile");
                                        imgFile = null;
                                      });
                                    },
                                    icon: const Icon(
                                      CupertinoIcons.clear_circled_solid,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  Container(
                    alignment: Alignment.topLeft,
                    //padding: const EdgeInsets.only(top: 20),
                    child: const Text(
                      "YOUR FEEDBACK",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: TextFormField(
                      controller: Fullname,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        hintText: 'Enter Your Message',
                        // label: Text(
                        //   "Enter your Name",
                        //   style: TextStyle(
                        //     color: Colors.grey,
                        //     fontSize: 17,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                        // labelText: "Enter your Mobile Number",
                        // labelStyle: TextStyle(
                        //   color: Colors.grey,
                        //   fontWeight: FontWeight.bold,
                        //   fontSize: 15,
                        // ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your feedback';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          width: Sizee.width,
          child: RaisedButton(
            color: const Color(0xFF000052),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pop(context);
              }
            },
            child: const Text(
              "Submit",
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
}
