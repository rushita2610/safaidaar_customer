import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Closeaccountscreen extends StatefulWidget {
  const Closeaccountscreen({Key? key}) : super(key: key);

  @override
  State<Closeaccountscreen> createState() => _CloseaccountscreenState();
}

class _CloseaccountscreenState extends State<Closeaccountscreen> {
  List<dynamic> reasonlist = [
    'I am not using this account anymore',
    'I have another account',
    'I want to create a new account',
    'Account security concerns/Unauthorised activity',
    'Privacy concerns',
    'I have open issues with Sadaidaar',
    'I do not want to provide a reason',
  ];

  String reasondropdown = '';

  bool isChecked = false;

  TextEditingController reasonfield = TextEditingController();

  void _settingreasonBottomSheet(context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext bc) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.only(left: 15, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        CupertinoIcons.clear_circled_solid,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    // color: Colors.red,
                    height: reasonlist.length * 55,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: reasonlist.length,
                        itemBuilder: (BuildContext cntx, int index) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: 40,
                                  child: Text(
                                    reasonlist[index],
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 1,
                                color: CupertinoColors.systemGrey6,
                              ),
                            ],
                          );
                        }),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // final Sizee = MediaQuery.of(context).size;
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
          title: Transform(
            transform: Matrix4.translationValues(-20, 0.0, 0.0),
            child: const Text(
              "Close Your SafaiDaar Account",
              style: TextStyle(
                // fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.all(15),
            height: height,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  height: 30,
                  child: const Text(
                    "Please read this carefully",
                    // maxLines: 6,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Container(
                  // color: Colors.red,
                  height: height * 0.14,
                  child: const Text(
                    "You are about to submit a request for us to permanently close your Safaidaar account and delete your data. Once your account is closwed all of the order accessed through your account, will no longer be available to you.",
                    maxLines: 6,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.5,
                      // fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Container(
                  height: height * 0.265,
                  width: width,
                  decoration: BoxDecoration(
                    //color: Colors.black,
                    border: Border.all(
                      color: Colors.lightBlue,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: height * 0.255,
                        width: width * 0.025,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          // border: Border.all(color: Colors.lightBlue,width: 1.5,),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Container(
                        height: height * 0.3,
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, top: 12, bottom: 12),
                        child: Column(
                          children: [
                            Container(
                              // color: Colors.red,
                              alignment: Alignment.topLeft,
                              height: 30,
                              width: width * 0.83,
                              child: const Text(
                                "Account Closure Is A Permanent Action",
                                textAlign: TextAlign.left,
                                // maxLines: 6,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Container(
                              // color: Colors.red,
                              height: height * 0.19,
                              width: width * 0.83,
                              child: const Text(
                                "Please note account closure is a permanent action and once your account is closed it will no longer be available to you and cannot be restored. If you decide later that you want to start ordering from us again or if you would like to use our services that require an account, you will need to create a new account.",
                                maxLines: 8,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.5,
                                  // fontWeight: FontWeight.w900,
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
                  // color: Colors.red,
                  height: height * 0.07,
                  width: width,
                  child: const Text(
                    "Please select the main reason for closing your Safaidaar account (Optional)",
                    maxLines: 8,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.5,
                      // fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _settingreasonBottomSheet(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 13),
                    height: height * 0.07,
                    width: width,
                    decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey5,
                        border: Border.all(color: Colors.black54, width: 1.5),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: width * 0.5,
                          child: TextFormField(
                            onTap: () {
                              _settingreasonBottomSheet(context);
                              reasondropdown = reasonlist as String;
                              print(reasonlist);
                            },
                            readOnly: true,
                            controller: reasonfield,
                            keyboardType: TextInputType.none,
                            decoration: const InputDecoration(
                              //suffixIcon: Icon(Icons.keyboard_arrow_down,size: 30,),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              hintText: "Choose Reason",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down_outlined,
                          size: 25,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  // color: Colors.red,
                  height: 50,
                  alignment: Alignment.topLeft,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Transform.scale(
                        scale: 1.4,
                        child: Checkbox(
                            value: isChecked,
                            activeColor: Colors.lightBlue,
                            fillColor: MaterialStateColor.resolveWith(
                              (states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Colors
                                      .lightBlue; // the color when checkbox is selected;
                                }
                                return Colors
                                    .black; //the color when checkbox is unselected;
                              },
                            ),
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            }),
                      ),
                      Container(
                        height: 45,
                        width: width * 0.7,
                        child: const Text(
                          'Yes. I want to permanently close my Safaidaar Account and delete my data.',
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
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
                  height: height * 0.06,
                  width: width,
                  child: RaisedButton(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                    color: (isChecked == false)
                        ? Colors.indigo[300]
                        : const Color(0xFF000052),
                    onPressed: isChecked ? () {} : null,
                    child: const Text(
                      "Close My Account",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
