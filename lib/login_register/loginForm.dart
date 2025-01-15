import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget{
  const LoginForm({super.key});

  @override
  State<StatefulWidget> createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  final uicEmail = "aquiro20@uic.edu";
  final password = "password";

  String loginErrorMessage = "Incorrect Email or Password";
  bool showLoginErrorMessage = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _handleLogin() {
    if (emailController.text == uicEmail && passwordController.text == password) {
      // Proceed to the next page of the application
      // print("Successful Login");
      setState(() {
        showLoginErrorMessage = false;
      });
    }
    else {
      setState(() {
        showLoginErrorMessage = true;
      });
      // print("Unsuccessful Login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 300,
          height: 85,
          child: TextField(
            controller: emailController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter your UIC email')
            ),
          ),
        ),
        Container(
            width: 300,
            height: 85,
            child: TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Enter your password')
              ),
            )
        ),
        OutlinedButton( // Submitting the forms
          onPressed: _handleLogin,
          child: const Text("Login"),
        ),
        showLoginErrorMessage ? Container(height: 10) : Container(height: 0),
        showLoginErrorMessage ? Text(loginErrorMessage, style: const TextStyle(color: Colors.red),) : const Text(""),
      ],
    );
  }

}