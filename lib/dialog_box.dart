import 'package:flutter/material.dart';

class DialogBox extends StatefulWidget {
  @override
  _DialogBoxState createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  @override
  Widget build(BuildContext context) {
    Center(
      child: SingleChildScrollView(
        child: Dialog(
          elevation: 10,
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.all(Radius.circular(10.0))
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 40, bottom: 40),
            child: Column(
              children: [

              ],
            ),
          ),
        ),
      ),
    );
  }
}
