import 'package:attendance_application/components/color.dart';
import 'package:flutter/material.dart';

class WorkSheetAdminScreen extends StatefulWidget {
  const WorkSheetAdminScreen({super.key});

  @override
  State<WorkSheetAdminScreen> createState() => _WorkSheetAdminScreenState();
}

class _WorkSheetAdminScreenState extends State<WorkSheetAdminScreen> {
  double screenHeight = 0;
  double screenWidth = 0;

  String checkIn = "--/--";
  String checkOut = "--/--";

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primary,
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
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        SizedBox(
          height: screenHeight,
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: screenHeight / 18),
                height: screenHeight,
                decoration: const BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    )),
              ),
              //padding-column-widget-(text-text-row)
              // rơw-widget[richtext
              // expand]
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  margin:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  alignment: Alignment.center,
                                  height: screenHeight * 0.06,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(color: accent),
                                    color: white, //action
                                  ),
                                  child: const Text(
                                    "Thông tin",
                                    style: TextStyle(
                                      color: accent, //action
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  margin: const EdgeInsets.only(left: 8, right: 8),
                                  alignment: Alignment.center,
                                  height: screenHeight * 0.06,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(color: accent),
                                    color: accent, //action
                                  ),
                                  child: const Text(
                                    "Bảng công",
                                    style: TextStyle(
                                      color: white, //action
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ])),
    );
  }
}
