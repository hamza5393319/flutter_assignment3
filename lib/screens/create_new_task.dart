import 'package:flutter/material.dart';

class CreateNewTask extends StatefulWidget {
  const CreateNewTask({super.key});

  @override
  State<CreateNewTask> createState() => _CreateNewTaskState();
}

class _CreateNewTaskState extends State<CreateNewTask> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _priority = "Medium";
  TimeOfDay? _fromTime;
  TimeOfDay? _toTime;

  // List to store multiple tasks
  final List<Map<String, String>> _tasks = [];

  void _selectFromTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _fromTime = picked;
      });
    }
  }

  void _selectToTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _toTime = picked;
      });
    }
  }

  void _submitTask() {
    if (_titleController.text.isNotEmpty && _descriptionController.text.isNotEmpty) {
      final task = {
        'title': _titleController.text,
        'description': _descriptionController.text,
        'from': _fromTime?.format(context) ?? '',
        'to': _toTime?.format(context) ?? '',
        'priority': _priority,
      };

      setState(() {
        _tasks.add(task);
      });

      // Clear inputs
      _titleController.clear();
      _descriptionController.clear();
      _fromTime = null;
      _toTime = null;
      _priority = "Medium";
    }
  }

  void _goToTaskListPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskListPage(
          tasks: _tasks,
          onUpdate: (index, updatedTask) {
            setState(() {
              _tasks[index] = updatedTask;
            });
          },
          onDelete: (index) {
            setState(() {
              _tasks.removeAt(index);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7E87E1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF7E87E1),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _goToTaskListPage,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Create new Task",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/mypic.jpeg'),
                    radius: 25,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("From"),
                      ElevatedButton(
                        onPressed: () => _selectFromTime(context),
                        child: Text(_fromTime != null ? _fromTime!.format(context) : "Select Time"),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("To"),
                      ElevatedButton(
                        onPressed: () => _selectToTime(context),
                        child: Text(_toTime != null ? _toTime!.format(context) : "Select Time"),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text("Title"),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              const SizedBox(height: 10),
              const Text("Description"),
              TextField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              const SizedBox(height: 20),
              const Text("Choose Priority"),
              Row(
                children: [
                  _buildPriorityButton("High", Colors.red),
                  const SizedBox(width: 10),
                  _buildPriorityButton("Medium", Colors.grey),
                  const SizedBox(width: 10),
                  _buildPriorityButton("Low", Colors.green),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _submitTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  ),
                  child: const Text("Add", style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityButton(String priority, Color color) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _priority = priority;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _priority == priority ? color : color.withOpacity(0.3),
      ),
      child: Text(priority, style: const TextStyle(color: Colors.black)),
    );
  }
}

class TaskListPage extends StatelessWidget {
  final List<Map<String, String>> tasks;
  final Function(int, Map<String, String>) onUpdate;
  final Function(int) onDelete;

  TaskListPage({required this.tasks, required this.onUpdate, required this.onDelete});

  void _confirmDeleteTask(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Task"),
          content: const Text("Are you sure you want to delete this task?"),
          actions: [
            TextButton(
              onPressed: () {
                onDelete(index);
                Navigator.of(context).pop();
              },
              child: const Text("Yes"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("No"),
            ),
          ],
        );
      },
    );
  }

  void _editTask(BuildContext context, int index) {
    final task = tasks[index];
    final TextEditingController titleController = TextEditingController(text: task['title']);
    final TextEditingController descriptionController = TextEditingController(text: task['description']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              final updatedTask = {
                'title': titleController.text,
                'description': descriptionController.text,
                'from': task['from'] ?? '',
                'to': task['to'] ?? '',
                'priority': task['priority'] ?? 'Medium',
              };
              onUpdate(index, updatedTask);
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks List"),
        backgroundColor: const Color(0xFF7E87E1),
      ),
      backgroundColor: const Color(0xFF7E87E1),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text("Title: ${task['title']}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Description: ${task['description']}"),
                  Text("From: ${task['from']}"),
                  Text("To: ${task['to']}"),
                  Text("Priority: ${task['priority']}"),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _editTask(context, index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _confirmDeleteTask(context, index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
