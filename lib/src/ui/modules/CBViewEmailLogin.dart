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


          UITextFormField(hint: "Enter Email Address",
              label: "Email Address",
              labelColor: Colors.grey, hintColor: Colors.white70,),
          SizedBox(height: 15,),
          UIPasswordField(passwordController: passwordController,
            label: "Password",
            labelColor: Colors.grey,
            labelAlignment: UIAlignment.top, hintColor: Colors.white70,),

          Container(
            alignment: Alignment.centerRight,
            child: UIButton(onPressed: () {},
              type: UIButtonType.flat,
              text: "Recover Password",
              textColor: Colors.white,
              color: Colors.transparent,
            ),
          ),
          SizedBox(height: 10,),
          Container(
              width: double.infinity,
              height: 50,
              child: UIButton(onPressed: () {},
                type: UIButtonType.raised,
                text: "Login",
                color: Theme.of(context).accentColor,
              ))
        ],
      ),
    );
  }
}
