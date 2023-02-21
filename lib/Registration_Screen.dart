// ignore_for_file: non_constant_identifier_names, avoid_web_libraries_in_flutter, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:safaidaar_customer/Api/Api_Url.dart';
import 'package:safaidaar_customer/Login.dart';
import 'package:safaidaar_customer/Validation.dart';

List<dynamic> list = <String>['English', 'Hindi', 'Tamil', 'Telugu'];

class Regiatration extends StatefulWidget {
  const Regiatration({Key? key}) : super(key: key);

  @override
  State<Regiatration> createState() => _RegiatrationState();
}

class _RegiatrationState extends State<Regiatration> {
  bool? isReload;
  final pageController = PageController();
  bool isLastPage = false;
  final GlobalKey<FormState> _formKey = GlobalKey();

  String dropdownValue = list.first;

  TextEditingController Customername = TextEditingController();
  TextEditingController MobileNumber = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController DOBdateinput = TextEditingController();
  TextEditingController Annidateinput = TextEditingController();
  TextEditingController refferalcontact = TextEditingController();

  //text editing controller for text field
  bool show_hide = false;

  bool isobscure = false;

  String isvalidMobile = "";
  String strMobilevalidator = "";

  String statusitem = '1';
  List<dynamic> statusData = [
    {"name": "Female", "id": 1},
    {"name": "Male", "id": 2},
    {"name": "Others", "id": 3},
  ];

