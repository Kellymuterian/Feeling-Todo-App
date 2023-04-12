import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  final String _url = 'https://muterian.kimworks.buzz/api/';

  postData(data, apiUrl) async {
    var fullUrl = Uri.parse('$_url$apiUrl')
        .replace(queryParameters: {'token': _getToken().toString()});
    return await http.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiUrl) async {
    var fullUrl = Uri.parse('$_url$apiUrl')
        .replace(queryParameters: {'token': _getToken().toString()});
    return await http.get(fullUrl, headers: _setHeaders());
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return Uri.parse('$_url?token=$token');
  }
}
