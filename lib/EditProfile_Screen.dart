// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Api/Api_Url.dart';
import 'Registration_Screen.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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

//  String bday = "yyyy-MM-dd";

  //text editing controller for text field
  bool show_hide = false;

  bool isobscure = false;

  var userStatus = 0;

  String isvalidMobile = "";
  String strMobilevalidator = "";

  String statusitem = '1';
  List<dynamic> statusData = [
    {"name": "Female", "id": "0"},
    {"name": "Male", "id": "1"},
    {"name": "Others", "id": "2"},
  ];
  String statusid = "0";

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
  String photo = "";

  @override
  void initState() {
    // DOBdateinput.text = "";
    // Annidateinput.text = ""; //set the initial value of text field
    //GetCustomerProfile_APIcall();
    // GenderAPIcall();
    GetProfilAPIcall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Sizee = MediaQuery.of(context).size;
    return Scaffold(
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
          "Edit Profile",
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
                  height: Sizee.height * 1.07,
                  width: Sizee.width,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        height: 161,
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
                                  _getFromGallery(ImageSource.gallery, Type);
                                },
                                child: imageFile == null
                                    ? (photo == "" || photo == null)
                                        ? const CircleAvatar(
                                            backgroundImage: AssetImage(
                                                "assets/user_placeholder.png"),
                                            radius: 55,
                                          )
                                        : CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(photo.trim()),
                                            radius: 55,
                                          )
                                    : CircleAvatar(
                                        backgroundImage: FileImage(imageFile!),
                                        radius: 55,
                                      ),
                              ),
                            ),
                            Positioned(
                              top: Sizee.height / 8 + 10,
                              left: 110,
                              child: Container(
                                height: 22,
                                width: 22,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF000052),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Positioned(
                              top: Sizee.height / 8 + 5,
                              left: 98,
                              child: IconButton(
                                alignment: Alignment.topCenter,
                                onPressed: () {
                                  _getFromGallery(ImageSource.gallery, Type);
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  size: 15.5,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          top: 8.5,
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
                            items: list
                                .map<DropdownMenuItem<String>>((dynamic value) {
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
                            counterText: "",
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
                            } else if (!value.contains("@") ||
                                !value.contains(".")) {
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
                            DOBdateinput.text = "";
                            DateTime? pickedDate = await showDatePicker(
                                locale: const Locale('en', 'IN'),
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
                                  pickedDate); //pickedDate output format => 2021-03-10
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(formattedDate);
                              setState(() {
                                DOBdateinput.text = formattedDate;
                                String datePattern = "yyyy-MM-dd";
                                DateTime birthDate = DateFormat(datePattern)
                                    .parse(DOBdateinput.text);
                                DateTime today = DateTime.now();
                                print(today);
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
                            hintText: 'Enter your birth date',
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
                                statusid = statusData[index]["id"].toString();
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
                                    child: (statusid ==
                                            statusData[index]["id"].toString())
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
                            Annidateinput.text = "";
                            DateTime? pickedDate = await showDatePicker(
                              // locale: const Locale('en', 'IN'),
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
                                        onSurface: Colors.black, // <-- SEE HERE
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          primary: const Color(
                                              0xFF000052), // button text color
                                        ),
                                      ),
                                    ),
                                    child: child!);
                              },
                            ); //DateTime(2023));
                            if (pickedDate != null) {
                              print(
                                  pickedDate); //pickedDate output format => 2021-03-10
                              String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(formattedDate);
                              setState(() {
                                Annidateinput.text = formattedDate;
                                String datePattern = "yyyy-MM-dd";
                                DateTime annidate = DateFormat(datePattern)
                                    .parse(Annidateinput.text);
                                DateTime today = DateTime.now();
                                print(today);
                                int yearDiff = today.year - annidate.year;
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
              // Navigator.pop(context);
              UpdateProfilAPIcall();
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
    );
  }

  GetProfilAPIcall() async {
    setState(() {
      isReload = true;
    });
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token") ?? "";
      var user_id = prefs.getString("id") ?? "";

      final Header = {
        "Authorization": "Bearer ${token.toString()}",
      };

      //   var response = await http.post(Uri.parse(login), body: body);
      var response = await http.get(
        Uri.parse(GetCustomerprofile_Api + user_id),
        headers: Header,
      );

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        print(decode);
        if (decode["success"] == true) {
          setState(() {
            prefs.setString(
                "customer_name", decode["data"][0]["customer_name"].toString());
            // prefs.setString("customer_image",
            //     decode["data"][0]["customer_image"].toString());
            Customername.text = decode["data"][0]["customer_name"].toString();
            Email.text = decode["data"][0]["email"].toString();
            var userPhoto = decode["data"][0]["customer_image"];
            dropdownValue = decode["data"][0]["preferred_language"].toString();
            DOBdateinput.text = decode["data"][0]["dob"].toString() == "null"
                ? ""
                : decode["data"][0]["dob"].toString();
            Annidateinput.text =
                decode["data"][0]["anniversary_date"].toString() == "null"
                    ? ""
                    : decode["data"][0]["anniversary_date"].toString();
            statusid = decode["data"][0]["gender"].toString();
            print("decode: $decode");

            if (userPhoto != "" || userPhoto != null) {
              photo = userPhoto;
              print("photo $photo");
            } else {
              print("");
            }

            userStatus = decode["data"][0]["status"];
            print(userStatus);
          });
        } else {
          print(decode);
          print(json.decode(response.body)['errors']);
          String errorMsg = json.decode(response.body)["message"].toString();
          print(errorMsg);
          if (json.decode(response.body)['errors'] != null) {
            Map errorMap = json.decode(response.body)["errors"].first;
            for (String k in errorMap.keys) {
              print(errorMap[k]);
              errorMsg = errorMap[k][0] ??
                  json.decode(response.body)["message"].toString();
              break;
            }
          }
        }
        setState(() {
          isReload = false;
        });
      } else {
        print("Error" + response.statusCode.toString());
        print("Error" + response.body.toString());

        setState(() {
          isReload = false;
        });
      }
    } catch (e) {
      setState(() {
        isReload = false;
      });
      print("Exception in Today Attendance=>" + e.toString());
      throw e;
    }
  }

  UpdateProfilAPIcall() async {
    setState(() {
      isReload = true;
    });
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token") ?? "";
      var user_id = prefs.getString("id") ?? "";

      final Header = {
        "Authorization": "Bearer ${token.toString()}",
      };

      print(Header);

      var request = http.MultipartRequest(
          'POST',
          // Uri.parse(
          //     'https://safaidaar.mydemoapp.us/api/v1/vendor/vendor-signup'));
          Uri.parse(Updatecustomerprofile_Api));
      Map<String, String> headers = {
        "Authorization": "Bearer ${token.toString()}",
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      request.headers.addAll(headers);
      Map<String, String> sendData = {
        "preferred_language": dropdownValue.toString(),
        "customer_name": Customername.text.trim(),
        "email": Email.text.trim(),
        "mobile": "+91 ${MobileNumber.text.trim()}",
        "gender": statusid,
        "dob": DOBdateinput.text.toString(),
        "anniversary_date": Annidateinput.text.toString(),
        "referral_mobile": "",
        //refferalcontact.text.length > 0 ? "+91 ${refferalcontact.text.trim()}": '',
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

      print(response.body);

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        if (decode["success"] == true) {
          GetProfilAPIcall();
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
                  bottom: MediaQuery.of(context).size.height / 1 - 160,
                  right: 20,
                  left: 20),
            ),
          );
        } else {
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
        }
      } else {
        setState(() {
          isReload = false;
        });
        print("Error " + response.statusCode.toString());
        // print("Error" + response.body.toString());
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
