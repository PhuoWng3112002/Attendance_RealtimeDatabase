import 'package:attendance_application/re-use_ui/appbar.dart';
import 'package:attendance_application/screens_by_admin/add_new_employee.dart';
import 'package:attendance_application/screens_by_admin/home_screen_by_admin.dart';
import 'package:attendance_application/screens_by_admin/worksheet_infor_employee.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../components/color.dart';

class HRScreen extends StatefulWidget {
  const HRScreen({super.key});

  @override
  State<HRScreen> createState() => _HRScreenState();
}

class _HRScreenState extends State<HRScreen> {
  final ref = FirebaseDatabase.instance.ref('User');

  double screenHeight = 0;
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(

        // appBar: AppBarHistory(title1: "Quản lý nhân viên", context: context),
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                "Quản lý nhân viên",
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
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: white,
            ),
            onPressed: () {
              // Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeScreenAdmin()));
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddNewEmployeeScreen()));
          },
          child: const Icon(Icons.add),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: FirebaseAnimatedList(
                  query: ref,
                  itemBuilder: (context, snapshot, animation, index) {
                    return ListTile(
                      title: Text(snapshot.child('fullname').value.toString()),
                      leading: Icon(Icons.account_circle),
                      subtitle: Text(snapshot.child('email').value.toString()),
                      trailing: Text(snapshot.child('sdt').value.toString()),
                      // Text(snapshot.child('sdt').value.toString()),
                      // onTap: () =>Dialog.
                    );
                  },
                ),
              )
            ])
        // Center(
        //   child: ListView.builder(
        //     itemCount: employee.length,
        //     itemBuilder: (context, index) {
        //       return ListTile(
        //         title: Text(employee[index]),
        //         leading: Text((index + 1).toString()),
        //         subtitle: Text(employeeEmail[index]),
        //         trailing: Text("0886127895"),
        //         onTap: () => Navigator.of(context).pushReplacement(
        //           MaterialPageRoute(
        //             builder: (context) => DetailEmployeeScreen(),
        //           ),
        //         ),
        //       );
        //     },
        //   ),
        // ),
        );
  }
}
