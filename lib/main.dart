import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:kelly_logistics/pages/home_page.dart';
import 'package:kelly_logistics/pages/login_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Get.lazyPut(() => DataController());
    // loadData();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My APP',
      initialRoute: "/",
      home: FirebaseAuth.instance.currentUser != null
          ? const HomePage()
          : const LoginPage(),
    );
  }
}
//quicktype