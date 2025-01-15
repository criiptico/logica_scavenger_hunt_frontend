import 'package:flutter/material.dart';

class SignupForm extends StatefulWidget{
  const SignupForm({super.key});

  @override
  State<StatefulWidget> createState() => _SignupForm();
}

class _SignupForm extends State<SignupForm> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String signupErrorMessage = "Enter a valid email and password";
  bool showsignupErrorMessage = false;

  void _handleSignup(){
    if (emailController.text != "" && passwordController.text != ""){
      if (!emailController.text.endsWith("@uic.edu")){
        setState(() {
          showsignupErrorMessage = true;
        });
        // print("Unsuccessful sign up");
      }
      else {
        // print("Successfully signed up");
        setState(() {
          showsignupErrorMessage = false;
        });
      }
    }
    else {
      setState(() {
        showsignupErrorMessage = true;
      });
      // print("Unsuccessful sign up");
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
            decoration: InputDecoration(
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
          onPressed: _handleSignup,
          child: const Text("Sign Up"),
        ),
        showsignupErrorMessage ? Container(height: 10) : Container(height: 0),
        showsignupErrorMessage ? Text(signupErrorMessage, style: const TextStyle(color: Colors.red),) : const Text(""),

      ],
    );
  }

}