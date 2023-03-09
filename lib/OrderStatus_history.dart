import 'package:flutter/material.dart';

class Orderstatus extends StatefulWidget {
  const Orderstatus({Key? key}) : super(key: key);

  @override
  State<Orderstatus> createState() => _OrderstatusState();
}

class _OrderstatusState extends State<Orderstatus> {
  bool isReload = false;
  bool _checkbox1 = false;
  bool _checkbox2 = true;
  bool _checkbox3 = false;
  bool _checkbox4 = false;
  bool _checkbox5 = false;
  bool _checkbox6 = false;
  String strNum = "";

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
          automaticallyImplyLeading: true,
          title: const Text(
            "Order status Report",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: (isReload == false)
            ? SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  height: height,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              "Pick Up Order Information ()",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Pick Up Bag Number",
                                style: TextStyle(fontSize: 15),
                              ),
                              Container(
                                height: 50,
                                width: 100,
                                child: TextField(
                                  readOnly: true,
                                  keyboardType: TextInputType.none,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    hintText: "223",
                                    //hintStyle: TextStyle(),
                                    labelStyle: const TextStyle(
                                        color: Colors.grey, fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _checkbox1 = !_checkbox1 ? false : true;
                              });
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                  activeColor: Colors.red,
                                  value: _checkbox1,
                                  onChanged: (value) {
                                    setState(() {
                                      _checkbox1 = !_checkbox1 ? false : true;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  child: const Text(
                                    "Damage",
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _checkbox2 = !_checkbox2 ? false : true;
                              });
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                  activeColor: Colors.red,
                                  value: _checkbox2,
                                  onChanged: (value) {
                                    setState(() {
                                      _checkbox2 = !_checkbox2 ? false : true;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Text(
                                  "Stain",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _checkbox3 = !_checkbox3 ? false : true;
                              });
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                  activeColor: Colors.red,
                                  value: _checkbox3,
                                  onChanged: (value) {
                                    setState(() {
                                      _checkbox3 = !_checkbox3 ? false : true;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Text(
                                  "Accessories",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              "Driver Pick Up Order Comment",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 70,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            width: width,
                            child: TextField(
                              readOnly: true,
                              keyboardType: TextInputType.none,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                hintText: "skhdatyadf",
                                //hintStyle: TextStyle(),
                                labelStyle: const TextStyle(
                                    color: Colors.grey, fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              "Vendor information ()",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _checkbox4 = !_checkbox4 ? false : true;
                              });
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                  activeColor: Colors.red,
                                  value: _checkbox4,
                                  onChanged: (value) {
                                    setState(() {
                                      _checkbox4 = !_checkbox4 ? false : true;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  child: const Text(
                                    "Damage",
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _checkbox5 = !_checkbox5 ? false : true;
                              });
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                  activeColor: Colors.red,
                                  value: _checkbox5,
                                  onChanged: (value) {
                                    setState(() {
                                      _checkbox5 = !_checkbox5 ? false : true;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Text(
                                  "Stain",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _checkbox6 = !_checkbox6 ? false : true;
                              });
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                  activeColor: Colors.red,
                                  value: _checkbox6,
                                  onChanged: (value) {
                                    setState(() {
                                      _checkbox6 = !_checkbox6 ? false : true;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Text(
                                  "Accessories",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              "Vendor order Comment",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 70,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            width: width,
                            child: TextField(
                              readOnly: true,
                              keyboardType: TextInputType.none,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                hintText: "90",
                                //hintStyle: TextStyle(),
                                labelStyle: const TextStyle(
                                    color: Colors.grey, fontSize: 18),
                              ),
                            ),
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
}
