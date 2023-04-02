import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kelly_logistics/pages/add_page.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List items = [];

  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo APP'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index] as Map;
          return ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(item['title']),
            subtitle: Text(item['description']),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: navigateToAddPage, label: Text('Add Todo')),
    );
  }

  void navigateToAddPage() {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(),
    );
    Navigator.push(context, route);
  }

  Future<void> fetchTodo() async {
    final url = 'https://muterian.kimworks.buzz/api/todo';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['Task'] as List;
      setState(() {
        items = result;
      });
      log(result.toString());
    } else {}
  }
}
