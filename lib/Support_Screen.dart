import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  bool isReload = true;

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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    print(width);
    double height = MediaQuery.of(context).size.height;
    print(height);
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
            "Support Screen",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  height: 25,
                  child: const Text(
                    "ORDER ID:22-23/207",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Customer comment",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 13, left: 0, right: 5, bottom: 15),
                  child: TextFormField(
                    //controller: Customername,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    // maxLength: 10,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding:
                          const EdgeInsets.only(top: 60, bottom: 60, left: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: CupertinoColors.systemGrey6),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: CupertinoColors.systemGrey6),
                      ),
                      // errorBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(color: Colors.red),
                      // ),
                      hintText: 'comment',
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    // validator: (text) {
                    //   if (text == null || text == "") {
                    //     return 'Please enter customer name ';
                    //   }
                    //   return null;
                    // },
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "UPLOAD PAN DOCUMENT",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                imgFile == null
                    ? InkWell(
                        onTap: () {
                          _showPicker(context);
                        },
                        child: Container(
                          height: 45,
                          width: width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: CupertinoColors.systemGrey4)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  _showPicker(context);
                                },
                                icon: const Icon(
                                  Icons.cloud_upload,
                                  color: Colors.black54,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  _showPicker(context);
                                },
                                child: const Text(
                                  "Upload your document",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        height: 180,
                        child: ClipRRect(
                          //borderRadius: BorderRadius.circular(85),
                          child: Container(
                            padding: const EdgeInsets.only(
                                bottom: 20, top: 20, left: 5),
                            alignment: Alignment.topLeft,
                            height: 180,
                            child: Image.file(
                              imgFile!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 55,
                      width: width * 0.4,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: const Color(0xFF000052),
                        onPressed: () {},
                        child: const Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 55,
                      width: width * 0.4,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: const Color(0xFF000052),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
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
      ),
    );
  }
}
