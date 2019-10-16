import 'package:flutter/material.dart';
import 'package:video_with_subtitles/views/list_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromRGBO(47, 169, 214, 1)
        ),
      home: ListPage(),
    );
  }
}