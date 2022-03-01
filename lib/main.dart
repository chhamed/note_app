import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:note_app/home.dart';

void main()
{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([
    SystemUiOverlay.bottom, //This line is used for showing the bottom bar
  ]);
  runApp(const MyNoteApp());
}


class MyNoteApp extends StatefulWidget {
  const MyNoteApp({Key? key}) : super(key: key);

  @override
  _MyNoteAppState createState() => _MyNoteAppState();
}

class _MyNoteAppState extends State<MyNoteApp> {
  @override
  Widget build(BuildContext context) {
    return Home();
  }
}
