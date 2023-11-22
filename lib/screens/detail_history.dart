import 'package:attendance_application/re-use_ui/appbar.dart';
import 'package:attendance_application/re-use_ui/button.dart';
import 'package:attendance_application/screens/rest_history.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../components/color.dart';

class DetailHistory extends StatefulWidget {
  const DetailHistory({super.key});

  @override
  State<DetailHistory> createState() => _DetailHistoryState();
}

class _DetailHistoryState extends State<DetailHistory> {
  String _month = "Chọn ngày";

  List<String> items = [
    'Cả ngày',
    'Buổi sáng',
    'Buổi chiều',
  ];

  String? selectedItem = 'Cả ngày';

  String textdefault = 'Chọn ngày';
  DateTime? dateChoose;
  IconData? iconChoose;
  IconData icondefault = Icons.arrow_drop_down;
  var reasonController = new TextEditingController();

  final refHistory = FirebaseDatabase.instance.ref();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBarHistory(title1: 'Đơn xin nghỉ phép', context: context),
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   leading: IconButton(
        //     onPressed: (){Navigator.pop(context);},
        //     icon: const Icon(Icons.arrow_back_ios, color: Color(0XFF014282),)
        //     ),
        //     title: const Text('Đơn xin nghỉ phép', style: TextStyle(color: Color(0xFF014282), fontWeight: FontWeight.bold),),
        //     shadowColor: Colors.white,
        //     elevation: 0,
        //     ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.text_snippet,
                        size: screenheight / 23,
                        color: const Color(0XFF014282)),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Lý do bạn nghỉ là gì?',
                      style: TextStyle(
                        fontSize: screenwidth / 23,
                        color: const Color(0XFF014282),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 222, 226, 229),
                  ),
                  child: TextFormField(
                    controller: reasonController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Vui lòng nhập...',
                      hintStyle: TextStyle(
                          fontSize: screenwidth / 23, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(Icons.insert_invitation,
                        size: screenheight / 23,
                        color: const Color(0XFF014282)),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Bạn nghỉ trong bao lâu?',
                      style: TextStyle(
                          fontSize: screenwidth / 23,
                          color: const Color(0XFF014282)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 15),
                    width: double.infinity,
                    height: 150,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 222, 226, 229),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Chọn buổi',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                    border: Border.all(color: grey),
                                    borderRadius: BorderRadius.circular(10)),
                                child: DropdownButton<String>(
                                  dropdownColor: grey,
                                  underline: const SizedBox(),
                                  icon: const Icon(Icons.arrow_drop_down),
                                  value: selectedItem,
                                  onChanged: (newValue) =>
                                      setState(() => selectedItem = newValue),
                                  items: items
                                      .map((valueItem) =>
                                          DropdownMenuItem<String>(
                                              value: valueItem,
                                              child: Text(
                                                valueItem,
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              )))
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Chọn ngày'),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              width: 125,
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(color: grey),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        final month = await showDatePicker(
                                            context: context,
                                            initialDate: dateChoose ??
                                                DateTime(
                                                    DateTime.now().year,
                                                    DateTime.now().month,
                                                    DateTime.now().day + 2),
                                            firstDate: DateTime(
                                                DateTime.now().year,
                                                DateTime.now().month,
                                                DateTime.now().day + 2),
                                            lastDate: DateTime(2030),
                                            builder: ((context, child) {
                                              return Theme(
                                                data:
                                                    Theme.of(context).copyWith(
                                                  colorScheme: const ColorScheme
                                                      .highContrastLight(
                                                      background: primary,
                                                      secondary: secondary,
                                                      primary: primary,
                                                      onSecondary: white),
                                                ),
                                                child: child!,
                                              );
                                            }));
                                        if (month != null) {
                                          // print(month);
                                          setState(() {
                                            _month = DateFormat("dd/MM/yyyy")
                                                .format(month);
                                          });
                                        }
                                        // _selectDate(context);
                                        // Future<void> _selectDate(
                                        //     context) async {
                                        //   final DateTime? picked =
                                        //       await showDatePicker(
                                        //     context: context,
                                        //     initialDate: dateChoose ??
                                        //         DateTime(
                                        //             DateTime.now().year,
                                        //             DateTime.now().month,
                                        //             DateTime.now().day + 2),
                                        //     firstDate: DateTime(
                                        //         DateTime.now().year,
                                        //         DateTime.now().month,
                                        //         DateTime.now().day + 2),
                                        //     lastDate: DateTime(2030),
                                        //   );
                                        //   if (picked != null) {
                                        //     setState(() {
                                        //       dateChoose = picked;
                                        //       iconChoose = Icons.close;
                                        //     });
                                        //   } else {
                                        //     iconChoose = Icons.calendar_month;
                                        //   }
                                        // }
                                      },
                                      child: Text(
                                        _month,
                                        // dateChoose == null
                                        //     ? textdefault
                                        //     : '${dateChoose!.day}/${dateChoose!.month}/${dateChoose!.year}'
                                        //         .toString(),
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          dateChoose = null;
                                        });
                                      },
                                      child: Icon(
                                        (dateChoose == null
                                            ? icondefault
                                            : iconChoose),
                                        color: Colors.black,
                                      ),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                        // DropDownTest(),
                        // RowChooseDateApp(),

                        //const RowTest(),

                        //  Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //    children: [
                        //     const Text('Chọn buổi'),
                        //      Container(
                        //       padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        //       decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey), borderRadius: BorderRadius.circular(10)),
                        //        child: Row(
                        //          children: [
                        //            InkWell(
                        //             child: const Text('Cả ngày'),
                        //             onTap: () {

                        //             },
                        //            // onTap: (){const DropdownMenuExample();},

                        //            ),
                        //            const InkWell(
                        //             child: Icon(Icons.arrow_drop_down),
                        //           //  onTap: (){const DropdownMenuExample();},
                        //            ),
                        //          ],
                        //        ),
                        //      ),
                        //    ],
                        //  ),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: const [

                        //     Text('Chọn buổi'),
                        //     DropDownTest(),

                        //  // DropdownMenuExample(),

                        //   ],
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: const  [
                        //   Text('Chọn ngày'),
                        //  // DropdownMenuExample(),
                        // ],)
                      ],
                    )),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonApp(
                      title: 'HỦY',
                      color: Colors.orange,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const History()));
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    // ButtonApp(
                    //   title: 'HOÀN THÀNH đi mà',
                    //   color: const Color(0xFF166094),
                    //   onPressed: () {
                    //     inputData(reasonController.text, " selectedItem!",
                    //         " _month.toString()");
                    //   },
                    // ),
                    InkWell(
                      onTap: () {
                        if (reasonController.text.isNotEmpty) {
                          inputData(reasonController.text, selectedItem!,
                              _month.toString());
                          Fluttertoast.showToast(
                            msg: "Thêm thành công",
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const History()));
                        } else {
                          Fluttertoast.showToast(msg: "Không được để trống");
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: screenheight * 0.060,
                        width: screenwidth / 2.65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                            colors: [secondary, primary],
                          ),
                        ),
                        child: const Text(
                          "HOÀN THÀNH",
                          style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    )
