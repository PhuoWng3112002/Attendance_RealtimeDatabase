import 'package:attendance_application/components/color.dart';
import 'package:attendance_application/modal/user.dart';
import 'package:attendance_application/re-use_ui/appbar.dart';
import 'package:attendance_application/screens/home_screen.dart';
import 'package:attendance_application/screens/login_screen.dart';
import 'package:attendance_application/screens_by_admin/hr_management.dart';
// import 'package:attendance_application/screens_by_admin/home_screen_by_admin.dart';
// import 'package:attendance_application/screens_by_admin/home_screen_by_admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddNewEmployeeScreen extends StatefulWidget {
  const AddNewEmployeeScreen({super.key});

  @override
  State<AddNewEmployeeScreen> createState() => _AddNewEmployeeScreenState();
}

class _AddNewEmployeeScreenState extends State<AddNewEmployeeScreen> {
  // static Future<User?> loginUsingEmailPassword(
  //     {required String email,
  //     required String password,
  //     required BuildContext context}) async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   User? user;
  //   try {
  //     UserCredential userCredential = await auth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     user = userCredential.user;
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == "user-not-found") {
  //       print("No user found for that email");
  //     }
  //   }
  //   return user;
  // }

  double screenHeight = 0;
  double screenWidth = 0;

  final _formfield = GlobalKey<FormState>();
  var emailController = new TextEditingController();
  var passController = new TextEditingController();
  var fullnameController = new TextEditingController();
  var birthController = new TextEditingController();
  var cmndController = new TextEditingController();
  var sdtController = new TextEditingController();
  bool passToggle = true;

  // late DatabaseReference dbRef;
  final dbRef = FirebaseDatabase.instance.ref();
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBarHistory(title1: "Thêm nhân viên", context: context),
      // backgroundColor:accent,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: _formfield,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Email",
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: const InputDecoration(
                      // labelText: 'Email',
                      hintText: "Example@gmail.com",

                      border: OutlineInputBorder(),
                      // prefixIcon: Icon(Icons.email),
                      // enabledBorder: OutlineInputBorder(
                      //   borderSide: const BorderSide(
                      //     width: 2.0,
                      //     color: primary,
                      //   ),
                      //   borderRadius: BorderRadius.circular(15),
                      // ),
                      // focusedBorder: OutlineInputBorder(
                      //     borderSide:
                      //         const BorderSide(width: 2.0, color: accent),
                      //     borderRadius: BorderRadius.circular(15)),
                    ),
                    validator: (value) {
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value!);
                      if (value.isEmpty) {
                        return "Please enter your Email";
                      } else if (!emailValid) {
                        return "Invalid Email Address";
                      }
                      return null;
                    },
                  ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Mật khẩu",
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    // obscureText: passToggle ? false : true,
                    obscureText: passToggle,
                    keyboardType: TextInputType.emailAddress,
                    controller: passController,
                    decoration: InputDecoration(
                      // labelText: 'Password',
                      hintText: "Mật khẩu dài ít nhất 6 kí tự",

                      border: const OutlineInputBorder(),
                      // prefixIcon: const Icon(Icons.lock),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            passToggle = !passToggle;
                          });
                        },
                        child: Icon(passToggle
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                      // enabledBorder: OutlineInputBorder(
                      //   borderSide: const BorderSide(
                      //     width: 2.0,
                      //     color: primary,
                      //   ),
                      //   borderRadius: BorderRadius.circular(15),
                      // ),
                      // focusedBorder: OutlineInputBorder(
                      //     borderSide:
                      //         const BorderSide(width: 2.0, color: accent),
                      //     borderRadius: BorderRadius.circular(15)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Password";
                      } else if (passController.text.length < 6) {
                        return "Minimum password length should be more than 6 characters";
                      }
                      return null;
                    },
                  ),
                  // const SizedBox(
                  //   height: 20,
                  // ),

                  // anything
                  // textField(
                  //     'Email', 'example@gmail.com', emailController),
                  // textField('Mật khẩu', 'Mật khẩu dài hơn 6 kí tự',
                  //     passController),
                  textField('Họ tên', 'Nguyễn Văn A', fullnameController),
                  textField('Ngày sinh', '--/--/----', birthController),
                  textField('CMND', '0xxxxxxxxxxx', cmndController),
                  textField('Số điện thoại', '0xxxxxxxxx', sdtController),

                  InkWell(
                    onTap: () {
                      if (emailController.text.isNotEmpty &&
                          passController.text.isNotEmpty &&
                          fullnameController.text.isNotEmpty &&
                          birthController.text.isNotEmpty &&
                          cmndController.text.isNotEmpty &&
                          sdtController.text.isNotEmpty) {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passController.text,
                            )
                            .then((value) => {
                                  insertData(
                                      emailController.text,
                                      passController.text,
                                      fullnameController.text,
                                      birthController.text,
                                      cmndController.text,
                                      sdtController.text)
                                })
                            .then((value) => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HRScreen()))
                                })
                            .onError((error, stackTrace) => {
                                  Fluttertoast.showToast(
                                    msg: error.toString(),
                                  )
                                });
                        Fluttertoast.showToast(
                          msg: "Thêm thành công",
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: "Không được để trống",
                        );
                      }
                      // Map<String, String> userMap = {
                      //   'email': emailController.text,
                      //   'password': passController.text,
                      //   'fullname': fullnameController.text,
                      //   'birth': birthController.text,
                      //   'cmnd': cmndController.text,
                      //   'sdt': sdtController.text,
                      // };
                      // dbRef.push().set(userMap);

                      // if (_formfield.currentState!.validate()) {
                      //   // emailController.clear();
                      //   // passController.clear();
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             emailController.text ==
                      //                     "admin@gmail.com"
                      //                 ? const HomeScreenAdmin()
                      //                 : const HomeScreen()),
                      //   );
                      // }
                      // User? user = await loginUsingEmailPassword(
                      //     email: emailController.text,
                      //     password: passController.text,
                      //     context: context);
                      // // print(user);
                      // if (user != null) {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             emailController.text ==
                      //                     "admin@gmail.com"
                      //                 ? const HomeScreenAdmin()
                      //                 : const HomeScreen()),
                      //   );
                      // } else {
                      //   showDialog<AlertDialog>(
                      //       context: context,
                      //       builder: (BuildContext context) {
                      //         return AlertDialog(
                      //             title: Text("Thông báo"),
                      //             content: Text(
                      //                 "Sai tài khoản hoặc mật khẩu"));
                      //       });
                      // }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: screenHeight * 0.070,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                          colors: [secondary, primary],
                        ),
                      ),
                      child: const Text(
                        "Thêm NV",
                        style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }

  void insertData(String email, String password, String fullname, String birth,
      String cmnd, String sdt) {
    // DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("DetailUser");

    final User? user = auth.currentUser;
    final uid = user?.uid;
    dbRef.child("User").child(uid.toString()).set({
      'email': email,
      'password': password,
      'fullname': fullname,
      'birth': birth,
      'cmnd': cmnd,
      'sdt': sdt,
    });
    emailController.clear();
    passController.clear();
    fullnameController.clear();
    birthController.clear();
    cmndController.clear();
    sdtController.clear();
  }
}

Widget textField(String title, String hint, TextEditingController controller) {
  return Column(
    children: <Widget>[
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
      ),
      const SizedBox(
        height: 8,
      ),
      Container(
        height: 60,
        margin: const EdgeInsets.only(bottom: 12),
        child: TextFormField(
          controller: controller,
          cursorColor: black54,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(),
            // enabledBorder: const OutlineInputBorder(
            //   borderSide: BorderSide(
            //     color: Colors.black54,
            //   ),
            // ),
            // focusedBorder: const OutlineInputBorder(
            //   borderSide: BorderSide(
            //     color: Colors.black54,
            //   ),
            // ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "Không được để trống";
            }
            return null;
          },
        ),
      ),
    ],
  );
}
