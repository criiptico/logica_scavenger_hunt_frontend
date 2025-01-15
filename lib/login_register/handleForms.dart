import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:logica_scavenger_hunt_frontend/login_register/loginForm.dart';
import 'package:logica_scavenger_hunt_frontend/login_register/signupForm.dart';

class HandleForms extends StatefulWidget {
  const HandleForms({super.key});

  @override
  State<StatefulWidget> createState() => _HandleForms();
}

class _HandleForms extends State<HandleForms> {
  String state_1 = "Login";
  String state_2 = "Sign Up";
  String buttonState = "Login";
  bool formState = false;

  final _formKey = GlobalKey<FormState>();

  void _formState(){
    setState(() {

      if (formState){
        buttonState = state_1;
      }
      else {
        buttonState = state_2;
      }
      formState = !formState;
    });

  }

  void _handleForgotPassword(){
    print("Forgot Password Pressed");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 300,
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                ElevatedButton(onPressed: _formState,
                    child: Row(
                      children: [
                        Text("Login", style: formState ? const TextStyle(color: Colors.grey) : const TextStyle(color: Colors.deepPurple),),
                        Container(width: 25,),
                        Text("Sign Up", style: formState ? const TextStyle(color: Colors.deepPurple) : const TextStyle(color: Colors.grey),)
                      ],
                    )),
                // Text(buttonState),
                Container(height: 15,),
                Form(
                    key: _formKey, // Figure out how to use this.
                    child: formState ?
                    SignupForm() : LoginForm()
                ),
                TextButton(onPressed: _handleForgotPassword, child: const Text("Forgot Password?"))
              ],
            )
          ],
        ),
      )
    );
  }

}