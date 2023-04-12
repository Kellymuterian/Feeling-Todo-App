// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:kelly_logistics/pages/home_page.dart';
// import 'package:kelly_logistics/pages/login_page.dart';
// import 'package:kelly_logistics/pages/register_page.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   bool isLoggedIn = false;

//   void _login() {
//     setState(() {
//       isLoggedIn = true;
//     });
//   }

//   void _logout() {
//     setState(() {
//       isLoggedIn = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'My APP',
//       initialRoute: "/",
//       home: isLoggedIn
//           ? const HomePage()
//           : LoginPage(
//               onLogin: _login,
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:kelly_logistics/data/controllers/user_controller.dart';
import 'package:kelly_logistics/test/homeScreen.dart';
import 'package:kelly_logistics/test/loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn() async {
    // check if token is there
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("user")) {
      UserController().getUserFromCache();
      setState(() {
        _isLoggedIn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _isLoggedIn ? Home() : LogIn(),
      ),
    );
  }
}
