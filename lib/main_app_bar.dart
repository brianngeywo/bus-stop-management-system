import 'package:flutter/material.dart';

AppBar mainAppBar(String title) {
  return AppBar(
    title: Padding(
      padding: EdgeInsets.all(12.0),
      child: Text(title),
    ),
    backgroundColor: Colors.cyan[900],
  );
}
