import 'package:flutter/material.dart';
import 'package:klinik_pahase2/service/login_service.dart';

import 'poli_page.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Welcome to MyNotes!",
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Helvetica',
                        color: Colors.white)),
                const Text("Capture your thoughts, anywhere, anytime.",
                    style: TextStyle(
                        fontSize: 23,
                        fontFamily: 'Helvetica',
                        color: Colors.white)),
                const SizedBox(height: 150),
                const Text("Please enter your credentials to continue.",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Helvetica',
                      color: Colors.white,
                    )),
                const SizedBox(height: 30),
                Center(
                  child: Form(
                    key: _formKey,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Column(
                        children: [
                          _usernameTextField(),
                          const SizedBox(height: 20),
                          _passwordTextField(),
                          const SizedBox(height: 40),
                          _tombolLogin(),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _usernameTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Username",
        labelStyle:
            const TextStyle(color: Colors.white, fontFamily: 'Helvetica'),
        hintStyle:
            const TextStyle(color: Colors.white, fontFamily: 'Helvetica'),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      controller: _usernameCtrl,
      style: const TextStyle(color: Colors.white, fontFamily: 'Helvetica'),
      cursorColor: Colors.white,
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle:
            const TextStyle(color: Colors.white, fontFamily: 'Helvetica'),
        hintStyle:
            const TextStyle(color: Colors.white, fontFamily: 'Helvetica'),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      obscureText: true,
      controller: _passwordCtrl,
      style: const TextStyle(color: Colors.white, fontFamily: 'Helvetica'),
      cursorColor: Colors.white,
    );
  }

  Widget _tombolLogin() {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            child: const Text(
              "Login",
              style: TextStyle(color: Colors.blueGrey, fontFamily: 'Helvetica'),
            ),
            onPressed: () async {
              String username = _usernameCtrl.text;
              String password = _passwordCtrl.text;
              await LoginService().login(username, password).then((value) {
                if (value == true) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PoliPage()));
                } else {
                  AlertDialog alertDialog = AlertDialog(
                    content: const Text(
                      "Invalid Username or Password!",
                      style: TextStyle(fontSize: 20, fontFamily: 'Helvetica'),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white, elevation: 0),
                        child: const Text(
                          "OK",
                          style: TextStyle(
                              color: Colors.blueGrey, fontFamily: 'Helvetica'),
                        ),
                      )
                    ],
                  );
                  showDialog(
                      context: context, builder: (context) => alertDialog);
                }
              });
            }));
  }
}
