//import 'package:attendance/screens/add_meeting_screen.dart';

import 'package:attendance_application/components/color.dart';
import 'package:attendance_application/re-use_ui/confirm.dart';
import 'package:attendance_application/re-use_ui/sidebar.dart';
import 'package:attendance_application/screens/add_meeting_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

class LichHop extends StatefulWidget {
  const LichHop({super.key});

  @override
  State<LichHop> createState() => _LichHopState();
}

class _LichHopState extends State<LichHop> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Meeting');

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
                "Lịch họp",
                style: TextStyle(
                    fontSize: screenWidth / 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          backgroundColor: primary,
          //chiều cao app bar(tool bar)
          toolbarHeight: screenWidth / 5,
          elevation: 0, //shadow app bar
        ),
        drawer: const NavigationDrawerTabBar(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ThemLichHopMoi()));
          },
          child: const Icon(Icons.add),
        ),
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
                        .child("Meeting")
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
                              return list[index]['date'].substring(3, 5) ==
                                      _month
                                  ? Container(
                                      height: screenHeight / 4.5,
                                      margin: const EdgeInsets.only(
                                          top: 12, left: 3, right: 3),
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
                                              decoration: BoxDecoration(
                                                  color: primary,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              child: Center(
                                                //lấy ngày tháng checkIn-out
                                                child: Text(
                                                  list[index]['date']
                                                          .substring(0, 2) +
                                                      '/' +
                                                      list[index]['date']
                                                          .substring(3, 5),
                                                  // DateTime.parse(list[index]['date'])

                                                  style: TextStyle(
                                                    fontSize: screenWidth / 23,
                                                    color: white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                                            width: 250,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 15),
                                            // color: const Color.fromARGB(255, 224, 220, 220),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      list[index]['title'],
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color(
                                                              0xFF014282)),
                                                    ),
                                                    ConfirmButton(),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  list[index]['startTime'] +
                                                      '-' +
                                                      list[index]['endTime'],
                                                  style: const TextStyle(
                                                      color: Colors.orange),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  list[index]['content'],
                                                  style: const TextStyle(
                                                      color: secondary),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                  width: 250,
                                                  child: Text(
                                                    list[index]['room'],
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFF014282),
                                                        overflow:
                                                            TextOverflow.clip),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
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
}

Widget _buildBody(context) {
  return SingleChildScrollView(
    child: Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 224, 220, 220),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Column(children: [
        RowLichHop(
          date: DateTime.now(),
          title: 'Họp team Android',
          textdate: '9:00 -10:00',
          textmeet: 'Phòng họp số 1',
          textname:
              'Nguyễn Thị Phương, Nguyễn Thị Tình, Nguyễn Văn Trúc A, Trần Văn B',
        ),
        const SizedBox(
          height: 15,
        ),
        RowLichHop(
          date: DateTime.now(),
          title: 'Họp team Android',
          textdate: '9:00 -10:00',
          textmeet: 'Phòng họp số 1',
          textname:
              'Nguyễn Thị Phương, Nguyễn Thị Tình, Nguyễn Văn Trúc A, Trần Văn B',
        ),
        const SizedBox(
          height: 15,
        ),
        RowLichHop(
          date: DateTime.now(),
          title: 'Họp team Android',
          textdate: '9:00 -10:00',
          textmeet: 'Phòng họp số 1',
          textname:
              'Nguyễn Thị Phương, Nguyễn Thị Tình, Nguyễn Văn Trúc A, Trần Văn B',
        ),
        const SizedBox(
          height: 15,
        ),
        RowLichHop(
          date: DateTime.now(),
          title: 'Họp team Android',
          textdate: '9:00 -10:00',
          textmeet: 'Phòng họp số 1',
          textname:
              'Nguyễn Thị Phương, Nguyễn Thị Tình, Nguyễn Văn Trúc A, Trần Văn B',
        ),
        const SizedBox(
          height: 15,
        ),
        RowLichHop(
          date: DateTime.now(),
          title: 'Họp team Android',
          textdate: '9:00 -10:00',
          textmeet: 'Phòng họp số 1',
          textname:
              'Nguyễn Thị Phương, Nguyễn Thị Tình, Nguyễn Văn Trúc A, Trần Văn B',
        ),
        const SizedBox(
          height: 15,
        ),
        RowLichHop(
          date: DateTime.now(),
          title: 'Họp team Android',
          textdate: '9:00 -10:00',
          textmeet: 'Phòng họp số 1',
          textname:
              'Nguyễn Thị Phương, Nguyễn Thị Tình, Nguyễn Văn Trúc A, Trần Văn B',
        ),
        const SizedBox(
          height: 15,
        ),
        RowLichHop(
          date: DateTime.now(),
          title: 'Họp team Android',
          textdate: '9:00 -10:00',
          textmeet: 'Phòng họp số 1',
          textname:
              'Nguyễn Thị Phương, Nguyễn Thị Tình, Nguyễn Văn Trúc A, Trần Văn B',
        ),
        const SizedBox(
          height: 15,
        ),
        RowLichHop(
          date: DateTime.now(),
          title: 'Họp team Android',
          textdate: '9:00 -10:00',
          textmeet: 'Phòng họp số 1',
          textname:
              'Nguyễn Thị Phương, Nguyễn Thị Tình, Nguyễn Văn Trúc A, Trần Văn B',
        ),
        const SizedBox(
          height: 15,
        ),
      ]),
    ),
  );
}

class RowLichHop extends StatelessWidget {
  final String textdate;
  final String title;
  final String textname;
  final DateTime date;
  final String textmeet;
  const RowLichHop(
      {super.key,
      required this.title,
      required this.date,
      required this.textname,
      required this.textdate,
      required this.textmeet});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: screenwidth / 5,
          child: Text(
            DateFormat('dd \n Tháng MM').format(DateTime.now()),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenwidth / 23,
                color: primary),
            overflow: TextOverflow.clip,
            textAlign: TextAlign.center,
          ),
        ),
        // const SizedBox(width: 15,),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          width: 250,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          // color: const Color.fromARGB(255, 224, 220, 220),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xFF014282)),
                  ),
                  ConfirmButton(),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                textdate,
                style: const TextStyle(color: Colors.orange),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                textmeet,
                style: const TextStyle(color: secondary),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 250,
                child: Text(
                  textname,
                  maxLines: 2,
                  style: const TextStyle(
                      color: Color(0xFF014282), overflow: TextOverflow.clip),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
