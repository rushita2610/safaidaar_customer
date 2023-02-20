// ignore_for_file: non_constant_identifier_names, deprecated_member_use, file_names,

import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'Api/Api_Url.dart';

class AddaddressScreen extends StatefulWidget {
  static const DEFAULT_ZOOM = 14.4746;
  static const Currentlocation = LatLng(23.040158, 72.560379);

  double initZoom;
  LatLng initCoordinates;
  String Address = '';
  LatLng? value;

  AddaddressScreen(
      {Key? key,
      this.initZoom = DEFAULT_ZOOM,
      this.initCoordinates = Currentlocation})
      : super(key: key);

  @override
  State<AddaddressScreen> createState() => _AddaddressScreenState();
}

class _AddaddressScreenState extends State<AddaddressScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  TextEditingController Completeaddress = TextEditingController();
  TextEditingController Country = TextEditingController();
  TextEditingController City = TextEditingController();
  TextEditingController State = TextEditingController();
  TextEditingController PinCode = TextEditingController();
  TextEditingController Floor_optional = TextEditingController();
  TextEditingController Nearby_optional = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  List<dynamic> SearchList = [];
  bool isShowSearch = true;
  bool isReload = false;
  bool visible = true;

  String location = 'Null, Press Button';
  String Address = '';
  String strPlaceId = '';
  String strLatt = '';
  String strLong = '';

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address =
        '${place.street}, ${place.subLocality},${place.locality},${place.administrativeArea}, ${place.postalCode}, ${place.country}';
    setState(() {});
  }

  @override
  void initState() {
    getLocation();
    locationdata();
    super.initState();
  }

  locationdata() async {
    Position position = await _getGeoLocationPosition();
    location =
    'Lat: ${position.latitude} , Long: ${position.longitude}';
    GetAddressFromLatLong(position);
  }

  getLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double lat = position.latitude;
    double long = position.longitude;

    LatLng location = LatLng(lat, long);

    setState(() {
      _currentPosition = location;
    });
  }

  LatLng? _currentPosition;

  late GoogleMapController mapController;

  //final LatLng _center = const LatLng(23.040158, 72.560379);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  List<dynamic> buttonslist = ["Home", "Office", "Other"];

  int _selectedbuttonIndex = 0;

  late String searchAddr;
  List<Marker> markersList = [];
  late Marker finalMarker;

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration.zero, () => _searchdialogbox(context));
    final Sizee = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  isShowSearch = !isShowSearch;
                });
                // isShowSearch
                //     ? showSearchLocation(Sizee.height, Sizee.width)
                //     : SizedBox();
                //showSearchLocation(Sizee.height, Sizee.width);
              },
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          ],
          title: const Text(
            "Add Address",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: Sizee.height,
            width: Sizee.width,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    height: Sizee.height,
                    child: GoogleMap(
                      // zoomGesturesEnabled: true,
                      // mapType: MapType.terrain,
                      // compassEnabled: true,
                      // zoomControlsEnabled: true,
                      mapType: MapType.terrain,
                      myLocationButtonEnabled: true,
                      myLocationEnabled: false,
                      zoomGesturesEnabled: true,
                      padding: const EdgeInsets.all(0),
                      buildingsEnabled: true,
                      cameraTargetBounds: CameraTargetBounds.unbounded,
                      compassEnabled: true,
                      indoorViewEnabled: false,
                      mapToolbarEnabled: true,
                      minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                      rotateGesturesEnabled: true,
                      scrollGesturesEnabled: true,
                      tiltGesturesEnabled: true,
                      trafficEnabled: false,
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: const CameraPosition(
                        //target: LatLng(23.040158, 72.560379),
                        target: AddaddressScreen.Currentlocation,
                        zoom: 16.0,
                      ),
                      onTap: (LatLng location) {},
                      markers: Set.from(markersList),
                    ),
                  ),
                ),
                isShowSearch == true
                    ? Positioned(
                        // left: 10,
                        // right: 10,
                        // top: 50,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 50, horizontal: 30),
                          child: Container(
                            // color: Colors.red,
                            width: Sizee.width,
                            height: 370,
                            child: Card(
                              elevation: 5,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8, top: 7),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: const OutlineInputBorder(
                                          //borderRadius: BorderRadius.circular(10.0),
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          ),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: const Icon(
                                            Icons.search,
                                            color: Colors.black,
                                          ),
                                          onPressed: () {},
                                        ),
                                        hintText: "Search Location",
                                        labelStyle: const TextStyle(
                                            color: Colors.grey, fontSize: 18),
                                      ),
                                      onChanged: (value) {
                                        print(value);
                                        if (value.length >= 4) {
                                          placeSearchApiCall(value);
                                        }
                                      },
                                    ),
                                  ),
                                  Container(
                                    // color: Colors.green,
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                      top: 10,
                                    ),
                                    height: 245,
                                    width: double.infinity,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: SearchList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                isShowSearch = false;
                                              });
                                              placeDetailSearchApiCall(
                                                  SearchList[index]["place_id"]
                                                      .toString());
                                            },
                                            child: Container(
                                              // height: 62,
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    SearchList[index][
                                                                "structured_formatting"]
                                                            ["main_text"]
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            Color(0xFF000052)),
                                                  ),
                                                  Text(
                                                    SearchList[index]
                                                            ["description"]
                                                        .toString(),
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                        fontSize: 14),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                  Container(
                                    // color: Colors.red,
                                    padding: const EdgeInsets.only(
                                        right: 0, bottom: 0),
                                    alignment: Alignment.bottomRight,
                                    child: TextButton(
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isShowSearch = false;
                                        });
                                        // Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          // color: Colors.blue,
          padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
          height: Sizee.height / 5 - 36,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // color: Colors.red,
                      child: const Icon(
                        Icons.location_on,
                        color: Color(0xFF000052),
                        size: 30,
                      ),
                    ),
                    Container(
                      height: 40,
                      // color: Colors.red,
                      width: Sizee.height / 3 + 49,
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        Address,
                        maxLines: 2,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(bottom: 3),
                child: RaisedButton(
                  color: const Color(0xFF000052),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onPressed: () async {
                    _settingModelBottomSheet(context);
                    // Position position = await _getGeoLocationPosition();
                    // location =
                    //     'Lat: ${position.latitude} , Long: ${position.longitude}';
                    // GetAddressFromLatLong(position);
                  },
                  child: const Text(
                    "CONFIRM LOCATION",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _settingModelBottomSheet(context) {
    showModalBottomSheet(
      backgroundColor: CupertinoColors.systemGrey6,
      context: context,
      builder: (BuildContext bc) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          child: const Text(
                            "Enter Address Details",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                      color: CupertinoColors.systemGrey5,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10, bottom: 10),
                      alignment: Alignment.topLeft,
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: const TextSpan(
                          text: "Save address as ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: "*",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      // alignment: Alignment.topLeft,
                      // color: Colors.red,
                      height: 50,
                      // width: Sizee.width / 2 - 35,
                      child: ListView.builder(
                          // controller: _scrollController,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: buttonslist.length,
                          itemBuilder: (BuildContext context, int index) {
                            // _scrollToBottom();
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.only(right: 5, left: 5),
                                  height: 45,
                                  width: 80,
                                  child: RaisedButton(
                                    elevation: 0,
                                    color: (_selectedbuttonIndex == index)
                                        ? const Color(0xFF000052)
                                        : Colors.white,
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color:
                                                (_selectedbuttonIndex == index)
                                                    ? const Color(0xFF000052)
                                                    : const Color(0xFF000052),
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    onPressed: () {
                                      setState(() {
                                        _selectedbuttonIndex = index;
                                        //productList.clear();
                                      });
                                    },
                                    child: Text(
                                      buttonslist[index],
                                      style: TextStyle(
                                        color: (_selectedbuttonIndex == index)
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 13.6,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: Column(
                        children: [
                          Container(
                            //padding: const EdgeInsets.only(left: 10, bottom: 10),
                            alignment: Alignment.topLeft,
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: const TextSpan(
                                text: "Complete Address ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "*",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            padding: const EdgeInsets.only(top: 7, bottom: 7),
                            child: TextFormField(
                              controller: Completeaddress,
                              keyboardType: TextInputType.streetAddress,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: CupertinoColors.systemGrey5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: CupertinoColors.systemGrey5,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: CupertinoColors.systemGrey5,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Complete Address';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          Container(
                            //padding: const EdgeInsets.only(left: 10, bottom: 10),
                            alignment: Alignment.topLeft,
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: const TextSpan(
                                text: "Country ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "*",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            padding: const EdgeInsets.only(top: 7, bottom: 7),
                            child: TextFormField(
                              controller: Country,
                              keyboardType: TextInputType.text,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: CupertinoColors.systemGrey5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: CupertinoColors.systemGrey5,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: CupertinoColors.systemGrey5,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Country';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          Container(
                            //padding: const EdgeInsets.only(left: 10, bottom: 10),
                            alignment: Alignment.topLeft,
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: const TextSpan(
                                text: "State ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "*",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            padding: const EdgeInsets.only(top: 7, bottom: 7),
                            child: TextFormField(
                              controller: State,
                              keyboardType: TextInputType.text,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: CupertinoColors.systemGrey5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: CupertinoColors.systemGrey5,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: CupertinoColors.systemGrey5,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter State';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          Container(
                            //padding: const EdgeInsets.only(left: 10, bottom: 10),
                            alignment: Alignment.topLeft,
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: const TextSpan(
                                text: "City ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "*",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            padding: const EdgeInsets.only(top: 7, bottom: 7),
                            child: TextFormField(
                              controller: City,
                              keyboardType: TextInputType.text,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: CupertinoColors.systemGrey5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: CupertinoColors.systemGrey5,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: CupertinoColors.systemGrey5,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter City';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          Container(
                            //padding: const EdgeInsets.only(left: 10, bottom: 10),
                            alignment: Alignment.topLeft,
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: const TextSpan(
                                text: "Pin Code ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "*",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            padding: const EdgeInsets.only(top: 7, bottom: 7),
                            child: TextFormField(
                              controller: PinCode,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: CupertinoColors.systemGrey5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: CupertinoColors.systemGrey5,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: CupertinoColors.systemGrey5,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Pin Code';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          Container(
                            //padding: const EdgeInsets.only(left: 10, bottom: 10),
                            alignment: Alignment.topLeft,
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: const TextSpan(
                                text: "Floor ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "(optional)",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            padding: const EdgeInsets.only(top: 7, bottom: 7),
                            child: TextFormField(
                              controller: Floor_optional,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: CupertinoColors.systemGrey5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: CupertinoColors.systemGrey5,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: CupertinoColors.systemGrey5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            //padding: const EdgeInsets.only(left: 10, bottom: 10),
                            alignment: Alignment.topLeft,
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: const TextSpan(
                                text: "Near by ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "(optional)",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            padding: const EdgeInsets.only(top: 7, bottom: 7),
                            child: TextFormField(
                              controller: Nearby_optional,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: CupertinoColors.systemGrey5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: CupertinoColors.systemGrey5,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: CupertinoColors.systemGrey5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      padding:
                          const EdgeInsets.only(bottom: 3, left: 18, right: 18),
                      child: RaisedButton(
                        color: const Color(0xFF000052),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        onPressed: () async {},
                        child: const Text(
                          "CONFIRM LOCATION",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  placeSearchApiCall(String Search) async {
    setState(() {
      isReload = true;
    });
    try {
      final body = {
        "search": Search,
      };

      var response = await http.post(Uri.parse(placeSearch_Api), body: body);

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);

        if (decode["success"] == true) {
          print(decode);
          setState(() {
            SearchList = decode["data"][0]["predictions"];
            print("SearchList length ${SearchList.length}");
          });
        } else {
          print("1");
          String errorMsg = json.decode(response.body)["message"].toString();
          print("2");
          if (json.decode(response.body)["data"] != null) {
            print("3");
            var errorList = json.decode(response.body)["data"];

            for (int i = 0; i < errorList.length; i++) {
              Map errorMap = errorList[i];
              for (String k in errorMap.keys) {
                print(errorMap[k]);
                errorMsg = errorMap[k][0] ??
                    json.decode(response.body)["message"].toString();
                break;
              }
            }
          }
          final snackBar = SnackBar(
            content: Text(errorMsg),
            action: SnackBarAction(
              label: '',
              onPressed: () {},
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

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

  placeDetailSearchApiCall(String place_Id) async {
    setState(() {
      isReload = true;
    });
    try {
      final body = {
        "place_id": place_Id,
      };

      print("Body Detail Search  $body");

      var response = await http.post(Uri.parse(Detail_Place_Api), body: body);

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);

        if (decode["success"] == true) {
          print(decode);
          setState(() {
            print("detail Search 1");
            Address =
                decode["data"][0]["result"]["formatted_address"].toString();
            print("detail Search 2");

            var dataarray = decode["data"][0]["result"]["address_components"];
            print("detail Search 3 $dataarray");

            strPlaceId = place_Id;

            strLatt = decode["data"][0]["result"]["geometry"]["location"]["lat"]
                .toString();
            strLong = decode["data"][0]["result"]["geometry"]["location"]["lng"]
                .toString();

            for (int i = 0; i < dataarray.length; i++) {
              print("detail Search ");

              List dataTypesArray = dataarray[i]["types"];
              print("detail Search 5 $dataTypesArray");

              // if (dataTypesArray.contains("country")) {
              //   Country.text = dataarray[i]["long_name"].toString();
              // } else if (dataTypesArray
              //     .contains("administrative_area_level_1")) {
              //   State.text = dataarray[i]["long_name"].toString();
              // } else if (dataTypesArray
              //     .contains("administrative_area_level_3")) {
              //   City.text = dataarray[i]["long_name"].toString();
              // } else if (dataTypesArray.contains("postal_code")) {
              //   Pincode.text = dataarray[i]["long_name"].toString();
              // }
            }
          });
        } else {
          print("1");
          String errorMsg = json.decode(response.body)["message"].toString();
          print("2");
          if (json.decode(response.body)["data"] != null) {
            print("3");
            var errorList = json.decode(response.body)["data"];

            for (int i = 0; i < errorList.length; i++) {
              Map errorMap = errorList[i];
              for (String k in errorMap.keys) {
                print(errorMap[k]);
                errorMsg = errorMap[k][0] ??
                    json.decode(response.body)["message"].toString();
                break;
              }
            }
          }
          final snackBar = SnackBar(
            content: Text(errorMsg),
            action: SnackBarAction(
              label: '',
              onPressed: () {},
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

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
