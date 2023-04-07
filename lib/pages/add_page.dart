// import 'dart:convert';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({super.key, this.todo});

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];
      titleController.text = title;
      descriptionController.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Todo' : 'Add Todo'),
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
            onPressed: isEdit ? updateData : submitData,
            child: Text(isEdit ? 'Update' : 'SUBMIT'),
          )
        ],
      ),
    );
  }

  Future<void> updateData() async {
    //Get the data from the form
    final todo = widget.todo;
    if (todo == null) {
      print('You cannot update without todo data');
      return;
    }
    final id = todo['id'];
    // final isCompleted = todo['is_completed'];
    final title = titleController.text;
    final description = descriptionController.text;

    //Create a map of the data to send to the server
    final data = {
      "title": title,
      "description": description,
      "is_completed": false,
    };

    //Submit the data to the server
    final url = 'https://muterian.kimworks.buzz/api/todo/$id/edit';
    final response = await http.put(
      Uri.parse(url),
      body: jsonEncode(data),
      headers: {'Content-type': 'application/json'},
    );

    //Show success or fail message based on status
    if (response.statusCode == 200) {
      titleController.text = '';
      descriptionController.text = '';
      showSuccessMessage('Updated Successfully');
    } else {
      showErrorMessage('Update failed');
    }
  }

  Future<void> submitData() async {
    //Get the data from the form
    final title = titleController.text;
    final description = descriptionController.text;

    //Create a map of the data to send to the server
    final data = {
      "title": title,
      "description": description,
      "is_completed": false,
    };

    //Submit the data to the server
    const url = 'https://muterian.kimworks.buzz/api/todo';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(data),
      headers: {'Content-type': 'application/json'},
    );

    //Show success or fail message based on status
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
