import 'package:flutter/material.dart';
import 'package:flutter_assignment_3/screens/wellcome_to_notes.dart';

class CreateANotes extends StatelessWidget {
  const CreateANotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF7E87E1),
      ),
      backgroundColor: const Color(0xFF7E87E1),
      body: SingleChildScrollView( // Added this widget to enable scrolling
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0), // Adding padding to avoid close edges
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Manage your \nDaily To Do",
                style: TextStyle(fontSize: 42, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/avatar.webp'),
                  radius: 150,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Without much worry just manage \n things as easy as a piece of cake',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 35),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WellComeToNotes()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                ),
                child: const Text(
                  'Create a Note',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
