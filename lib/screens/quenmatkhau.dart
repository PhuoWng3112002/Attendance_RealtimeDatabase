import 'package:attendance_application/re-use_ui/sidebar.dart';
import 'package:attendance_application/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../components/color.dart';

class QuenMatKhau extends StatefulWidget {
  const QuenMatKhau({super.key});

  @override
  State<QuenMatKhau> createState() => _QuenMatKhauState();
}

class _QuenMatKhauState extends State<QuenMatKhau> {
  var emailController = new TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
        // appBar: AppBarHistory(title1: "Quên mật khẩu", context: context),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Color(0XFF014282),
              )),
          title: const Text(
            'Quên mật khẩu',
            style: TextStyle(
                color: Color(0xFF014282), fontWeight: FontWeight.bold),
          ),
          shadowColor: Colors.white,
          elevation: 0,
        ),
        drawer: const NavigationDrawerTabBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: 25, vertical: screenheight / 10),
            child: Column(children: [
              Text(
                'Vui lòng nhập email để lấy lại mật khẩu',
                style: TextStyle(
                    color: primary,
                    fontWeight: FontWeight.bold,
                    fontSize: screenwidth / 21),
              ),
              SizedBox(
                height: screenheight / 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey, width: 2),
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    icon: const Icon(Icons.https),
                    iconColor: const Color(0xFF014282),
                    hintText: 'example@gmail.com',
                    hintStyle: const TextStyle(color: Color(0xFFaaaaaa)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenheight / 32,
              ),
              const Text(
                'Lưu ý: Chúng tôi sẽ gửi mật khẩu mới vào email của bạn. \nVui lòng check và đăng nhập lại hệ thống!',
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(
                height: screenheight / 23,
              ),
              SizedBox(
                width: (2 / 3) * screenwidth,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () {
                      //Firebase
                      //.then push login
                      verifyEmail();
                    },
                    child: const Text(
                      'GỬI EMAIL',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              )
            ]),
          ),
        ));
  }

  Future verifyEmail() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      Fluttertoast.showToast(msg: "Đã gửi email");
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    } on FirebaseAuthException catch (e) {
      print(e);
      Fluttertoast.showToast(msg: e.message.toString());
    }
  }
}