  _getFromGallery(ImageSource gallery, Type type) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        print(pickedFile.path);
        imageFile = File(pickedFile.path);
      });
    }
  }

  File? imageFile;

  @override
  void initState() {
    // DOBdateinput.text = "";
    // Annidateinput.text = "";//set the initial value of text field
    // Signup_APIcall();
    super.initState();
  }

  int statusid = 1;

  // String photo = "";
  // String photoGST = "";
  // File? imgFile;
  // File? imgFileGst;
  // final imgPicker = ImagePicker();
  // List<XFile> imageFileList = [];

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
              Icons.arrow_back_ios_new,
              size: 20,
              color: Colors.black,
            ),
          ),
          title: const Text(
            "Registration",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          // height: Sizee.height,
          child: Stack(
            children: [
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Container(
                    height: Sizee.height + 440,
                    width: Sizee.width,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        imageFile == null
                            ? Flexible(
                                child: Container(
                                  height: 170,
                                  width: 170,
                                  alignment: Alignment.center,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 0,
                                        height: 150,
                                        width: 150,
                                        left: 0,
                                        //(MediaQuery.of(context).size.width/2) -70,
                                        child: InkWell(
                                          onTap: () {
                                            _getFromGallery(
                                                ImageSource.gallery, Type);
                                          },
                                          child: Container(
                                            // height: 20,
                                            // width: 20,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey
                                                    .withOpacity(0.1)),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: Sizee.height / 7.5,
                                        left: 112,
                                        child: Container(
                                          height: 24,
                                          width: 24,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF000052),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: Sizee.height / 7.8,
                                        left: 100,
                                        child: IconButton(
                                          alignment: Alignment.topCenter,
                                          onPressed: () {
                                            _getFromGallery(
                                                ImageSource.gallery, Type);
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Flexible(
                                child: Container(
                                  height: 160,
                                  width: 160,
                                  alignment: Alignment.center,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 0,
                                        height: 150,
                                        width: 150,
                                        left: 0,
                                        //(MediaQuery.of(context).size.width/2) -70,
                                        child: InkWell(
                                          onTap: () {
                                            _getFromGallery(
                                                ImageSource.gallery, Type);
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(85),
                                            child: Image.file(
                                              imageFile!,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: Sizee.height / 7.5,
                                        left: 112,
                                        child: Container(
                                          height: 24,
                                          width: 24,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF000052),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: Sizee.height / 7.8,
                                        left: 100,
                                        child: IconButton(
                                          alignment: Alignment.topCenter,
                                          onPressed: () {
                                            _getFromGallery(
                                                ImageSource.gallery, Type);
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                        Container(
                          padding: const EdgeInsets.only(
                            top: 8,
                          ),
                          alignment: Alignment.topLeft,
                          child: const Text(
                            "PREFERRED LANGUAGE",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding:
                              const EdgeInsets.only(top: 8, left: 0, right: 10),
                          width: Sizee.width,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              value: dropdownValue,
                              icon: const Icon(Icons.arrow_drop_down),
                              // elevation: 16,
                              // underline: Container(
                              //   height: 1,
                              //   color: Colors.black,
                              // ),
                              offset: const Offset(0, 10),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  dropdownValue = value!;
                                });
                              },
                              items: list.map<DropdownMenuItem<String>>(
                                  (dynamic value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 0),
                          height: 1,
                          color: Colors.black,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(left: 5, top: 15),
                          child: const Text(
                            "CUSTOMER NAME",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 8, left: 0, right: 5, bottom: 15),
                          child: TextFormField(
                            controller: Customername,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            // maxLength: 10,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              hintText: 'Enter your customer name',
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
                                return 'Please enter customer name ';
                              } else if(!text.isValidname()) {
                                return 'Please enter valid customer name';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(
                            left: 5,
                          ),
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
                              top: 8, left: 0, right: 5, bottom: 15),
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
                              hintText: 'Enter your mobile number',
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
                              if (MobileNumber.text.trim().isEmpty) {
                                return 'Please enter mobile number';
                              } else if (MobileNumber.text.trim().length < 10) {
                                return 'Please enter 10 digit mobile number';
                              }
                              // if (text == null || text == "") {
                              //   return 'Please enter Mobile Number ';
                              // } else if (text.length != 10) {
                              //   setState(() {
                              //     isvalidMobile = false as String;
                              //     strMobilevalidator = '';
                              //   });
                              //   return "Mobile Number must be of 10 digit";
                              // } else {
                              //   setState(() {
                              //     isvalidMobile = true as String;
                              //     strMobilevalidator = '';
                              //   });
                              //   return null;
                              // }
                            },
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(
                            left: 5,
                          ),
                          child: const Text(
                            "EMAIL",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 8, left: 0, right: 5, bottom: 15),
                          child: TextFormField(
                            controller: Email,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            // maxLength: 10,
                            // keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              counterText: "",
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              hintText: 'Enter your email id',
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
                                return 'Please enter email id';
                              } else if (!value.isValidEmail()) {
                                return "Please enter valid email id";
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(left: 5),
                          child: const Text(
                            "BIRTHDAY",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 0, left: 0, right: 5, bottom: 15),
                          child: TextFormField(
                            readOnly: true,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            controller: DOBdateinput,
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
                                          colorScheme: const ColorScheme.light(
                                            primary: Color(0xFF000052),
                                            // <-- SEE HERE
                                            onPrimary: Colors.white,
                                            // <-- SEE HERE
                                            onSurface:
                                                Colors.black, // <-- SEE HERE
                                          ),
                                          textButtonTheme: TextButtonThemeData(
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
                                    DateFormat('dd MMM').format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                setState(() {
                                  DOBdateinput.text = formattedDate;
                                  String datePattern = "dd MMM";
                                  DateTime birthDate = DateFormat(datePattern)
                                      .parse(DOBdateinput.text);
                                  DateTime today = DateTime.now();
                                  int yearDiff = today.year - birthDate.year;
                                  print("year $yearDiff");
                                  //set output date to TextField value.
                                });
                              } else {}
                            },
                            // maxLength: 10,
                            // keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              counterText: "",
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              hintText: 'Enter your Birthday',
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
                          ),
                        ),
                        Container(
                          // color: Colors.red,
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(left: 5),
                          child: const Text(
                            "GENDER",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            // crossAxisSpacing: 72,
                            childAspectRatio: 1.5,
                            crossAxisCount: 3,
                          ),
                          shrinkWrap: true,
                          itemCount: statusData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  print("tap");
                                  statusitem = statusData[index].toString();
                                  statusid = statusData[index]["id"] as int;
                                  print(statusitem);
                                });
                              },
                              child: Container(
                                height: 30,
                                // color: Colors.red,
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: (statusitem ==
                                              statusData[index].toString())
                                          ? const Icon(
                                              Icons.radio_button_on,
                                              color: Colors.black,
                                            )
                                          : const Icon(
                                              Icons.radio_button_off,
                                              color: Colors.black,
                                            ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 3),
                                      child: Text(
                                        statusData[index]["name"] ?? "",
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(left: 5),
                          child: const Text(
                            "ANNIVERSARY DATE",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 0, left: 0, right: 5, bottom: 15),
                          child: TextFormField(
                            readOnly: true,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            controller: Annidateinput,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1800),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime.now(),
                                  builder: (context, child) {
                                    return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: const ColorScheme.light(
                                            primary: Color(0xFF000052),
                                            // <-- SEE HERE
                                            onPrimary: Colors.white,
                                            // <-- SEE HERE
                                            onSurface:
                                                Colors.black, // <-- SEE HERE
                                          ),
                                          textButtonTheme: TextButtonThemeData(
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
                                    DateFormat('dd MMM yy').format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                setState(() {
                                  Annidateinput.text = formattedDate;
                                  String datePattern = "dd MMM yy";
                                  DateTime annivsryDate =
                                      DateFormat(datePattern)
                                          .parse(Annidateinput.text);
                                  DateTime today = DateTime.now();
                                  int yearDiff = today.year - annivsryDate.year;
                                  print("year $yearDiff");
                                  //set output date to TextField value.
                                });
                              } else {}
                            },
                            // maxLength: 10,
                            // keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              counterText: "",
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              hintText: 'Enter your anniversary date',
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
                          ),
                        ),
                        CheckboxListTile(
                          side: const BorderSide(color: Color(0xFF000052)),
                          value: show_hide,
                          controlAffinity: ListTileControlAffinity.leading,
                          checkColor: Colors.white,
                          activeColor: const Color(0xFF000052),
                          title: const Text(
                            "Referred by",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          onChanged: (showhide) {
                            setState(() {
                              show_hide = showhide!;
                            });
                          },
                        ),
                        show_hide
                            ? Container(
                                padding: const EdgeInsets.only(
                                    top: 0, left: 0, right: 5, bottom: 15),
                                child: TextFormField(
                                  // readOnly: true,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  controller: refferalcontact,
                                  // maxLength: 10,
                                  // keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    counterText: "",
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    hintText:
                                        'Enter your referral contact number',
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
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 50,
          width: Sizee.width,
          child: RaisedButton(
            color: const Color(0xFF000052),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Signup_APIcall();
              }
            },
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
      ),
    );
  }

  Signup_APIcall() async {
    setState(() {
      isReload = true;
    });
    try {
      var request = http.MultipartRequest(
          'POST',
          // Uri.parse(
          //     'https://safaidaar.mydemoapp.us/api/v1/vendor/vendor-signup'));
          Uri.parse(Signup_Api));
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      request.headers.addAll(headers);
      Map<String, String> sendData = {
        "preferred_language": dropdownValue.toString(),
        "customer_name": Customername.text.trim(),
        "email": Email.text.trim(),
        "mobile": "+91 ${MobileNumber.text.trim()}",
        "gender": statusitem.toString(),
        "dob": DOBdateinput.text.trim(),
        "anniversary_date": Annidateinput.text.trim(),
        "referral_mobile": refferalcontact.text.length > 0 ? "+91 ${refferalcontact.text.trim()}": '',
      };

      request.fields.addAll(sendData);
      if (imageFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'customer_image', imageFile!.path));
      }
      // if (profileImageFile != null) {
      //   request.files.add(await http.MultipartFile.fromPath(
      //       'vendor_image', profileImageFile!.path));
      // }

      print("sendData ==> $sendData");

      http.StreamedResponse streamedResponse = await request.send();
      http.Response response = await http.Response.fromStream(streamedResponse);

      // final respStr = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        setState(() {
          isReload = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        );
      } else {
        print(json.decode(response.body)['errors']);
        String errorMsg = json.decode(response.body)["message"].toString();
        print(errorMsg);
        if (json.decode(response.body)['errors'] != null) {
          Map errorMap = json.decode(response.body)["errors"];
          for (String k in errorMap.keys) {
            print(errorMap[k]);
            errorMsg = errorMap[k][0] ??
                json.decode(response.body)["message"].toString();
            break;
          }
        }
        //json.decode(response.body)['errors'].toString()
        // WebResponseExtractor.showToast(json.decode(response.body)['errors'].toString());
        // setState(() {
        //   isReload = false;
        // });
        // final snackBar = SnackBar(
        //   content: Text(errorMsg),
        //   action: SnackBarAction(
        //     label: '',
        //     onPressed: () {},
        //   ),
        // );
        //
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                    errorMsg,
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
                bottom: MediaQuery.of(context).size.height / 1 - 170,
                right: 20,
                left: 20),
          ),
        );
      }
      setState(() {
        isReload = false;
      });
      // request.send().then((onValue) {
      //   print(onValue.statusCode);
      //
      //   if (onValue.statusCode == 200) {
      //
      //
      //
      //     //  getProfilAPIcall();
      //   } else {
      //     setState(() {
      //       isReload = false;
      //     });
      //   }
      //   print(onValue.toString());
      //   print(onValue.headers);
      //   print(onValue.contentLength);
      // });
    } catch (e) {
      setState(() {
        isReload = false;
      });
      print("Exception in Today Attendance=>" + e.toString());
      throw e;
    }
  }

}
