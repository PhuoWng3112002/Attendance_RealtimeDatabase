//import 'package:attendance/widgets/rest_historyscreen.dart';

import 'package:attendance_application/components/color.dart';
import 'package:attendance_application/modal/country.dart';
import 'package:attendance_application/modal/room_meeting.dart';
import 'package:attendance_application/modal/user_modal.dart';
import 'package:attendance_application/re-use_ui/appbar.dart';
import 'package:attendance_application/screens/meeting_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// ignore: unused_import
import 'package:intl/intl.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

import '../re-use_ui/rowtimestart_end.dart';

class ThemLichHopMoi extends StatefulWidget {
  const ThemLichHopMoi({super.key});

  @override
  State<ThemLichHopMoi> createState() => _ThemLichHopMoiState();
}

class _ThemLichHopMoiState extends State<ThemLichHopMoi> {
  double screenheight = 0;
  double screenwidth = 0;
  List<UserModal> userList = [];
  List<String> developerTypes = ["Phòng 1", "Phòng 2", "Phòng 3", "Phòng 4"];
  String? selectedDeveloperType;

  Country? selectedDeveloperTypeWithCode;
  TextEditingController _nameController = TextEditingController();
  List? developerSkills;
  List? skills = [
    {
      "display": "example1@gmail.com",
      "value": "example1@gmail.com",
    },
    {
      "display": "tinh@gmail.com",
      "value": "tinh@gmail.com",
    },
    {
      "display": "thphg3112002@gmail.com",
      "value": "thphg3112002@gmail.com",
    },
    {
      "display": "phuong3@gmail.com",
      "value": "phuong3@gmail.com",
    },
    {
      "display": "example@gmail.com",
      "value": "example@gmail.com",
    },
    {
      "display": "phuong1@gmail.com",
      "value": "phuong1@gmail.com",
    },
    {
      "display": "thphg311@gmail.com",
      "value": "thphg311@gmail.com",
    },
    {
      "display": "moi1@gmail.com",
      "value": "moi@gmail.com",
    },
    {
      "display": "20a10010@gmail.com",
      "value": "20a10010@gmail.com",
    },
  ];

  // final _formfield = GlobalKey<FormState>();
  var titleController = new TextEditingController();
  var contentController = new TextEditingController();
  var timeController = new TextEditingController();
  var timeStartController = new TextEditingController();
  var timeEndController = new TextEditingController();
  var roomController = new TextEditingController();
  var memberEndController = new TextEditingController();
  late DatabaseReference databaseReference;
  FirebaseAuth auth = FirebaseAuth.instance;

  String textdefault = 'Chọn ngày';
  DateTime? dateChoose;
  IconData? iconChoose;
  IconData icondefault = Icons.arrow_drop_down;
  // List<Room> roomList = [];
  // String selectedClient = '0';
  String _month = DateFormat('dd/MM/yyyy').format(DateTime.now());
  String _timeStart = "Chọn thời gian bắt đầu";
  String _timeEnd = "Chọn thời gian kết thúc";
  String textIn = 'Thời gian bắt đầu';
  IconData iconIn = Icons.alarm;
  IconData iconOut = Icons.alarm;
  String textOut = 'Thời gian kết thúc';
  TimeOfDay? firstTime;
  TimeOfDay? lastTime;
  IconData? firstIcon;
  IconData? lastIcon;

