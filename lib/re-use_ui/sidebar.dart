import 'package:attendance_application/components/color.dart';
import 'package:attendance_application/screens/change_password.dart';
import 'package:attendance_application/screens/cong.dart';
import 'package:attendance_application/screens/home_screen.dart';
import 'package:attendance_application/screens/inforUser.dart';
import 'package:attendance_application/screens/information_screen.dart';
import 'package:attendance_application/screens/login_screen.dart';
import 'package:attendance_application/screens/logout.dart';
import 'package:attendance_application/screens/meeting_screen.dart';
import 'package:attendance_application/screens/rest_history.dart';
import 'package:attendance_application/screens_by_admin/home_screen_by_admin.dart';
import 'package:attendance_application/screens_by_admin/hr_management.dart';
import 'package:attendance_application/screens_by_admin/worksheet_screen_by_admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavigationDrawerTabBar extends StatelessWidget {
  const NavigationDrawerTabBar({Key? key}) : super(key: key);

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
                      builder: (context) => const InforUser(),
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
                      title: const Text("Bảng công"),
                      onTap: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const Cong(),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.calendar_month_rounded),
                      title: const Text("Lịch họp"),
                      onTap: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const LichHop())),
                    ),
                    ListTile(
                      //Quản trị nhân lực== DS nhân viên
                      leading: const Icon(Icons.add_task_rounded),
                      title: const Text("Xin nghỉ"),
                      onTap: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const History())),
                    ),
                    ListTile(
                      leading: const Icon(Icons.change_circle_outlined),
                      title: const Text("Đổi mật khẩu"),
                      onTap: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const DoiMatKhau())),
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
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) => const NoticesLogout())
                              // FirebaseAuth.instance.signOut().then((value) {
                              //   Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) => LoginScreen()));
                              // })
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

        // final name = providerProfile.displayName;
        final email = providerProfile.email;
        return email.toString();
      }
    } else {
      return;
    }
  }

  infoWidget() {
    return Text(
      // ignore: prefer_interpolation_to_compose_strings
      "Thông tin cá nhân \n" + getInfo(),
      style: const TextStyle(
        fontSize: 15,
        color: white,
      ),
    );
  }
}
