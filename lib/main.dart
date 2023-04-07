import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelly_logistics/pages/home_page.dart';
import 'package:kelly_logistics/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;

  void _login() {
    setState(() {
      isLoggedIn = true;
    });
  }

  void _logout() {
    setState(() {
      isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My APP',
      initialRoute: "/",
      home: HomePage(),
      // home: isLoggedIn
      //     ? const HomePage()
      //     : LoginPage(
      //         onLogin: _login,
      //       ),
    );
  }
}

//quicktype