  final refMeeting = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    databaseReference = FirebaseDatabase.instance.ref();
    // .child(uid!)
    // .child(DateFormat('dd MMMM yyyy').format(DateTime.now()));
    // String? emailUser = sharedPreferences.getString("email");
    // final snapshot = ref.child('users/${auth.currentUser?.uid}/email').get();
    retrieveUserData();
    selectedDeveloperType = developerTypes[0];
  }

  @override
  Widget build(BuildContext context) {
    screenwidth = MediaQuery.of(context).size.width;
    screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBarHistory(title1: 'Thêm lịch họp mới', context: context),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tiêu đề',
                    style: TextStyle(fontSize: 15, color: primary),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: blue)),
                    width: (2 / 3) * screenwidth,
                    child: TextFormField(
                      controller: titleController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: const TextStyle(
                        color: secondary,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Nhập tiêu đề...',
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Nội dung',
                    style: TextStyle(color: primary),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: blue)),
                    width: (2 / 3) * screenwidth,
                    height: 80,
                    child: TextFormField(
                      controller: contentController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: const TextStyle(
                        color: secondary,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Nhập nội dung...',
                        hintStyle: const TextStyle(color: grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              // const RowTime(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Chọn ngày',
                    style: TextStyle(
                      color: primary,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    width: screenwidth / 2,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: blue),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () async {
                              final month = await showDatePicker(
                                  context: context,
                                  initialDate: dateChoose ??
                                      DateTime(
                                          DateTime.now().year,
                                          DateTime.now().month,
                                          DateTime.now().day),
                                  firstDate: DateTime(
                                      DateTime.now().year,
                                      DateTime.now().month,
                                      DateTime.now().day + 2),
                                  lastDate: DateTime(2030),
                                  builder: ((context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme:
                                            const ColorScheme.highContrastLight(
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
                                  _month =
                                      DateFormat("dd/MM/yyyy").format(month);
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
                          // InkWell(
                          //   onTap: () {
                          //     setState(() {
                          //       dateChoose = null;
                          //     });
                          //   },
                          //   child: Icon(
                          //     (dateChoose == null
                          //         ? icondefault
                          //         : iconChoose),
                          //     color: Colors.black,
                          //   ),
                          // ),
                        ]),
                  ),
                ],
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     const Text('Thời gian', style: TextStyle(color: primary),),
              //      Container(
              //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: blue)),
              //       width: (2/3)*screenwidth,
              //       child:
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children:[
              //         Text( DateFormat('dd/MM/yyyy')
              //                           .format(DateTime.now()), style: const TextStyle(color: grey),),
              //         const Icon(Icons.calendar_month, color: primary,),
              //       ],),

              //      )
              //   ],
              // ),
              //
              // sh
              // owTimePicker(

              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Thời gian bắt đầu',
                    style: TextStyle(
                      color: primary,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    width: screenwidth / 2,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: blue),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () async {
                              final startTime = await showTimePicker(
                                  context: context,
                                  initialTime: firstTime ?? TimeOfDay.now(),
                                  builder: ((context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme:
                                            const ColorScheme.highContrastLight(
                                                background: primary,
                                                secondary: secondary,
                                                primary: primary,
                                                onSecondary: white),
                                      ),
                                      child: child!,
                                    );
                                  }));
                              if (startTime != null) {
                                // print(month);
                                setState(() {
                                  _timeStart =
                                      startTime.toString().substring(10, 15);
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
                              _timeStart,
                              // dateChoose == null
                              //     ? textdefault
                              //     : '${dateChoose!.day}/${dateChoose!.month}/${dateChoose!.year}'
                              //         .toString(),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                            ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     setState(() {
                          //       dateChoose = null;
                          //     });
                          //   },
                          //   child: Icon(
                          //     (dateChoose == null
                          //         ? icondefault
                          //         : iconChoose),
                          //     color: Colors.black,
                          //   ),
                          // ),
                        ]),
                  ),
                ],
              ),

              // const RowTimeStart(),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Thời gian kết thúc',
                    style: TextStyle(
                      color: primary,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    width: screenwidth / 2,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: blue),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () async {
                              final endTime = await showTimePicker(
                                  context: context,
                                  initialTime: lastTime ?? TimeOfDay.now(),
                                  builder: ((context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme:
                                            const ColorScheme.highContrastLight(
                                                background: primary,
                                                secondary: secondary,
                                                primary: primary,
                                                onSecondary: white),
                                      ),
                                      child: child!,
                                    );
                                  }));
                              if (endTime != null) {
                                // print(month);
                                setState(() {
                                  _timeEnd =
                                      endTime.toString().substring(10, 15);
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
                              _timeEnd,
                              // dateChoose == null
                              //     ? textdefault
                              //     : '${dateChoose!.day}/${dateChoose!.month}/${dateChoose!.year}'
                              //         .toString(),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                            ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     setState(() {
                          //       dateChoose = null;
                          //     });
                          //   },
                          //   child: Icon(
                          //     (dateChoose == null
                          //         ? icondefault
                          //         : iconChoose),
                          //     color: Colors.black,
                          //   ),
                          // ),
                        ]),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     const Text(
              //       'Phòng họp',
              //       style: TextStyle(color: primary),
              //     ),
              //     Container(
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10),
              //           border: Border.all(color: blue)),
              //       width: (2 / 3) * screenwidth,
              //       height: 80,
              //       child: TextFormField(
              //         controller: roomController,
              //         textInputAction: TextInputAction.done,
              //         keyboardType: TextInputType.multiline,
              //         maxLines: null,
              //         style: const TextStyle(
              //           color: secondary,
              //         ),
              //         decoration: InputDecoration(
              //           hintText: 'Chọn phòng họp...',
              //           hintStyle: const TextStyle(color: grey),
              //           border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(5),
              //             borderSide: BorderSide.none,
              //           ),
              //         ),
              //       ),
              //     )
              //   ],
              // ),
              // // StreamBuilder(
              // //   stream:FirebaseDatabase.instance
              // //           .ref('Room')
              // //           .onValue,
              // //   builder:((context, snapshot) {
              // //             return snapshot.hasData?
              // //              DropdownButton(items: [
              // //               for(var child in snapshot.data)
              // //               DropdownMenuItem(
              // //                 child:Text(child.data['name'],),
              // //               ),
              // //               value: child,
              // //             ],
              // //              onChanged: (value){}):Container();})
              // //              ),
              // // for (int i = 0; i < userList.length; i++)
              // // userWidget(userList[i]),

              // const SizedBox(
              //   height: 15,
              // ),
              // const Row(
              //   children: [
              //     Text(
              //       'Chọn người tham gia',
              //       textAlign: TextAlign.start,
              //       style: TextStyle(color: primary),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Container(
              //       alignment: Alignment.centerRight,
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: 10, vertical: 10),
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10),
              //           border: Border.all(color: blue)),
              //       width: (2 / 3) * screenwidth,
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.end,
              //         children: const [
              //           Icon(
              //             Icons.zoom_in,
              //             color: primary,
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 40,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Phòng họp',
                    style: TextStyle(color: primary),
                  ),
                  Container(
                    width: screenwidth / 1.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: blue)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          items: developerTypes.map((e) {
                            return DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: const TextStyle(color: secondary),
                                ));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedDeveloperType = value;
                            });
                          },
                          value: selectedDeveloperType,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: blue),
                    borderRadius: BorderRadius.circular(0)),
                child: MultiSelectFormField(
                  autovalidate: AutovalidateMode.disabled,
                  chipBackGroundColor: secondary,
                  chipLabelStyle: const TextStyle(
                      fontWeight: FontWeight.bold, color: white),
                  dialogTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold, color: secondary),
                  checkBoxActiveColor: white,
                  checkBoxCheckColor: accent,
                  dialogShapeBorder: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  title: const Text(
                    "Chọn người tham gia",
                    style: TextStyle(fontSize: 15, color: primary),
                  ),
                  dataSource: skills,
                  textField: 'display',
                  valueField: 'value',
                  okButtonLabel: 'OK',
                  cancelButtonLabel: 'CANCEL',
                  hintWidget: const Text('Please choose one or more'),
                  initialValue: developerSkills,
                  onSaved: (value) {
                    if (value == null) return;
                    setState(() {
                      developerSkills = value;
                    });
                    print("SELECTED SKILLS");
                    print(developerSkills);
                  },
                  border: InputBorder.none,
                ),
              ),

              // ChooseMeeting(),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 140,
                    height: 45,
                    child: ElevatedButton(
                        // style: ButtonStyle(backgroundColor: Colors.orange ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        onPressed: () {
                          titleController.clear();
                          contentController.clear();
                          timeController.clear();
                          timeStartController.clear();
                          timeEndController.clear();
                          roomController.clear();
                          memberEndController.clear();
                        },
                        child: const Text(
                          'HỦY',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  // SizedBox(
                  //   width: 140,
                  //   height: 45,
                  //   child: ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //           backgroundColor: primary,
                  //           shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(15))),
                  //       onPressed: () {},
                  //       child: const Text(
                  //         'HOÀN THÀNH',
                  //         style: TextStyle(fontWeight: FontWeight.bold),
                  //       )),
                  // )
                  InkWell(
                    onTap: () {
                      if (titleController.text.isNotEmpty &&
                          contentController.text.isNotEmpty) {
                        inputData(
                            titleController.text,
                            contentController.text,
                            _month.toString(),
                            _timeStart.toString(),
                            _timeEnd.toString(),
                            selectedDeveloperType!,
                            developerSkills!);
                        Fluttertoast.showToast(
                          msg: "Thêm thành công",
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LichHop()));
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
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  inputData(String title, String content, String date, String startTime,
      String endTime, String room, Object member) {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    refMeeting
        .child("Meeting")
        .child(uid.toString())
        .child(DateFormat('dd MMMM yyyy hh mm ss').format(DateTime.now()))
        .set({
      'title': title,
      'content': content,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'room': room,
      'userID': uid,
      'member': member,
    });
    titleController.clear();
    contentController.clear();
    // _month = "Chọn ngày";
    // _timeEnd = "Chọn thời gian kết thúc";
    // _timeStart = "Chọn thời gian bắt đầu";
  }

  //UI
  // String? selectedItem = '';
  void retrieveUserData() {
    databaseReference.child("User").onChildAdded.listen((data) {
      UserData userData = UserData.fromJson(data.snapshot.value as Map);
      UserModal userModal =
          UserModal(key: data.snapshot.key, userData: userData);
      userList.add(userModal);
      setState(() {});
    });
  }

  userWidget(UserModal userList) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Column(
          children: [Text(userList.userData.email!)],
        )
      ]),
    );
  }
}

