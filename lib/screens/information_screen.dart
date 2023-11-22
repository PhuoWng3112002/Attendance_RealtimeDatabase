import 'package:attendance_application/components/color.dart';
import 'package:flutter/material.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({super.key});

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Thông tin cá nhân",
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
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        SizedBox(
          height: screenHeight,
          child: Stack(
            children: <Widget>[
              //cái nền trắng
              Container(
                margin: EdgeInsets.only(top: screenHeight / 18),
                height: screenHeight,
                decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
              ),
              //nội dung body'
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    AssetImage("assets/images/logo.png"),
                              ),
                            ),
                          ],
                        )),
                      ],
                    ),
                    //Danh sách thông tin cá nhân
                  ],
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 40, vertical: screenHeight / 5),
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
        )
      ])),
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
