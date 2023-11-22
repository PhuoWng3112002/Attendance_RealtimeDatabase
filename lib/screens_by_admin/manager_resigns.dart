import 'package:attendance_application/components/color.dart';
import 'package:attendance_application/screens_by_admin/home_screen_by_admin.dart';
import 'package:flutter/material.dart';

class XinNghiDangCho extends StatelessWidget {
  const XinNghiDangCho({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 1,
          toolbarHeight: 70,
          backgroundColor: const Color(0xFF014282),
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
          title: const Text(
            'Quản lý xin nghỉ',
            style: TextStyle(color: Colors.white),
          ),
          shadowColor: Colors.white,
          elevation: 0,
          bottom: createTabBar(),
        ),

        body: const TabBarView(
          children: [
            HistoryDangcho(),
            HistoryDaDuyet(),
            HistoryTuChoi(),
          ],
        ),
        // _buildBody(context),
      ),
    );
  }

  TabBar createTabBar() {
    return TabBar(
      indicator: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(50),
        color: Colors.orange,
      ),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      tabs: const [
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Text(
            "Đang chờ",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Text(
            "Đã duyệt",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Text(
            "Từ chối",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
      ],
      isScrollable: true,
    );
  }
}

class HistoryDangcho extends StatefulWidget {
  const HistoryDangcho({super.key});

  @override
  State<HistoryDangcho> createState() => _HistoryDangchoState();
}

class _HistoryDangchoState extends State<HistoryDangcho> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      child: Column(
        children: [
          Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF014282),
                      Color.fromARGB(255, 17, 129, 221),
                      Color.fromARGB(255, 201, 210, 227),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  color: Colors.blue,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Buổi chiều, Thứ 6, 11/08/2023',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: screenwidth / 23,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.account_circle,
                                color: Color(0xFF014282),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                '08877766',
                                style: TextStyle(
                                    color: Colors.deepOrange, fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.insert_invitation,
                                color: Color(0xFF014282),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                '18/08/2023',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.text_snippet,
                                color: Color(0xFF014282),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Lí do cá nhân',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 35,
                            width: 90,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text(
                                'Duyệt',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 35,
                            width: 90,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text(
                                'Từ chối',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                            ),
                          ),
                        ],
                      ),
                      /*
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        
                        children: [
                          Row(
                
                            children: const [
                              Icon(Icons.insert_invitation, color: Color(0xFF014282),size: 24,),
                              SizedBox(width: 8,),
                              Text('08877766', style: TextStyle(fontSize: 16, color: Color(0xFF014282)),),
                            ],
                            ),
                          Row(
                            children:const  [
                              Icon(Icons.rotate_left_rounded, color: Color(0xFFfe8005), size: 24,),
                              SizedBox(width: 8,),
                              Text('Đang chờ', style: TextStyle(color: Color(0xFFfe8005), fontSize: 16),)
                            ],
                          ),
                        ],
                      
                      ),

                      const SizedBox(height: 10,),
                       Row(
                        children: const [
                          Icon(Icons.text_snippet, color: Color(0xFF014282), size: 24,),
                          SizedBox(width: 8,),
                          Text('Lí do cá nhân', style: TextStyle(fontSize: 16, color: Color(0xFF014282)),),
                        ],
                        ),
                        */
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

class HistoryDaDuyet extends StatefulWidget {
  const HistoryDaDuyet({super.key});

  @override
  State<HistoryDaDuyet> createState() => _HistoryDaDuyetState();
}

class _HistoryDaDuyetState extends State<HistoryDaDuyet> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      child: Column(
        children: [
          Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF014282),
                      Color.fromARGB(255, 17, 129, 221),
                      Color.fromARGB(255, 201, 210, 227),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  color: Colors.blue,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Buổi chiều, Thứ 6, 11/08/2023',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: screenwidth / 23,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.account_circle,
                                color: Color(0xFF014282),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                '08877766',
                                style: TextStyle(
                                    color: Colors.deepOrange, fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.insert_invitation,
                                color: Color(0xFF014282),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                '18/08/2023',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.text_snippet,
                                color: Color(0xFF014282),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Lí do cá nhân',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Đã duyệt',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      /*
                      Column(
                        
                        children: [
                          
                          SizedBox(
                            height: 35,
                            width: 90,
                            child: ElevatedButton(
                              onPressed: (){}, 
                              
                              child: const Text('Da Duyệt', style: TextStyle(fontWeight: FontWeight.bold),),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green, 
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          
                                ),
                              ),
                          ),
                          const SizedBox(height: 10,),
                          SizedBox(
                            height: 35,
                            width: 90,
                            child: ElevatedButton(
                              onPressed: (){}, 
                              child: Text('Từ chối', style: TextStyle(fontWeight: FontWeight.bold),),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                              ),
                          ),
                        ],
                      ),
                      */
                      /*
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        
                        children: [
                          Row(
                
                            children: const [
                              Icon(Icons.insert_invitation, color: Color(0xFF014282),size: 24,),
                              SizedBox(width: 8,),
                              Text('08877766', style: TextStyle(fontSize: 16, color: Color(0xFF014282)),),
                            ],
                            ),
                          Row(
                            children:const  [
                              Icon(Icons.rotate_left_rounded, color: Color(0xFFfe8005), size: 24,),
                              SizedBox(width: 8,),
                              Text('Đang chờ', style: TextStyle(color: Color(0xFFfe8005), fontSize: 16),)
                            ],
                          ),
                        ],
                      
                      ),

                      const SizedBox(height: 10,),
                       Row(
                        children: const [
                          Icon(Icons.text_snippet, color: Color(0xFF014282), size: 24,),
                          SizedBox(width: 8,),
                          Text('Lí do cá nhân', style: TextStyle(fontSize: 16, color: Color(0xFF014282)),),
                        ],
                        ),
                        */
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

class HistoryTuChoi extends StatefulWidget {
  const HistoryTuChoi({super.key});

  @override
  State<HistoryTuChoi> createState() => _HistoryTuChoiState();
}

class _HistoryTuChoiState extends State<HistoryTuChoi> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      child: Column(
        children: [
          Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF014282),
                      Color.fromARGB(255, 17, 129, 221),
                      Color.fromARGB(255, 201, 210, 227),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  color: Colors.blue,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Buổi chiều, Thứ 6, 11/08/2023',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: screenwidth / 23,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.account_circle,
                                color: Color(0xFF014282),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                '08877766',
                                style: TextStyle(
                                    color: Colors.deepOrange, fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.insert_invitation,
                                color: Color(0xFF014282),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                '18/08/2023',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.text_snippet,
                                color: Color(0xFF014282),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Lí do cá nhân',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.dangerous,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Từ chối',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      /*
                      Column(
                        
                        children: [
                          
                          SizedBox(
                            height: 35,
                            width: 90,
                            child: ElevatedButton(
                              onPressed: (){}, 
                              
                              child: const Text('Da Duyệt', style: TextStyle(fontWeight: FontWeight.bold),),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green, 
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          
                                ),
                              ),
                          ),
                          const SizedBox(height: 10,),
                          SizedBox(
                            height: 35,
                            width: 90,
                            child: ElevatedButton(
                              onPressed: (){}, 
                              child: Text('Từ chối', style: TextStyle(fontWeight: FontWeight.bold),),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                              ),
                          ),
                        ],
                      ),
                      */
                      /*
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        
                        children: [
                          Row(
                
                            children: const [
                              Icon(Icons.insert_invitation, color: Color(0xFF014282),size: 24,),
                              SizedBox(width: 8,),
                              Text('08877766', style: TextStyle(fontSize: 16, color: Color(0xFF014282)),),
                            ],
                            ),
                          Row(
                            children:const  [
                              Icon(Icons.rotate_left_rounded, color: Color(0xFFfe8005), size: 24,),
                              SizedBox(width: 8,),
                              Text('Đang chờ', style: TextStyle(color: Color(0xFFfe8005), fontSize: 16),)
                            ],
                          ),
                        ],
                      
                      ),

                      const SizedBox(height: 10,),
                       Row(
                        children: const [
                          Icon(Icons.text_snippet, color: Color(0xFF014282), size: 24,),
                          SizedBox(width: 8,),
                          Text('Lí do cá nhân', style: TextStyle(fontSize: 16, color: Color(0xFF014282)),),
                        ],
                        ),
                        */
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
