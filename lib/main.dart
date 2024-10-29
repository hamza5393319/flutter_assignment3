import 'package:flutter/material.dart';
import 'package:flutter_assignment_3/screens/create_a_notes.dart';

void main(){
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CreateANotes(),
    );
  }
}
