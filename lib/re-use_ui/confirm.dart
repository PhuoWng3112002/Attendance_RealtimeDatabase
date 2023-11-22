import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmButton extends StatefulWidget {
  @override
  _ConfirmButtonState createState() => _ConfirmButtonState();
}

class _ConfirmButtonState extends State<ConfirmButton> {
  String buttonText = 'Xác nhận';
  bool isConfirmed = false;

  void handleButtonPress() {
    setState(() {
      if (isConfirmed) {
        buttonText = 'Xác nhận';
      } else {
        buttonText = '\t\t\t\t\tĐã \nxác nhận';
      }
      // isConfirmed = !isConfirmed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
      ),
      onPressed: handleButtonPress,
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 12),
      ),
    );
  }
}
