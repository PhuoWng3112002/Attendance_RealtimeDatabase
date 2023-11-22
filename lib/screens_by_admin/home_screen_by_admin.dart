import 'package:attendance_application/components/color.dart';
import 'package:attendance_application/screens/login_screen.dart';
import 'package:attendance_application/screens/logout.dart';
import 'package:attendance_application/screens_by_admin/hr_management.dart';
import 'package:attendance_application/screens_by_admin/manager_resigns.dart';
import 'package:attendance_application/screens_by_admin/worksheet_infor_employee.dart';
import 'package:flutter/material.dart';

class HomeScreenAdmin extends StatefulWidget {
  const HomeScreenAdmin({super.key});

  @override
  State<HomeScreenAdmin> createState() => _HomeScreenAdminState();
}

class _HomeScreenAdminState extends State<HomeScreenAdmin> {
  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Material(
                child: Container(
                  color: primary,
                  padding: EdgeInsets.only(
                    top: 20 + MediaQuery.of(context).padding.top,
                    bottom: 20,
                    left: 25,
                  ),
                  child: const Row(
                    children: [
                      Text(
                        "Admin DashBoard",
                        style: TextStyle(
                          fontSize: 20,
                          color: white,
                        ),
                      )
                    ],
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
                      title: const Text("Quản lý nhân viên"),
                      onTap: () => Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(
                        builder: (context) => const HRScreen(),
                      )),
                    ),
                    ListTile(
                      //Bảng công user và admin cũng cùng form--> phân quyền
                      leading: const Icon(Icons.add_chart),
                      title: const Text("Quản lý xin nghỉ"),
                      onTap: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => XinNghiDangCho(),
                        ),
                      ),
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
                      onTap: () => showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => const NoticesLogout()),
                    ),
                    const Divider(
                      color: black54,
                    ),
                  ],
                ),
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.all(10),
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.all(30),
                    decoration: const BoxDecoration(
                      color: accent,
                      boxShadow: [
                        BoxShadow(
                          color: black26,
                          blurRadius: 10,
                          offset: Offset(2, 2),
                        )
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Nhân viên",
                          style: TextStyle(
                              color: white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "79 / 79",
                          style: TextStyle(
                              color: white,
                              fontSize: 36,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  )),
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.all(10),
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.all(30),
                    decoration: const BoxDecoration(
                      color: primary,
                      boxShadow: [
                        BoxShadow(
                          color: black26,
                          blurRadius: 10,
                          offset: Offset(2, 2),
                        )
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Chấm công",
                          style: TextStyle(
                              color: white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "10 (x%)",
                          style: TextStyle(
                              color: white,
                              fontSize: 36,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  )),
                ],
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.all(10),
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.all(30),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      boxShadow: [
                        BoxShadow(
                          color: black26,
                          blurRadius: 10,
                          offset: Offset(2, 2),
                        )
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Nghỉ phép",
                          style: TextStyle(
                              color: white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "7 (9%)",
                          style: TextStyle(
                              color: white,
                              fontSize: 36,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  )),
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.all(10),
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.all(30),
                    decoration: const BoxDecoration(
                      color: Colors.redAccent,
                      boxShadow: [
                        BoxShadow(
                          color: black26,
                          blurRadius: 10,
                          offset: Offset(2, 2),
                        )
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Lịch họp",
                          style: TextStyle(
                              color: white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "0 (0%)",
                          style: TextStyle(
                              color: white,
                              fontSize: 36,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  )),
                ],
              ),
            ],
          ),
          //****/ADD THÊM CHO ZUI */
        ),
      );
}