class RowTime extends StatefulWidget {
  const RowTime({super.key});

  @override
  State<RowTime> createState() => _RowTimeState();
}

class _RowTimeState extends State<RowTime> {
  String textdefault = 'Chọn ngày';
  DateTime? dateChoose;
  IconData? iconChoose;
  IconData icondefault = Icons.calendar_month;
  Future<void> _selectDate(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateChoose ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
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
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Thời gian',
          style: TextStyle(color: primary),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: blue)),
          width: (2 / 3) * screenWidth,
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
                style: const TextStyle(color: secondary),
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
                color: primary,
              ),
            ),
          ]),
        ),
      ],
    );
  }
}

//
class ChooseMeeting extends StatefulWidget {
  const ChooseMeeting({super.key});

  @override
  State<ChooseMeeting> createState() => _ChooseMeetingState();
}

class _ChooseMeetingState extends State<ChooseMeeting> {
  List<String> developerTypes = ["Phòng 1", "Phòng 2", "Phòng 3", "Phòng 4"];
  String? selectedDeveloperType;

  // List<Country> developerTypesWithCodes = [
  //   Country('India', 'IN'),
  //   Country('Pakistan', 'PARK'),
  //   Country('Nepal', 'NEP'),
  //   Country('Srilanka', 'SL'),
  // ];

