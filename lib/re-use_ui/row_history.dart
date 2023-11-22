import 'package:attendance_application/components/color.dart';
import 'package:flutter/material.dart';

class RowHistory extends StatelessWidget {
  final String time;
  final String date;
  final String status;
  final String reasons;
  final IconData iconstatus;
  const RowHistory(
      {super.key,
      required this.time,
      required this.date,
      required this.status,
      required this.reasons,
      required this.iconstatus});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                primary,
                secondary,
                Color.fromARGB(255, 201, 210, 227),
              ],
            ),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
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
                time,
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: screenwidth / 23, color: Colors.white),
              ),
            ],
          ),
        ),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.insert_invitation,
                          color: Color(0xFF014282),
                          size: 24,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          date,
                          style: const TextStyle(
                              fontSize: 16, color: Color(0xFF014282)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          iconstatus,
                          color: const Color(0xFFfe8005),
                          size: 24,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          status,
                          style: const TextStyle(
                              color: Color(0xFFfe8005), fontSize: 16),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.text_snippet,
                      color: Color(0xFF014282),
                      size: 24,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      reasons,
                      style: const TextStyle(
                          fontSize: 16, color: Color(0xFF014282)),
                    ),
                  ],
                ),
              ],
            )),
      ],
    );
  }
}
