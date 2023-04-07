import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:kelly_logistics/pages/register_page.dart';
import 'home_page.dart';
import 'user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required void Function() onLogin})
      : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controllers
  final _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _signIn() async {
    final url = Uri.parse('https://muterian.kimworks.buzz/api/users');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> users = jsonDecode(response.body);
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      final authenticatedUser = users.firstWhere(
        (user) => user['email'] == email && user['password'] == password,
        orElse: () => null,
      );

      if (authenticatedUser != null) {
        Get.to(() => const HomePage());
      } else {
        print("Invalid email or password");
      }
    } else {
      print("Failed to load user data");
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Image.asset(
                    "assets/images/logo-no-background.png",
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                //Hello again!
                Text(
                  'Hello Again!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.bebasNeue(
                    fontSize: 36,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Welcome back you have been missed",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.indieFlower(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                //email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                //password textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),

                // Forgot Password!
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("Forgot Password?"),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // sign in button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 125.0),
                  child: GestureDetector(
                    onTap: _signIn,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color(0xFF755bb4),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          "Log In",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // not a user? Register!

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Not a member? ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                GestureDetector(
                  //onTap: () => Get.to(() => const RegisterPage()),
                  onTap: () => Get.to(() => RegisterPage()),
                  child: const Text(
                    "Register now",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF04fc74),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future signIn() async {
  final url = Uri.parse('https://muterian.kimworks.buzz/api/users');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> users = jsonDecode(response.body);
    //final String email = _emailController.text.trim();
    //final String password = _passwordController.text.trim();

    // final authenticatedUser = users.firstWhere(
    //   (user) => user['email'] == email && user['password'] == password,
    //   orElse: () => null,
    // );

    //   if (authenticatedUser != null) {
    //     Get.to(() => const HomePage());
    //   } else {
    //     print("Not a user");
    //   }
    // } else {
    //   print("Failed to fetch users");
    // }
  }
}
