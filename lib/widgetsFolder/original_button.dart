import 'package:flutter/material.dart';

class OriginalButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color textColor;
  final Color bgColor;

  OriginalButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.textColor,
      required this.bgColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 60,
        width: double.infinity,
        child: RaisedButton(
            color: bgColor,
            onPressed: onPressed,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Text(text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 23,
                ))));
  }
}
