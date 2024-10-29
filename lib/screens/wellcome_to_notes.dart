import 'package:flutter/material.dart';
import 'package:flutter_assignment_3/screens/create_new_task.dart';

class WellComeToNotes extends StatefulWidget {
  const WellComeToNotes({super.key});

  @override
  State<WellComeToNotes> createState() => _WellComeToNotesState();
}

class _WellComeToNotesState extends State<WellComeToNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7E87E1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF7E87E1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome to Notes",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                SizedBox(height: 5),
                    Text(
                      "Have a great Day",
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  ],
                ),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/mypic.jpeg'),
                  radius: 30,
                ),
              ],
            ),
           const SizedBox(height: 20),
           const Text(
              "My Priority Task",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
           const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Card(
                    color: Colors.white.withOpacity(0.8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Padding(
                      padding:  EdgeInsets.all(16.0),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("2 hours Ago", style: TextStyle(color: Colors.grey)),
                          SizedBox(height: 10),
                          Text(
                            "Mobile App UI Design",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("using Figma and other tools"),
                        ],
                      ),
                    ),
                  ),
                ),
               const SizedBox(width: 10),
                Expanded(
                  child: Card(
                    color: Colors.white.withOpacity(0.8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Padding(
                      padding:  EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("4 hours Ago", style: TextStyle(color: Colors.grey)),
                          SizedBox(height: 10),
                          Text(
                            "Capture Sun Rise Shots",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("complete GuruShot Challenge"),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
           const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "My Tasks",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add_circle, color: Colors.green, size: 40),
                    onPressed: () {
                     Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateNewTask(),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
           const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Today's Task", style: TextStyle(color: Colors.black)),
                Text("Weekly Task", style: TextStyle(color: Colors.black54)),
                Text("Monthly Task", style: TextStyle(color: Colors.black54)),
              ],
            ),
           const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildTaskItem("Complete Assignment #2", "13 September 2022", "To do"),
                  _buildTaskItem("Submit Fee Challange", "18 September 2022", "Done"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskItem(String title, String date, String status) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(date),
        trailing: Container(
          padding:const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: status == "Done" ? Colors.green.withOpacity(0.2) : Colors.blue.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: status == "Done" ? Colors.green : Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
