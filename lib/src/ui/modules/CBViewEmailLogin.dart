import 'package:code_brew/code_brew.dart';
import 'package:flutter/material.dart';
import 'package:the_validator/the_validator.dart';

// TODO(Lekan): CBViewEmailLogin or CBEmailLoginView
class CBViewEmailLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CBViewEmailLogin();
}

class _CBViewEmailLogin extends State<CBViewEmailLogin> {

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Form(
      child: Column(
        children: <Widget>[
          TextFormField(
            validator: FieldValidator.email(),
            decoration: InputDecoration(
              labelText: "Email"
            ),
          ),
          SizedBox(height: 10,),
          UITextFormField(hint: "Enter Email Address", label: "Email Address",),
          SizedBox(height: 10,),
          UIPasswordField(passwordController: passwordController,),
          UIButton(onPressed: () {}, type: UIButtonType.raised, text: "Login",)
        ],
      ),
    );
  }
}
