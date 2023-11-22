import 'package:attendance_application/components/color.dart';
import 'package:attendance_application/modal/user.dart';
import 'package:attendance_application/modal/user_modal.dart';
import 'package:attendance_application/re-use_ui/sidebar.dart';
import 'package:attendance_application/screens/cong.dart';
import 'package:attendance_application/screens/information_screen.dart';
import 'package:attendance_application/screens/login_screen.dart';
import 'package:attendance_application/screens/worksheet_screen.dart';
import 'package:attendance_application/screens_by_admin/home_screen_by_admin.dart';
import 'package:attendance_application/screens_by_admin/hr_management.dart';
import 'package:attendance_application/screens_by_admin/worksheet_screen_by_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Future<FirebaseApp> _initializeFirebase() async {
  //   FirebaseApp firebaseApp = await Firebase.initializeApp();
  //   return firebaseApp;
  // }

  // late SharedPreferences sharedPreferences;

  double screenHeight = 0;
  double screenWidth = 0;

  String checkIn = "--/--";
  String checkOut = "--/--";

  List<UserModal> userList = [];

  // final myEmail = FirebaseAuth.instance.currentUser?.emailVerified;
  FirebaseAuth auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Attendance');

  // DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

  // late DatabaseReference dbRef;
  late DatabaseReference databaseReference;
  // final User? user = auth.currentUser;
  // final uid = user?.uid;
  @override
  void initState() {
    super.initState();

    // dbRef = FirebaseDatabase.instance.ref();
    databaseReference = FirebaseDatabase.instance.ref();
    // .child(uid!)
    // .child(DateFormat('dd MMMM yyyy').format(DateTime.now()));
    // String? emailUser = sharedPreferences.getString("email");
    // final snapshot = ref.child('users/${auth.currentUser?.uid}/email').get();
    retrieveUserData();
    _getAttendance();
  }

  void _getAttendance() async {
    try {
      final User? user = auth.currentUser;
      final uid = user?.uid;
      final snap = await databaseReference
          .child('Attendance')
          .child(uid.toString())
          .get();
      final snapIn = await databaseReference
          .child('Attendance')
          .child(uid.toString())
          .child(DateFormat('dd MMMM yyyy').format(DateTime.now()))
          .child("checkIn")
          .get();
      final snapOut = await databaseReference
          .child('Attendance')
          .child(uid.toString())
          .child(DateFormat('dd MMMM yyyy').format(DateTime.now()))
          .child("checkOut")
          .get();
      setState(() {
        if (snapIn.exists) {
          checkIn = snapIn.value.toString();
          // checkOut = snap2.child("checkOut").value.toString();
        } else {
          checkIn = "--/--";
        }
        if (snapOut.exists) {
          checkOut = snapOut.value.toString();
          // checkOut = snap2.child("checkOut").value.toString();
        } else {
          checkOut = "--/--";
        }
      });
    } catch (e) {
      checkIn = "--/--";
      checkOut = "--/--";
    }
    // print(checkIn);
    // print(checkOut);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              emailWidget(),
              // StreamBuilder<Object>(
              //     stream: null,
              //     builder: (context, snapshot) {
            ],
          ),
          backgroundColor: primary,
          //chiều cao app bar(tool bar)
          toolbarHeight: screenWidth / 5,
          elevation: 5, //shadow app bar
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.add_alert))
          ],
        ),
        drawer: const NavigationDrawerTabBar(),
        body:
            // FutureBuilder(
            //     future: _initializeFirebase(),
            //     builder: (_, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.done) {
            //         return
            Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Wrap(
                          children: [
                            Icon(
                              Icons.access_alarm,
                              color: primary,
                              size: screenWidth / 18,
                            ),
                            Text(
                              " Phép tồn",
                              style: TextStyle(
                                  fontSize: screenWidth / 22,
                                  color: primary,
                                  fontWeight: FontWeight.w900),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "12/12",
                          style: TextStyle(
                            color: primary,
                            fontSize: screenWidth / 21,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * .03),
              /**CHECK IN?OUT BOX */
              Container(
                margin: const EdgeInsets.only(top: 12, left: 6, right: 6),
                height: screenHeight / 3.5,
                decoration: const BoxDecoration(
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      color: black26,
                      blurRadius: 10,
                      offset: Offset(2, 2),
                    )
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: screenHeight / 17,
                      decoration: const BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            text: DateFormat('EE , dd MMMM yyyy')
                                .format(DateTime.now()),
                            style: TextStyle(
                              color: white,
                              fontSize: screenWidth / 23,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight / 35,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // checkInWidget()
                                    Text(
                                      checkIn,
                                      style: TextStyle(
                                        color: accent,
                                        fontSize: screenWidth / 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              /*****************CHECK OUT***************** */
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      checkOut,
                                      style: TextStyle(
                                        color: primary,
                                        fontSize: screenWidth / 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: screenHeight / 30,
                          ),
                          checkOut == "--/--"
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CupertinoButton(
                                            padding: EdgeInsets.zero,
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 20.0),
                                              alignment: Alignment.center,
                                              width: screenWidth / 2.5,
                                              height: screenHeight / 18,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(37),
                                                color: checkIn == "--/--"
                                                    ? accent
                                                    : primary,
                                              ),
                                              child: checkIn == "--/--"
                                                  ? const Text(
                                                      "CHECK IN",
                                                      style: TextStyle(
                                                        color: white,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    )
                                                  : const Text(
                                                      "CHECK OUT",
                                                      style: TextStyle(
                                                        color: white,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                            ),
                                            onPressed: () async {
                                              attendanceFunction().then(
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HomeScreen(),
                                                )),
                                              );
                                              // checkInFunction();
                                              // final User? user = auth.currentUser;
                                              // final uid = user?.uid;
                                              // final snapshot = await databaseReference
                                              //     .child('Attendance')
                                              //     .child(uid.toString())
                                              //     .child(DateFormat('dd MMMM yyyy')
                                              //         .format(DateTime.now()))
                                              //     .child('checkIn')
                                              //     .get();
                                              // if (snapshot.exists) {
                                              //   checkIn = snapshot.value.toString();
                                              // } else {
                                              //   checkIn = "--/--";
                                              // }
                                              // QueryDocumentSnapshot snap =
                                              //     await

                                              // Map<String, String> records = {
                                              //   'checkIn': DateFormat('hh:mm')
                                              //       .format(DateTime.now()),
                                              //   'checkOut': checkOut,
                                              // };
                                              // dbRef
                                              //     .child(DateFormat('dd MMMM yyyy')
                                              //         .format(DateTime.now()))
                                              //     .update(records);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CupertinoButton(
                                            padding: EdgeInsets.zero,
                                            child: Container(
                                                margin: const EdgeInsets.only(
                                                    top: 20.0),
                                                alignment: Alignment.center,
                                                width: screenWidth / 2.5,
                                                height: screenHeight / 18,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(37),
                                                  color: Colors.grey,
                                                ),
                                                child: const Text(
                                                  "HOÀN THÀNH",
                                                  style: TextStyle(
                                                    color: white,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                )),
                                            onPressed: () {
                                              const Dialog(
                                                  backgroundColor: Colors.grey,
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                16)),
                                                  ));
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * .03),

              /************7 ngày gần nhất**************** */
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Tin nổi bật",
                  style: TextStyle(
                      color: primary,
                      // fontFamily:
                      fontSize: screenWidth / 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              //**************Flutter Image Slide show**************************** */

              ImageSlideshow(
                /// Width of the [ImageSlideshow].
                width: double.infinity,

                /// Height of the [ImageSlideshow].
                height: 200,

                /// The page to show when first creating the [ImageSlideshow].
                initialPage: 0,

                /// The color to paint the indicator.
                indicatorColor: Colors.blue,

                /// The color to paint behind th indicator.
                indicatorBackgroundColor: Colors.grey,

                /// The widgets to display in the [ImageSlideshow].
                /// Add the sample image file into the images folder
                children: [
                  Image.asset(
                    'assets/images/anh1.jpg',
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    'assets/images/anh2.jpg',
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    'assets/images/anh3.jpg',
                    fit: BoxFit.cover,
                  ),
                ],

                /// Called whenever the page in the center of the viewport changes.
                onPageChanged: (value) {
                  print('Page changed: $value');
                },

                /// Auto scroll interval.
                /// Do not auto scroll with null or 0.
                autoPlayInterval: 3000,

                /// Loops back to first slide.
                isLoop: true,
              ),

              //**************Flutter Image Slide show**************************** */
              // SingleChildScrollView(
              //   padding: const EdgeInsets.only(top: 10),
              //   child: Column(
              //     children: [
              //       Container(
              //         height: screenHeight / 9,
              //         decoration: const BoxDecoration(
              //           color: Colors.white,
              //           boxShadow: [
              //             BoxShadow(
              //               color: black26,
              //               blurRadius: 10,
              //               offset: Offset(2, 2),
              //             )
              //           ],
              //           borderRadius: BorderRadius.all(Radius.circular(20)),
              //         ),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             Expanded(
              //               child: Container(
              //                 margin: const EdgeInsets.only(),
              //                 child: Center(
              //                   child: Text(
              //                     DateFormat('EE\ndd MM yyyy')
              //                         .format(DateTime.now()),
              //                     style: TextStyle(
              //                       fontSize: screenWidth / 23,
              //                       color: black,
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             Expanded(
              //               child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 crossAxisAlignment: CrossAxisAlignment.center,
              //                 children: [
              //                   TextButton(
              //                     style: TextButton.styleFrom(
              //                         foregroundColor: white,
              //                         backgroundColor: accent,
              //                         shape: RoundedRectangleBorder(
              //                             borderRadius:
              //                                 BorderRadius.circular(30.0)),
              //                         textStyle: TextStyle(
              //                           fontSize: screenWidth / 28,
              //                         )),
              //                     onPressed: () {},
              //                     child: const Text('CHECK IN'),
              //                   ),
              //                   Text(
              //                     "8:30",
              //                     style: TextStyle(
              //                       fontSize: screenWidth / 18,
              //                       color: accent,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //             Expanded(
              //               child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 crossAxisAlignment: CrossAxisAlignment.center,
              //                 children: [
              //                   TextButton(
              //                     style: TextButton.styleFrom(
              //                         foregroundColor: white,
              //                         backgroundColor: primary,
              //                         shape: RoundedRectangleBorder(
              //                             borderRadius:
              //                                 BorderRadius.circular(30.0)),
              //                         textStyle: TextStyle(
              //                           fontSize: screenWidth / 28,
              //                         )),
              //                     onPressed: () {},
              //                     child: const Text('CHECK OUT'),
              //                   ),
              //                   Text(
              //                     "16:30",
              //                     style: TextStyle(
              //                       fontSize: screenWidth / 18,
              //                       color: primary,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       for (int i = 0; i < userList.length; i++)
              //         userWidget(userList[i])
              //       /***************ListView******************** */
              //     ],
              //   ),
              // ),
            ],
          ),
        ));
  }

  void retrieveUserData() {
    databaseReference.child("User").onChildAdded.listen((data) {
      UserData userData = UserData.fromJson(data.snapshot.value as Map);
      UserModal userModal =
          UserModal(key: data.snapshot.key, userData: userData);
      userList.add(userModal);
      setState(() {});
    });
  }

  userWidget(UserModal userList) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Column(
          children: [Text(userList.userData.email!)],
        )
      ]),
    );
  }

  getEmail() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      for (final providerProfile in user.providerData) {
        // final provider = providerProfile.providerId;
        // final uid = providerProfile.uid;

        // final name = providerProfile.displayName;
        final email = providerProfile.email;
        return email;
      }
    } else {
      return;
    }
  }

  emailWidget() {
    return Text(
      // ignore: prefer_interpolation_to_compose_strings
      'Welcome,\n ' + getEmail(),
      style: TextStyle(
          fontSize: screenWidth / 23,
          color: Colors.white,
          fontWeight: FontWeight.w900),
    );
  }

  checkInFunction() async {
    final User? user = auth.currentUser;
    final uid = user?.uid;

    databaseReference
        .child("Attendance")
        .child(uid.toString())
        .child(DateFormat('dd MMMM yyyy').format(DateTime.now()))
        .update({
      'checkIn': DateFormat('hh:mm').format(DateTime.now()),
      'checkOut': checkOut,
    });

    final snapshot1 = await databaseReference
        .child('Attendance')
        .child(uid.toString())
        .child(DateFormat('dd MMMM yyyy').format(DateTime.now()))
        .child('checkIn')
        .get();
    if (snapshot1.exists) {
      checkIn = snapshot1.value.toString();
      print(snapshot1.value);
      // checkOutFunction();
    } else {
      checkIn = "--/--";
    }
    // var checkInFirebse = databaseReference
    //     .child("Attendance")
    //     .child(uid.toString())
    //     .child(DateFormat('dd MMMM yyyy').format(DateTime.now()))
    //     .child('checkIn')
    //     .get();
    // return checkInFirebse.toString();
    // print(checkInFirebse.toString());
  }

  checkOutFunction() async {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    databaseReference
        .child("Attendance")
        .child(uid.toString())
        .child(DateFormat('dd MMMM yyyy').format(DateTime.now()))
        .update({
      'checkOut': DateFormat('hh:mm').format(DateTime.now()),
    });

    final snapshot2 = await databaseReference
        .child('Attendance')
        .child(uid.toString())
        .child(DateFormat('dd MMMM yyyy').format(DateTime.now()))
        .child('checkOut')
        .get();
    if (snapshot2.exists) {
      checkOut = snapshot2.value.toString();
    } else {
      print(snapshot2.value);
      checkOut = "--/--";
    }

    // var checkInFirebse = databaseReference
    //     .child("Attendance")
    //     .child(uid.toString())
    //     .child(DateFormat('dd MMMM yyyy').format(DateTime.now()))
    //     .child('checkIn')
    //     .get();
    // return checkInFirebse.toString();
    // print(checkInFirebse.toString());
  }

  // checkInWidget() {
  //   return Text(
  //     "c",
  //     // checkInFunction(),
  //     style: TextStyle(
  //       color: accent,
  //       fontSize: screenWidth / 13,
  //     ),
  //   );
  // }
  attendanceFunction() async {
    // Future.delayed(Duration(milliseconds: 500), () {
    //   key.currentState!.reset();
    // });
    final User? user = auth.currentUser;
    final uid = user?.uid;
    // final snap =
    // await databaseReference.child('Attendance').child(uid.toString()).get();
    final snap2 = await databaseReference
        .child('Attendance')
        .child(uid.toString())
        .child(DateFormat('dd MMMM yyyy').format(DateTime.now()))
        .get();

    try {
      // print(snap2.child('checkIn'));
      String checkIn = snap2.child("checkIn").value as String;
      await databaseReference
          .child("Attendance")
          .child(uid.toString())
          .child(DateFormat('dd MMMM yyyy').format(DateTime.now()))
          .update({
        'date': DateFormat('ddMMyyyy').format(DateTime.now()),
        // 'date': Timestamp.now(),
        'checkIn': checkIn,
        'checkOut': DateFormat('hh:mm').format(DateTime.now()),
      });
    } catch (e) {
      //if
      await databaseReference
          .child("Attendance")
          .child(uid.toString())
          .child(DateFormat('dd MMMM yyyy').format(DateTime.now()))
          .set({
        // "date": Timestamp.now(),
        'date': DateFormat('ddMMyyyy').format(DateTime.now()),
        'checkIn': DateFormat('hh:mm').format(DateTime.now()),
        'checkOut': "--/--",
      });
    }
  }
}