  Country? selectedDeveloperTypeWithCode;
  TextEditingController _nameController = TextEditingController();
  List? developerSkills;
  List? skills = [
    {
      "display": "example1@gmail.com",
      "value": "example1@gmail.com",
    },
    {
      "display": "tinh@gmail.com",
      "value": "tinh@gmail.com",
    },
    {
      "display": "thphg3112002@gmail.com",
      "value": "thphg3112002@gmail.com",
    },
    {
      "display": "phuong3@gmail.com",
      "value": "phuong3@gmail.com",
    },
    {
      "display": "example@gmail.com",
      "value": "example@gmail.com",
    },
    {
      "display": "phuong1@gmail.com",
      "value": "phuong1@gmail.com",
    },
    {
      "display": "thphg311@gmail.com",
      "value": "thphg311@gmail.com",
    },
    {
      "display": "moi1@gmail.com",
      "value": "moi@gmail.com",
    },
    {
      "display": "20a10010@gmail.com",
      "value": "20a10010@gmail.com",
    },
  ];

  @override
  void initState() {
    selectedDeveloperType = developerTypes[0];
    // selectedDeveloperTypeWithCode =developerTypesWithCodes[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        // Container(
        //   width: MediaQuery.of(context).size.width*0.6,
        //   child:
        //     TextField(
        //       decoration: const InputDecoration(
        //         hintText: "Enter developer name",
        //       ),
        //       controller: _nameController,
        //       onChanged: ((value) {
        //         print('NAME OF THE DEVELOPER ${value}');
        //       }),
        //     ),

        // ),
        // const SizedBox(height: 15,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Phòng họp',
              style: TextStyle(color: primary),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: blue)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    items: developerTypes.map((e) {
                      return DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: const TextStyle(color: secondary),
                          ));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDeveloperType = value;
                      });
                    },
                    value: selectedDeveloperType,
                  ),
                ),
              ),
            ),
          ],
        ),

        //add multipleselect from field here
        const SizedBox(
          height: 15,
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: blue),
              borderRadius: BorderRadius.circular(0)),
          child: MultiSelectFormField(
            autovalidate: AutovalidateMode.disabled,
            chipBackGroundColor: primary,
            chipLabelStyle:
                const TextStyle(fontWeight: FontWeight.bold, color: white),
            dialogTextStyle:
                const TextStyle(fontWeight: FontWeight.bold, color: secondary),
            checkBoxActiveColor: primary,
            checkBoxCheckColor: Colors.green,
            dialogShapeBorder: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            title: const Text(
              "Chọn người tham gia",
              style: TextStyle(fontSize: 15, color: primary),
            ),
            dataSource: skills,
            textField: 'display',
            valueField: 'value',
            okButtonLabel: 'OK',
            cancelButtonLabel: 'CANCEL',
            hintWidget: const Text('Please choose one or more'),
            initialValue: developerSkills,
            onSaved: (value) {
              if (value == null) return;
              setState(() {
                developerSkills = value;
              });
              print("SELECTED SKILLS");
              print(developerSkills);
            },
            border: InputBorder.none,
          ),
        ),
      ]),
    );
  }
}
