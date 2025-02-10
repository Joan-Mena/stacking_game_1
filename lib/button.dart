import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {
  final child;

  Mybutton({this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.all(20),
          color: Colors.grey[900],
          child: Center(child: child),
        ),
      ),
    );
  }
}
