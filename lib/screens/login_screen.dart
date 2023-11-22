import 'package:attendance_application/components/color.dart';
import 'package:attendance_application/screens/home_screen.dart';
import 'package:attendance_application/screens/quenmatkhau.dart';
import 'package:attendance_application/screens_by_admin/add_new_employee.dart';
import 'package:attendance_application/screens_by_admin/home_screen_by_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:attendance_application/screens_by_admin/home_screen_by_admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // static Future<User?> loginUsingEmailPassword(
  //     {required String email,
  //     required String password,
  //     required BuildContext context}) async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   User? user;
  //   try {
  //     UserCredential userCredential = await auth.signInWithEmailAndPassword(
  //         email: emailController.text, password: passController.text);
  //     user = userCredential.user;
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == "user-not-found") {
  //       Fluttertoast.showToast(
  //         msg: "Login Fail",
  //       );
  //       print("No user found for that email");
  //     }
  //   }
  //   return user;
  // }

  double screenHeight = 0;
  double screenWidth = 0;

  final _formfield = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool passToggle = true;

  late SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        // backgroundColor:accent,
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
              child: Form(
                key: _formfield,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/logo.png",
                        height: 200,
                        width: 200,
                      ),
                      const SizedBox(height: 50),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.email),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 2.0,
                              color: primary,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(width: 2.0, color: accent),
                              borderRadius: BorderRadius.circular(15)),
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
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.done,

                        // obscureText: passToggle ? false : true,
                        obscureText: passToggle,
                        keyboardType: TextInputType.emailAddress,
                        controller: passController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.lock),
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
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 2.0,
                              color: primary,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(width: 2.0, color: accent),
                              borderRadius: BorderRadius.circular(15)),
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
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const QuenMatKhau()));
                              //  showDialog(
                              //     barrierDismissible: false,
                              //     context: context,
                              //     builder: (context) => const QuenPass()
                              //   );
                            },
                            child: Text('Quên mật khẩu',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: screenWidth / 23,
                                  color: accent,
                                )),
                          ),
                        ),
                      ),
                      // TextButton(
                      //     onPressed: () async {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) =>
                      //                   const AddNewEmployeeScreen()));
                      //     },
                      //     child: Container(
                      //         decoration: BoxDecoration(
                      //           gradient: LinearGradient(
                      //               colors: [primary, secondary]),
                      //         ),
                      //         //padding: EdgeInsets.all(screenHeight * .04),
                      //         margin: EdgeInsets.symmetric(horizontal: 8),
                      //         child: Center(
                      //             child: Text(
                      //           "thêm nv",
                      //         )))),
                      const SizedBox(
                        height: 60,
                      ),
                      InkWell(
                        onTap: () async {
                          String email = emailController.text.trim();
                          String password = passController.text.trim();

                          if (email.isEmpty) {
                            Fluttertoast.showToast(
                              msg: "Không được để trống",
                            );
                            // ScaffoldMessenger.of(context)
                            //     .showSnackBar(const SnackBar(
                            //   content: Text("Email is still empty"),
                            // ));
                          } else if (password.isEmpty) {
                            Fluttertoast.showToast(
                              msg: "Không được để trống",
                            );
                            // ScaffoldMessenger.of(context)
                            //     .showSnackBar(const SnackBar(
                            //   content: Text("Password is still empty"),
                            // ));
                          } else {
                            FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passController.text)
                                .then((value) async => {
                                      sharedPreferences =
                                          await SharedPreferences.getInstance(),
                                      sharedPreferences
                                          .setString('email', email)
                                          .then((_) async {
                                        sharedPreferences =
                                            await SharedPreferences
                                                .getInstance();
                                        sharedPreferences
                                            .setString('email', email)
                                            .then((_) {
                                          Fluttertoast.showToast(
                                            msg: "Đăng nhập thành công",
                                          );
                                          //
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      emailController.text ==
                                                              "admin@gmail.com"
                                                          ? const HomeScreenAdmin()
                                                          : const HomeScreen()));
                                        });
                                      }).onError((error, stackTrace) {
                                        Fluttertoast.showToast(
                                          msg: "Login Fail",
                                        );
                                      })
                                    });
                          }

                          //.onError((error, stackTrace) => {
                          //   Fluttertoast.showToast(
                          //     msg: error.toString(),
                          //   )
                          // })
                          //
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
                            "ĐĂNG NHẬP",
                            style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      )
                    ]),
              ))),
    ));
  }
}
