import 'dart:ffi';

import 'package:attendance_application/re-use_ui/sidebar.dart';
import 'package:attendance_application/screens/home_screen.dart';
import 'package:attendance_application/screens/information_screen.dart';
import 'package:attendance_application/screens_by_admin/home_screen_by_admin.dart';
import 'package:attendance_application/screens_by_admin/hr_management.dart';
import 'package:attendance_application/screens_by_admin/worksheet_infor_employee.dart';
import 'package:attendance_application/screens_by_admin/worksheet_screen_by_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../components/color.dart';
import 'login_screen.dart';

class Cong extends StatefulWidget {
  const Cong({super.key});

  @override
  State<Cong> createState() => _CongState();
}

class _CongState extends State<Cong> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('User');

  double screenHeight = 0;
  double screenWidth = 0;

  String _month = DateFormat("MM").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                "Bảng công",
                style: TextStyle(
                  fontSize: screenWidth / 20,
                  color: Colors.white,
                ),
              )
            ],
          ),
          backgroundColor: primary,
          //chiều cao app bar(tool bar)
          toolbarHeight: screenWidth / 5,
          elevation: 0, //shadow app bar
        ),
        drawer: const NavigationDrawerTabBar(),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                // Container(
                //   alignment: Alignment.centerLeft,
                //   margin: EdgeInsets.only(top: 32),
                //   child: Text(
                //     "My Attendance",
                //   ),
                // ),
                Stack(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(top: 10, bottom: 20),
                      child: Text(
                        // "Tháng ${DateFormat('MM').format(DateTime.now())}",
                        "Tháng ${_month}",
                        style: TextStyle(
                            fontSize: screenWidth / 20,
                            color: primary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(top: 10, bottom: 20),
                        child: GestureDetector(
                          onTap: () async {
                            //2023-06-01 00:00:00.000
                            final month = await showMonthYearPicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2023),
                                lastDate: DateTime(2099),
                                builder: ((context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme:
                                          const ColorScheme.highContrastLight(
                                              background: primary,
                                              secondary: secondary,
                                              primary: primary,
                                              onSecondary: white),
                                    ),
                                    child: child!,
                                  );
                                }));
                            if (month != null) {
                              // print(month);
                              setState(() {
                                _month = DateFormat("MM").format(month);
                              });
                            }
                          },
                          child: Text(
                            "Chọn tháng",
                            style: TextStyle(
                                fontSize: screenWidth / 20,
                                color: primary,
                                fontWeight: FontWeight.bold),
                          ),
                        ))
                  ],
                ),

                //ở đây !important
                Container(
                  height: screenHeight - screenHeight / 5,
                  child: StreamBuilder(
                    stream: FirebaseDatabase.instance
                        .ref()
                        .child("Attendance")
                        .child(auth.currentUser!.uid.toString())
                        .onValue,
                    builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                      if (snapshot.hasData &&
                          snapshot.data != null &&
                          (snapshot.data!).snapshot.value != null) {
                        Map<dynamic, dynamic> map =
                            snapshot.data!.snapshot.value as dynamic;
                        List<dynamic> list = [];
                        list.clear();
                        list = map.values.toList();
                        // final snap = snapshot.data.docs;
                        return ListView.builder(
                            itemCount: snapshot.data!.snapshot.children.length,
                            itemBuilder: (context, index) {
                              return list[index]['date'].substring(2, 4) ==
                                      _month
                                  ? Container(
                                      height: screenHeight / 8,
                                      margin: const EdgeInsets.only(
                                          top: 12, left: 6, right: 6),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: black26,
                                            blurRadius: 10,
                                            offset: Offset(2, 2),
                                          )
                                        ],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.only(),
                                              child: Center(
                                                //lấy ngày tháng checkIn-out
                                                child: Text(
                                                  list[index]['date']
                                                          .substring(0, 2) +
                                                      '/' +
                                                      list[index]['date']
                                                          .substring(2, 4) +
                                                      '/' +
                                                      list[index]['date']
                                                          .substring(4, 8),
                                                  // DateTime.parse(list[index]['date'])

                                                  style: TextStyle(
                                                    fontSize: screenWidth / 23,
                                                    color: black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                      foregroundColor: white,
                                                      backgroundColor: accent,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.0)),
                                                      textStyle: TextStyle(
                                                        fontSize:
                                                            screenWidth / 28,
                                                      )),
                                                  onPressed: () {},
                                                  child: const Text('CHECK IN'),
                                                ),
                                                Text(
                                                  list[index]['checkIn'],
                                                  style: TextStyle(
                                                    fontSize: screenWidth / 18,
                                                    color: accent,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                      foregroundColor: white,
                                                      backgroundColor: primary,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.0)),
                                                      textStyle: TextStyle(
                                                        fontSize:
                                                            screenWidth / 28,
                                                      )),
                                                  onPressed: () {},
                                                  child:
                                                      const Text('CHECK OUT'),
                                                ),
                                                Text(
                                                  list[index]['checkOut'],
                                                  style: TextStyle(
                                                    fontSize: screenWidth / 18,
                                                    color: primary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox();
                            });
                      } else {
                        return const SizedBox(
                          child: Text("Không có dữ liệu"),
                        );
                      }
                    },
                  ),
                )
              ],
            )));
  }

  getIdUser() async {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    return uid.toString();
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // buildHeader(context);
              // buildMenuItem();
              //Trang thông tin cá nhan
              // và trang quản lý thông tin cá nhân giống nhau
              //phân quyền thì hide btn đi
              Material(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const InformationScreen(),
                    ));
                  },
                  child: Container(
                    color: primary,
                    padding: EdgeInsets.only(
                      top: 20 + MediaQuery.of(context).padding.top,
                      bottom: 20,
                      left: 25,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage("assets/images/logo.png"),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        infoWidget(),
                        // Text(
                        //   "thphg311@gmail.com\n Nguyễn Thị Phương",
                        //   style: TextStyle(
                        //     fontSize: 15,
                        //     color: white,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Wrap(
                  runSpacing: 2,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.home_outlined),
                      title: const Text("Trang chủ"),
                      onTap: () => Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      )),
                    ),
                    ListTile(
                      leading: const Icon(Icons.add_chart),
                      title: const Text("Bảng công✔"),
                      onTap: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const Cong(),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.calendar_month_rounded),
                      title: const Text("Lịch"),
                      onTap: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const HomeScreenAdmin())),
                    ),
                    ListTile(
                      //Quản trị nhân lực== DS nhân viên
                      leading: const Icon(Icons.add_task_rounded),
                      title: const Text("Xin nghỉ"),
                      onTap: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const HRScreen())),
                    ),
                    ListTile(
                      leading: const Icon(Icons.change_circle_outlined),
                      title: const Text("Đổi mật khẩu"),
                      onTap: () {},
                    ),
                    const Divider(
                      color: black54,
                    ),
                    ListTile(
                        leading: const Icon(
                          Icons.outbond_rounded,
                          color: accent,
                        ),
                        title: const Text(
                          "Đăng xuất",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        onTap: () => {
                              FirebaseAuth.instance.signOut().then((value) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()));
                              })
                            })
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  getInfo() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      for (final providerProfile in user.providerData) {
        // final provider = providerProfile.providerId;
        // final uid = providerProfile.uid;

        final name = providerProfile.displayName;
        final email = providerProfile.email;
        return name.toString() + '\n' + email.toString();
      }
    } else {
      return;
    }
  }

  infoWidget() {
    return Text(
      getInfo(),
      style: TextStyle(
        fontSize: 15,
        color: white,
      ),
    );
  }
}
