import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kelly_logistics/test/api.dart';
import 'package:kelly_logistics/test/homeScreen.dart';

import '../data/controllers/user_controller.dart';
import '../data/models/User.dart';
import 'loginScreen.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User user = User();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            /////////////  background/////////////
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 0.4, 0.9],
                  colors: [
                    Color(0xFFFF835F),
                    Color(0xFFFC663C),
                    Color(0xFFFF3F1A),
                  ],
                ),
              ),
            ),

            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      elevation: 4.0,
                      color: Colors.white,
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              /////////////// name////////////

                              TextFormField(
                                onSaved: (val) => user.first_name = val,
                                validator: (val) => val!.length < 3
                                    ? "Please enter your name"
                                    : null,
                                style:
                                    const TextStyle(color: Color(0xFF000000)),
                                cursorColor: const Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Firstname",
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              TextFormField(
                                style:
                                    const TextStyle(color: Color(0xFF000000)),
                                onSaved: (val) => user.last_name = val,
                                validator: (val) => val!.length < 3
                                    ? "Please enter your name"
                                    : null,
                                cursorColor: const Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Lastname",
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),

                              /////////////// Email ////////////

                              TextFormField(
                                style:
                                    const TextStyle(color: Color(0xFF000000)),
                                onSaved: (val) => user.email = val,
                                validator: (val) => val!.length < 3
                                    ? "Please enter valid email"
                                    : null,
                                cursorColor: const Color(0xFF9b9b9b),
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.mail,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Email ",
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),

                              /////////////// password ////////////

                              TextFormField(
                                style:
                                    const TextStyle(color: Color(0xFF000000)),
                                cursorColor: const Color(0xFF9b9b9b),
                                onSaved: (val) => user.password = val,
                                validator: (val) => val!.length < 6
                                    ? "Please enter strong password"
                                    : null,
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.vpn_key,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),

                              /////////////// SignUp Button ////////////

                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ElevatedButton(
                                  onPressed: _isLoading ? null : _handleLogin,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    disabledBackgroundColor:
                                        const Color.fromARGB(255, 29, 28, 28),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8, left: 10, right: 10),
                                    child: Text(
                                      _isLoading
                                          ? 'Creating...'
                                          : 'Create account',
                                      textDirection: TextDirection.ltr,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    /////////////// already have an account ////////////
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => LogIn()));
                        },
                        child: const Text(
                          'Already have an Account',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() => _isLoading = true);
      var res = await CallApi().postData(user.toMap(), 'register');
      var body = json.decode(res.body);
      if (res.statusCode == 200) {
        User user = User.fromMap(body['data']);
        UserController().setUserInCache(user);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
      setState(() => _isLoading = false);
    }
  }
}