// selectedItem!,
//                             _month.toString())
                    // SizedBox(
                    //   width: 140,
                    //   height: 45,
                    //   child: ElevatedButton(
                    //     style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF166094), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                    //     onPressed: (){}, child: const Text('HOÀN THÀNH', style: TextStyle(fontWeight: FontWeight.bold),)),
                    // )
                  ],
                )
              ],
            ),
          ),
        ));
  }

  inputData(String reason, String session, String date) {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    refHistory
        .child("Absent")
        .child(uid.toString())
        .child(DateFormat('dd MMMM yyyy').format(DateTime.now()))
        .set({
      'reason': reason,
      'session': session,
      'date': date,
      'state': "Đang chờ",
      'userID': uid,
    });
    reasonController.clear();
    selectedItem = "Cả ngày";
    _month = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }
}

// const List<String> list = <String>['Cả ngày', 'Buổi sáng', 'Buổi chiều',];

// Widget _buildBody(context) {
//   var reasonController = new TextEditingController();

//   double screenwidth = MediaQuery.of(context).size.width;
//   double screenheight = MediaQuery.of(context).size.height;
//   return
//   SingleChildScrollView(
//     child: Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Icon(Icons.text_snippet,
//                   size: screenheight / 23, color: const Color(0XFF014282)),
//               const SizedBox(
//                 width: 10,
//               ),
//               Text(
//                 'Lý do bạn nghỉ là gì?',
//                 style: TextStyle(
//                   fontSize: screenwidth / 23,
//                   color: const Color(0XFF014282),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           Container(
//             width: double.infinity,
//             height: 150,
//             decoration: const BoxDecoration(
//               color: Color.fromARGB(255, 222, 226, 229),
//             ),
//             child: TextFormField(
//               controller: reasonController,
//               textInputAction: TextInputAction.done,
//               keyboardType: TextInputType.multiline,
//               maxLines: null,
//               style: const TextStyle(
//                 color: Colors.black,
//               ),
//               decoration: InputDecoration(
//                 hintText: 'Vui lòng nhập...',
//                 hintStyle:
//                     TextStyle(fontSize: screenwidth / 23, color: Colors.black),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Row(
//             children: [
//               Icon(Icons.insert_invitation,
//                   size: screenheight / 23, color: const Color(0XFF014282)),
//               const SizedBox(
//                 width: 10,
//               ),
//               Text(
//                 'Bạn nghỉ trong bao lâu?',
//                 style: TextStyle(
//                     fontSize: screenwidth / 23, color: const Color(0XFF014282)),
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           Container(
//               padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
//               width: double.infinity,
//               height: 150,
//               decoration: const BoxDecoration(
//                 color: Color.fromARGB(255, 222, 226, 229),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             'Chọn buổi',
//                             style: TextStyle(
//                               fontSize: 14,
//                             ),
//                           ),
//                           Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 16),
//                             decoration: BoxDecoration(
//                                 border: Border.all(color: grey),
//                                 borderRadius: BorderRadius.circular(10)),
//                             child: DropdownButton<String>(
//                               dropdownColor: grey,
//                               underline: const SizedBox(),
//                               icon: const Icon(Icons.arrow_drop_down),
//                               value: selectedItem,
//                               onChanged: (newValue) => setState(() => selectedItem = newValue),
//                               items: items
//                                   .map((valueItem) => DropdownMenuItem<String>(
//                       value: valueItem,
//                       child: Text(
//                         valueItem,
//                         style: const TextStyle(fontSize: 14),
//                       )))
//                                   .toList(),
//                             ),
//                           ),
//                         ],
//                       ),
//                   )
//                   // DropDownTest(),
//                   // RowChooseDateApp(),

//                   //const RowTest(),

//                   //  Row(
//                   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //    children: [
//                   //     const Text('Chọn buổi'),
//                   //      Container(
//                   //       padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
//                   //       decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey), borderRadius: BorderRadius.circular(10)),
//                   //        child: Row(
//                   //          children: [
//                   //            InkWell(
//                   //             child: const Text('Cả ngày'),
//                   //             onTap: () {

//                   //             },
//                   //            // onTap: (){const DropdownMenuExample();},

//                   //            ),
//                   //            const InkWell(
//                   //             child: Icon(Icons.arrow_drop_down),
//                   //           //  onTap: (){const DropdownMenuExample();},
//                   //            ),
//                   //          ],
//                   //        ),
//                   //      ),
//                   //    ],
//                   //  ),

//                   // Row(
//                   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //   children: const [

//                   //     Text('Chọn buổi'),
//                   //     DropDownTest(),

//                   //  // DropdownMenuExample(),

//                   //   ],
//                   // ),
//                   // Row(
//                   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //   children: const  [
//                   //   Text('Chọn ngày'),
//                   //  // DropdownMenuExample(),
//                   // ],)
//                 ],
//               )),
//           const SizedBox(
//             height: 15,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ButtonApp(
//                 title: 'HỦY',
//                 color: Colors.orange,
//                 onPressed: () {
//                   reasonController.clear;
//                 },
//               ),
//               const SizedBox(
//                 width: 20,
//               ),
//               ButtonApp(
//                 title: 'HOÀN THÀNH',
//                 color: const Color(0xFF166094),
//                 onPressed: () {
//                   inputData();
//                 },
//               ),

//               // SizedBox(
//               //   width: 140,
//               //   height: 45,
//               //   child: ElevatedButton(
//               //     style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF166094), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
//               //     onPressed: (){}, child: const Text('HOÀN THÀNH', style: TextStyle(fontWeight: FontWeight.bold),)),
//               // )
//             ],
//           )
//         ],
//       ),
//     ),
//   );
// }

// class DropDownTest extends StatefulWidget {
//   const DropDownTest({super.key});

//   @override
//   State<DropDownTest> createState() => _DropDownTestState();
// }

// class _DropDownTestState extends State<DropDownTest> {
//   // List<String> items = [
//   //   'Cả ngày',
//   //   'Buổi sáng',
//   //   'Buổi chiều',
//   // ];
//   // String? selectedItem = 'Cả ngày';
//   @override
//   Widget build(BuildContext context) {
//     return
//     // Row(
//     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //   children: [
//     //     const Text(
//     //       'Chọn buổi',
//     //       style: TextStyle(
//     //         fontSize: 14,
//     //       ),
//     //     ),
//     //     Container(
//     //       padding: const EdgeInsets.symmetric(horizontal: 16),
//     //       decoration: BoxDecoration(
//     //           border: Border.all(color: grey),
//     //           borderRadius: BorderRadius.circular(10)),
//     //       child: DropdownButton<String>(
//     //         dropdownColor: grey,
//     //         underline: const SizedBox(),
//     //         icon: const Icon(Icons.arrow_drop_down),
//     //         value: selectedItem,
//     //         onChanged: (newValue) => setState(() => selectedItem = newValue),
//     //         items: items
//     //             .map((valueItem) => DropdownMenuItem<String>(
//     //                 value: valueItem,
//     //                 child: Text(
//     //                   valueItem,
//     //                   style: const TextStyle(fontSize: 14),
//     //                 )))
//     //             .toList(),
//     //       ),
//     //     ),
//     //   ],
//     // );
//   }
// }
// /*
// class DropdownMenuExample extends StatefulWidget {
//   const DropdownMenuExample({super.key});

//   @override
//   State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
// }

// class _DropdownMenuExampleState extends State<DropdownMenuExample> {
//   String dropdownValue = list.first;

//   @override
//   Widget build(BuildContext context) {
//     return DropdownMenu<String>(
//       initialSelection: list.first,
//       onSelected: (String? value) {
//         // This is called when the user selects an item.
//         setState(() {
//           dropdownValue = value!;
//         });
//       },
//       dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
//         return DropdownMenuEntry<String>(value: value, label: value);
//       }).toList(),
//     );
//   }
// }

/*

class RowTest extends StatefulWidget {
  const RowTest({super.key});

  @override
  State<RowTest> createState() => _RowTestState();
}

class _RowTestState extends State<RowTest> {
  List<String> items = ['Cả ngày', 'Buổi sáng', 'Buổi chiều',];
  String textdefault = 'Cả ngày';
  DateTime? dateChoose;
  IconData? iconChoose;
  IconData icondefault = Icons.expand_circle_down;
  Future<void> _selectDate(context) async {
    final DateTime? picked = await showDatePicker(
      context: context, 
      initialDate: dateChoose??DateTime.now(), 
      firstDate: DateTime(1990), 
      lastDate: DateTime.now(),
      );
    if(picked!=null) {
      setState(() {
        dateChoose = picked;
        iconChoose = Icons.close;
      });
    }
    else {
      iconChoose = Icons.calendar_month;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Chọn buổi', style: TextStyle(color: Colors.black, fontSize: 16),),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 130,
          height: 35,
          decoration:  BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: grey) ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: (){_selectDate(context);},
                child: Text(dateChoose == null ? textdefault : '${dateChoose!.day}/${dateChoose!.month}/${dateChoose!.year}'.toString(), style: const TextStyle(color: Colors.black, fontSize: 16),),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    dateChoose = null;
                  });
                },
                child: Icon((dateChoose == null ? icondefault : iconChoose), color: Colors.black,),
              ),
            ]
            ),
        ),
      ],
    );
  }
}
*/

class RowChooseDateApp extends StatefulWidget {
  const RowChooseDateApp({super.key});

  @override
  State<RowChooseDateApp> createState() => _RowChooseDateAppState();
}

class _RowChooseDateAppState extends State<RowChooseDateApp> {
  String textdefault = 'Chọn ngày';
  DateTime? dateChoose;
  IconData? iconChoose;
  IconData icondefault = Icons.arrow_drop_down;

  Future<void> _selectDate(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateChoose ??
          DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2),
      firstDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 2),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        dateChoose = picked;
        iconChoose = Icons.close;
      });
    } else {
      iconChoose = Icons.calendar_month;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Chọn ngày'),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          width: 125,
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(color: grey),
              borderRadius: BorderRadius.circular(10)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            InkWell(
              onTap: () {
                _selectDate(context);
              },
              child: Text(
                dateChoose == null
                    ? textdefault
                    : '${dateChoose!.day}/${dateChoose!.month}/${dateChoose!.year}'
                        .toString(),
                style: const TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  dateChoose = null;
                });
              },
              child: Icon(
                (dateChoose == null ? icondefault : iconChoose),
                color: Colors.black,
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
