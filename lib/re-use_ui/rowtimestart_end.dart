import 'package:flutter/material.dart';

import '../components/color.dart';

class RowTimeStart extends StatefulWidget {
  const RowTimeStart({Key? key}) : super(key: key);

  @override
  State<RowTimeStart> createState() => _RowTimeStartState();
}

class _RowTimeStartState extends State<RowTimeStart> {
  String textIn = 'Thời gian bắt đầu';
  IconData iconIn = Icons.alarm;
  IconData iconOut = Icons.alarm;
  String textOut = 'Thời gian kết thúc';
  TimeOfDay? firstTime;
  TimeOfDay? lastTime;
  IconData? firstIcon;
  IconData? lastIcon;

  Future<void> _selectDateFirst(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: firstTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != firstTime) {
      setState(() {
        firstTime = picked;
        firstIcon = Icons.close;
      });
    } else {
      firstIcon = Icons.alarm;
    }
  }

  Future<void> _selectDateLast(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: lastTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != lastTime) {
      setState(() {
        lastTime = picked;
        lastIcon = Icons.close;
      });
    } else {
      lastIcon = Icons.alarm;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Bắt đầu',
              style: TextStyle(color: primary),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: blue)),
              width: (2 / 3) * screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      _selectDateFirst(context);
                    },
                    child: Text(
                      firstTime == null
                          ? textIn
                          : '${firstTime!.hour}:${firstTime!.minute}'
                              .toString(),
                      style: const TextStyle(color: secondary),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        firstTime = null;
                      });
                    },
                    child: Icon(
                      (firstTime == null ? iconIn : firstIcon),
                      color: primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Kết thúc',
              style: TextStyle(color: primary),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: blue)),
              width: (2 / 3) * screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      _selectDateLast(context);
                    },
                    child: Text(
                      lastTime == null
                          ? textOut
                          : '${lastTime!.hour}:${lastTime!.minute}'.toString(),
                      style: const TextStyle(color: secondary),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        lastTime = null;
                      });
                    },
                    child: Icon(
                      (lastTime == null ? iconOut : lastIcon),
                      color: primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
