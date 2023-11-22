import 'package:attendance_application/re-use_ui/appbar.dart';
import 'package:attendance_application/re-use_ui/row_history.dart';
import 'package:attendance_application/re-use_ui/sidebar.dart';
import 'package:attendance_application/screens/detail_history.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../components/color.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Absent');

  String _month = DateFormat("MM").format(DateTime.now());
  double screenHeight = 0;
  double screenWidth = 0;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBarHistory(
        title1: 'Lịch sử nghỉ phép',
        context: context,
      ),
      drawer: const NavigationDrawerTabBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const DetailHistory()));
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
              Padding(
                padding: const EdgeInsets.only(bottom:5),
                child: Container(
                  height: screenHeight - screenHeight / 5,
                  child: StreamBuilder(
                    stream: FirebaseDatabase.instance
                        .ref()
                        .child("Absent")
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
                              return list[index]['date'].substring(3, 5) == _month
                                  ? Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 20),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                            bottomRight: Radius.circular(15)),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(0.0, 1.0), //(x,y)
                                            blurRadius: 6.0,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.insert_invitation,
                                                    color: Color(0xFF014282),
                                                    size: 24,
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    list[index]["date"],
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Color(0xFF014282)),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.album_outlined,
                                                    color: Color(0xFFfe8005),
                                                    size: 24,
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    list[index]['state'],
                                                    style: const TextStyle(
                                                        color: Color(0xFFfe8005),
                                                        fontSize: 16),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.text_snippet,
                                                color: Color(0xFF014282),
                                                size: 24,
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                list[index]['reason'],
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xFF014282)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ))
                                  : const SizedBox();
                            });
                      } else {
                        return const SizedBox(
                          child: Text("Không có dữ liệu"),
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget _buildBody(context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final ref = FirebaseDatabase.instance.ref('Absent');
    String _month = DateFormat("MM").format(DateTime.now());

    double screenwidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Column(
        children: [
          // const RowChooseDate(),
          Stack(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                child: Text(
                  // "Tháng ${DateFormat('MM').format(DateTime.now())}",
                  "Tháng ${_month}",
                  style: TextStyle(
                      fontSize: screenwidth / 20,
                      color: primary,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
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
                          fontSize: screenwidth / 20,
                          color: primary,
                          fontWeight: FontWeight.bold),
                    ),
                  ))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const RowHistory(
            time: 'Buổi sáng, Thứ tư, 02/11/2023',
            date: '02/11/2023',
            status: 'Đang chờ',
            reasons: 'Lý do cá nhân',
            iconstatus: Icons.rotate_left_rounded,
          ),
          const SizedBox(
            height: 20,
          ),
          const RowHistory(
            time: 'Buổi sáng, Thứ ba, 01/11/2023',
            date: '01/11/2023',
            status: 'Đã duyệt',
            reasons: 'Lý do cá nhân',
            iconstatus: Icons.check,
          ),
          const SizedBox(
            height: 20,
          ),
          const RowHistory(
            time: 'Buổi sáng, Thứ ba, 01/11/2023',
            date: '01/11/2023',
            status: 'Từ chối',
            reasons: 'Lý do cá nhân',
            iconstatus: Icons.dangerous,
          ),
          const SizedBox(
            height: 15,
          ),
          Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF014282),
                      Color.fromARGB(255, 17, 129, 221),
                      Color.fromARGB(255, 201, 210, 227),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  color: Colors.blue,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Buổi sáng, Thứ 6, 18/08/2023',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: screenwidth / 23, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.insert_invitation,
                                color: Color(0xFF014282),
                                size: 24,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                '18/08/2023',
                                style: TextStyle(
                                    fontSize: 16, color: Color(0xFF014282)),
                              ),
                            ],
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.rotate_left_rounded,
                                color: Color(0xFFfe8005),
                                size: 24,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Đang chờ',
                                style: TextStyle(
                                    color: Color(0xFFfe8005), fontSize: 16),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.text_snippet,
                            color: Color(0xFF014282),
                            size: 24,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Lí do cá nhân',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xFF014282)),
                          ),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF014282),
                      Color.fromARGB(255, 17, 129, 221),
                      Color.fromARGB(255, 201, 210, 227),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  color: Colors.blue,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Buổi chiều, Thứ 6, 11/08/2023',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: screenwidth / 23, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.insert_invitation,
                                color: Color(0xFF014282),
                                size: 24,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                '11/08/2023',
                                style: TextStyle(
                                    fontSize: 16, color: Color(0xFF014282)),
                              ),
                            ],
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.check,
                                color: Color(0xFF72bb53),
                                size: 24,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Đã duyệt',
                                style: TextStyle(
                                    color: Color(0xFF72bb53), fontSize: 16),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.text_snippet,
                            color: Color(0xFF014282),
                            size: 24,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Lí do cá nhân',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xFF014282)),
                          ),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF014282),
                      Color.fromARGB(255, 17, 129, 221),
                      Color.fromARGB(255, 201, 210, 227),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  color: Colors.blue,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Cả ngày, Thứ 2, 07/08/2023',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: screenwidth / 23, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.insert_invitation,
                                color: Color(0xFF014282),
                                size: 24,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                '07/08/2023',
                                style: TextStyle(
                                    fontSize: 16, color: Color(0xFF014282)),
                              ),
                            ],
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.dangerous,
                                color: Color.fromARGB(255, 230, 64, 89),
                                size: 24,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Từ chối',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 230, 64, 89),
                                    fontSize: 16),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.text_snippet,
                            color: Color(0xFF014282),
                            size: 24,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Lí do cá nhân',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xFF014282)),
                          ),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF014282),
                      Color.fromARGB(255, 17, 129, 221),
                      Color.fromARGB(255, 201, 210, 227),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  color: Colors.blue,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Buổi sáng, Thứ 6, 18/08/2023',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: screenwidth / 23, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.insert_invitation,
                                color: Color(0xFF014282),
                                size: 24,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                '18/08/2023',
                                style: TextStyle(
                                    fontSize: 16, color: Color(0xFF014282)),
                              ),
                            ],
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.rotate_left_rounded,
                                color: Color(0xFFfe8005),
                                size: 24,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Đang chờ',
                                style: TextStyle(
                                    color: Color(0xFFfe8005), fontSize: 16),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.text_snippet,
                            color: Color(0xFF014282),
                            size: 24,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Lí do cá nhân',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xFF014282)),
                          ),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF014282),
                      Color.fromARGB(255, 17, 129, 221),
                      Color.fromARGB(255, 201, 210, 227),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  color: Colors.blue,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Buổi sáng, Thứ 6, 18/08/2023',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: screenwidth / 23, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: const Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.insert_invitation,
                                color: Color(0xFF014282),
                                size: 24,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                '18/08/2023',
                                style: TextStyle(
                                    fontSize: 16, color: Color(0xFF014282)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.rotate_left_rounded,
                                color: Color(0xFFfe8005),
                                size: 24,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Đang chờ',
                                style: TextStyle(
                                    color: Color(0xFFfe8005), fontSize: 16),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.text_snippet,
                            color: Color(0xFF014282),
                            size: 24,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Lí do cá nhân',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xFF014282)),
                          ),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

