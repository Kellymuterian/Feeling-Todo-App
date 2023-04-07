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
      body: RefreshIndicator(
        onRefresh: fetchTodo,
        child: Visibility(
          visible: items.isNotEmpty,
          replacement: Center(
              child: Text(
            'No Todo Item',
            style: Theme.of(context).textTheme.headline2,
          )),
          child: ListView.builder(
            itemCount: items.length,
            padding: EdgeInsets.all(8),
            itemBuilder: (context, index) {
              final item = items[index] as Map;
              final id = item['id'].toString();
              return Card(
                child: ListTile(
                    leading: CircleAvatar(child: Text('${index + 1}')),
                    title: Text(item['title']),
                    subtitle: Text(item['description']),
                    trailing: PopupMenuButton(
                      onSelected: (value) {
                        if (value == 'edit') {
                          //open the edit page
                          navigateToEditPage(item);
                        } else if (value == 'delete') {
                          //delete and remove the item
                          deleteById(id);
                        }
                      },
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            child: Text('Edit'),
                            value: 'edit',
                          ),
                          PopupMenuItem(
                            child: Text('Delete'),
                            value: 'delete',
                          )
                        ];
                      },
                    )),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: navigateToAddPage, label: Text('Add Todo')),
    );
  }

  void navigateToEditPage(Map item) {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(todo: item),
    );
    Navigator.push(context, route);
  }

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(),
    );
    Navigator.push(context, route);
  }

  Future<void> deleteById(String id) async {
    //Delete the item
    final url = 'https://muterian.kimworks.buzz/api/todo/$id/delete';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      //Remove the Item

      // final filtered = items.where((element) => element['id'] != id).toList();
      // setState(() {
      //   items = filtered;
      // });
      fetchTodo();
    } else {
      //show error message

    }
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
    } else {
      //show error message
    }
  }
}
