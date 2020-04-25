import 'package:code_brew/code_brew.dart';
import 'package:code_brew/src/network/ApiError.dart';
import 'package:code_brew/src/ui/modules/emaillogin/CBEmailLoginBloc.dart';
import 'package:flutter/material.dart';
import 'package:the_validator/the_validator.dart';

// TODO(Lekan): CBViewEmailLogin or CBEmailLoginView
class CBViewEmailLogin<T> extends StatefulWidget {
  
  final String url;
  final ValueChanged<T> onCompleted;
  final VoidCallback onRecoverPressed;

  CBViewEmailLogin({this.url, this.onCompleted, this.onRecoverPressed});

  @override
  State<StatefulWidget> createState() => _CBViewEmailLogin();
}

class _CBViewEmailLogin extends State<CBViewEmailLogin> {
  TextEditingController passwordController = TextEditingController();
  
  CBEmailLoginBloc bloc;
  
  @override
  void initState() {
    super.initState();
    bloc = CBEmailLoginBloc();

    WidgetsBinding.instance.addPostFrameCallback((_) {
//      bloc.loginSuccessSubject.lis
    });

  }


  @override
  Widget build(BuildContext context) {
    
    return Form(
      child: Column(
        children: <Widget>[

          UITextFormField(
            label: "Email",
            hint: "Enter email address",
          ),
          SizedBox(height: 15),
          UIPasswordField(
            label: "Password",
            hint: "Enter password",
            passwordController: passwordController,
          ),

          UIButton(
            onPressed: widget.onRecoverPressed,
            type: UIButtonType.flat,
            text: "Recover Password",
            textColor: Colors.white,
            alignment: Alignment.centerRight,
            fillContainer: true,
            padding: EdgeInsets.zero,
          ),
          SizedBox(height: 10,),
          // Todo: Replace with the right model
          StreamBuilder<bool>(
            stream: bloc.loginSuccessSubject.stream,
            builder: (context, snapshot) {

              if (snapshot.data == true) {
                widget.onCompleted(true);
              }
              
              return Column(
                children: <Widget>[
                  if (snapshot.hasError) Text((snapshot.error as ApiError).error.userMessage),
                  if (snapshot.data == null) CircularProgressIndicator(strokeWidth: 2.0,)  else
                  UIButton(
                    onPressed: () {},
                    type: UIButtonType.raised,
                    text: "Login",
                    fillContainer: true,
                  ),

                ],
              );
            }
          )
        ],
      ),
    );
  }
}