class RowChooseDate extends StatefulWidget {
  const RowChooseDate({super.key});

  @override
  State<RowChooseDate> createState() => _RowChooseDateState();
}

class _RowChooseDateState extends State<RowChooseDate> {
  String textdefault = 'Chọn ngày';
  DateTime? dateChoose;
  IconData? iconChoose;
  IconData icondefault = Icons.expand_circle_down;
  Future<void> _selectDate(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateChoose ?? DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        dateChoose = picked;
        iconChoose = Icons.close;
      });
    } else {
      iconChoose = Icons.calendar_month;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          width: 130,
          height: 50,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(238, 236, 236, 1),
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            InkWell(
              onTap: () {},
              child: const Text(
                'Tất cả',
                style: TextStyle(color: secondary, fontSize: 18),
              ),
            ),
            InkWell(
              onTap: () {},
              child: const Icon(Icons.expand_circle_down, color: primary),
            ),
          ]),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          width: 130,
          height: 50,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(238, 236, 236, 1),
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            InkWell(
              onTap: () {
                _selectDate(context);
              },
              child: Text(
                dateChoose == null
                    ? textdefault
                    : '${dateChoose!.day}/${dateChoose!.month}/${dateChoose!.year}'
                        .toString(),
                style: const TextStyle(color: secondary, fontSize: 18),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  dateChoose = null;
                });
              },
              child: Icon(
                (dateChoose == null ? icondefault : iconChoose),
                color: primary,
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
