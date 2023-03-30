import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: 'Title'),
          ),
          SizedBox(height: 20),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(hintText: 'Description'),
            keyboardType: TextInputType.multiline,
            minLines: 3,
            maxLines: 10,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: SubmitData,
            child: Text('SUBMIT'),
          )
        ],
      ),
    );
  }

  Future<void> SubmitData() async {
    //Get the data from server
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      {
        "title": title,
        "description": description,
        "is_completed": false,
      }
    };
    //submit data to server
    const url = 'https://muterian.kimworks.buzz/api/todo';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-type': 'application/json'},
    );

    //show success or fail message based on status
    if (response.statusCode == 201) {
      titleController.text = '';
      descriptionController.text = '';
      showSuccessMessage('Creation Success');
    } else {
      showErrorMessage('Creation Failed');
    }
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
