import 'package:attendance_application/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import 'package:flutter/material.dart';
class NoticesLogout extends StatelessWidget {
  const NoticesLogout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Thông báo'),
      content: const Text('Bạn chắc chắn muốn đăng xuất?'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop(context);
          },
          child: const Text('Hủy'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            FirebaseAuth.instance.signOut().then((value) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            });
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
