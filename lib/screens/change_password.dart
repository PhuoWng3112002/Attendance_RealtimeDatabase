import 'package:attendance_application/re-use_ui/appbar.dart';
import 'package:attendance_application/re-use_ui/sidebar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../components/color.dart';

class DoiMatKhau extends StatefulWidget {
  const DoiMatKhau({super.key});

  @override
  State<DoiMatKhau> createState() => _DoiMatKhauState();
}

class _DoiMatKhauState extends State<DoiMatKhau> {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var oldPasswordController = TextEditingController();
    var newPasswordController = TextEditingController();
    var confirmPasswordController = TextEditingController();

    var auth = FirebaseAuth.instance;
    // var currentUser = FirebaseAuth.instance.currentUser;
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBarHistory(title1: "Đổi mật khẩu", context: context),
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   leading: IconButton(
        //     onPressed: (){Navigator.pop(context);},
        //     icon: const Icon(Icons.arrow_back_ios, color: Color(0XFF014282),)
        //     ),
        //     title: const Text('Đổi mật khẩu', style: TextStyle(color: Color(0xFF014282), fontWeight: FontWeight.bold),),
        //     shadowColor: Colors.white,
        //     elevation: 0,
        //     ),
        drawer: const NavigationDrawerTabBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: 25, vertical: screenheight / 10),
            child: Column(children: [
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
                    hintText: 'Email',
                    hintStyle: const TextStyle(color: Color(0xFFaaaaaa)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey, width: 2),
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  controller: oldPasswordController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    icon: const Icon(Icons.https),
                    iconColor: const Color(0xFF014282),
                    hintText: 'Mật khẩu hiện tại',
                    hintStyle: const TextStyle(color: Color(0xFFaaaaaa)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey, width: 2),
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  controller: newPasswordController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    icon: const Icon(Icons.lock_reset),
                    iconColor: const Color(0xFF014282),
                    hintText: 'Mật khẩu mới',
                    hintStyle: const TextStyle(color: Color(0xFFaaaaaa)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey, width: 2),
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  controller: confirmPasswordController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    icon: const Icon(Icons.lock_reset),
                    iconColor: const Color(0xFF014282),
                    hintText: 'Nhập lại mật khẩu mới',
                    hintStyle: const TextStyle(color: Color(0xFFaaaaaa)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              SizedBox(
                width: (2 / 3) * screenwidth,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () async {
                      if (newPasswordController.text !=
                          confirmPasswordController.text) {
                        Fluttertoast.showToast(
                            msg: "Mật khẩu mới nhập lại không khớp");
                      } else {
                        await changePassword(
                                emailController.text,
                                oldPasswordController.text,
                                newPasswordController.text)
                            .then(
                          emailController.clear(),
                          newPasswordController.clear(),
                          oldPasswordController.clear(),
                          confirmPasswordController.clear(),
                        );
                      }
                    },
                    child: const Text(
                      'ĐỔI MẬT KHẨU',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              )
            ]),
          ),
        ));
  }

  changePassword(email, oldPassword, newPassword) async {
    var auth = FirebaseAuth.instance;
    var currentUser = FirebaseAuth.instance.currentUser;
    var cred =
        EmailAuthProvider.credential(email: email, password: oldPassword);
    await currentUser?.reauthenticateWithCredential(cred).then((value) {
      currentUser.updatePassword(newPassword).whenComplete(
          () => Fluttertoast.showToast(msg: "Thay đổi mật khẩu thành công"));
    }).catchError((error) {
      Fluttertoast.showToast(msg: error.toString());
    });
  }
}
