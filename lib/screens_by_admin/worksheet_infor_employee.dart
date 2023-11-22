import 'package:attendance_application/components/color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailEmployeeScreen extends StatefulWidget {
  const DetailEmployeeScreen({super.key});

  @override
  State<DetailEmployeeScreen> createState() => _DetailEmployeeScreenState();
}

class _DetailEmployeeScreenState extends State<DetailEmployeeScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage("assets/images/logo.png"),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "thphg311@gmail.com\n Nguyễn Thị Phương",
              style: TextStyle(
                fontSize: screenWidth / 23,
                color: Colors.white,
              ),
            )
          ],
        ),
        backgroundColor: primary,
        //chiều cao app bar(tool bar)
        toolbarHeight: screenWidth / 5,
        elevation: 0, //shadow app bar
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.only(
        //     bottomLeft: Radius.circular(15),
        //     bottomRight: Radius.circular(15),
        //   ),
        // ),

        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.add_alert))
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: accent,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Thông tin_test',
          ),
          NavigationDestination(
            icon: Icon(Icons.business),
            label: 'Bảng công',
          ),
          // NavigationDestination(
          //   selectedIcon: Icon(Icons.school),
          //   icon: Icon(Icons.school_outlined),
          //   label: 'Tác vụ',
          // ),
        ],
      ),
      body: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: ListView(
            children: [
              buildTextField("Họ tên", "Nguyễn Thị Phương"),
              buildTextField("Ngày sinh", "31/01/2002"),
              buildTextField("CMND", "030303007745"),
              buildTextField("SĐT", "0889563201"),
              buildTextField("STK", "0889563201"),
              buildTextField("Ngân hàng", "Vietcombank"),
              buildTextField("Vị trí", "Nhân viên kinh doanh"),
              buildTextField("Mức lương", "30.000.000 VND"),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     OutlinedButton(
              //       onPressed: () {},
              //       child: Text(
              //         "Cancel",
              //         style: TextStyle(
              //             fontSize: 16, letterSpacing: 2, color: black),
              //       ),
              //       style: OutlinedButton.styleFrom(
              //         padding: EdgeInsets.symmetric(horizontal: 50),
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(20)),
              //       ),
              //     ),
              //     ElevatedButton(
              //       onPressed: () {},
              //       child: Text(
              //         "Lưu",
              //         style: TextStyle(
              //           fontSize: 16,
              //           letterSpacing: 2,
              //           color: white,
              //         ),
              //       ),
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: primary,
              //         padding: EdgeInsets.symmetric(horizontal: 50),
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(20)),
              //       ),
              //     )
              //   ],
              // )
            ],
          ),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.only(top: 20, left: 12, right: 12),
          child: Column(
            children: [
              Container(
                height: screenHeight / 9,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: black26,
                      blurRadius: 10,
                      offset: Offset(2, 2),
                    )
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(),
                        child: Center(
                          child: Text(
                            DateFormat('EE\ndd MM yyyy').format(DateTime.now()),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: white,
                                backgroundColor: accent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                textStyle: TextStyle(
                                  fontSize: screenWidth / 28,
                                )),
                            onPressed: () {},
                            child: const Text('CHECK IN'),
                          ),
                          Text(
                            "8:30",
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: white,
                                backgroundColor: primary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                textStyle: TextStyle(
                                  fontSize: screenWidth / 28,
                                )),
                            onPressed: () {},
                            child: const Text('CHECK OUT'),
                          ),
                          Text(
                            "16:30",
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
              ),
              /***************ListView******************** */
            ],
          ),
        ),
      ][currentPageIndex],
    );
  }

  Widget buildTextField(String labelText, String placehoder) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 5),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placehoder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
