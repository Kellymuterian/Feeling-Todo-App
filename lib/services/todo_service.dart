import 'dart:convert';

import 'package:http/http.dart' as http;

//All todo api will be here
class TodoService {
  static Future<bool> deleteById(String id) async {
    final url = 'https://muterian.kimworks.buzz/api/todo/$id/delete';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    return response.statusCode == 200;
  }

  static Future<List?> fetchTodos() async {
    final url = 'https://muterian.kimworks.buzz/api/todo';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      return result;
    } else {
      return null;
    }
  }

  static Future<bool> updateTodo(String id, Map body) async {
    final url = 'https://muterian.kimworks.buzz/api/todo/$id';
    final response = await http.put(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: {'Content-type': 'application/json'},
    );
    return response.statusCode == 200;
  }

  static Future<bool> addTodo(Map body) async {
    const url = 'https://muterian.kimworks.buzz/api/todo';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: {'Content-type': 'application/json'},
    );
    return response.statusCode == 200;
  }
}
