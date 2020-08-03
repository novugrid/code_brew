import 'package:code_brew/code_brew.dart';
import 'package:code_brew/src/network/ApiError.dart';
import 'package:code_brew/src/ui/dialog/dialog_enum.dart';
import 'package:code_brew/src/ui/modules/emaillogin/CBEmailLoginBloc.dart';
import 'package:flutter/material.dart';
import 'package:the_validator/the_validator.dart';

// TODO(Lekan): CBViewEmailLogin or CBEmailLoginView
class CBEmailLoginView extends StatefulWidget {
  final String url;
  final ValueChanged<dynamic> onCompleted;
  final VoidCallback onRecoverPressed;

  CBEmailLoginView({this.url, this.onCompleted, this.onRecoverPressed});

  @override
  State<StatefulWidget> createState() => _CBEmailLoginView();
}

class _CBEmailLoginView extends State<CBEmailLoginView> {
  GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  CBEmailLoginBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = CBEmailLoginBloc();
    bloc.emailLoginUrl = widget.url;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.loginSubject.listen((value) {
        if (value == ApiCallStates.SUCCESS) {
          widget.onCompleted(bloc.loginResponse);
        }
      }, onError: (e) {
        if (e is CBApiError) {
          UIDialog(
            context: context,
            type: DialogType.error,
            title: "Login Failed!",
            message: e.errorDescription,
            showIcon: false,
          ).show();
          // e.error.userMessage;
        }
      });

      // prefill
//      emailController.text = "superadmin@gmail.com";
//      passwordController.text = "password";

    });
  }

  submit() {

    if (_formKey.currentState.validate()) {

      bloc.emailLoginParams.email = emailController.text;
      bloc.emailLoginParams.password = passwordController.text;
      bloc.emailLogin();

    }

  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          UITextFormField(
            controller: emailController,
            label: "Email",
            hint: "Enter email address",
            validator: FieldValidator.email(),
          ),
          SizedBox(height: 15),
          UIPasswordField(
            label: "Password",
            hint: "Enter password",
            passwordController: passwordController,
            validator: FieldValidator.password(),
            onEditingComplete: () {
              submit();
            },
          ),

          UIButton(
            onPressed: widget.onRecoverPressed,
            type: UIButtonType.flat,
            text: "Recover Password",
            textColor: Colors.white,
            alignment: Alignment.centerRight,
//            fillContainer: true,
            padding: EdgeInsets.zero,
          ),
          SizedBox(height: 10),
          // Todo: Replace with the right model
          StreamBuilder<ApiCallStates>(
              stream: bloc.loginSubject,
              builder: (context, snapshot) {
                return Column(
                  children: <Widget>[
                    // if (snapshot.hasError) Text((snapshot.error as ApiError).error.userMessage),
                    if (snapshot.data == ApiCallStates.LOADING)
                      CircularProgressIndicator(
                        strokeWidth: 2.0,
                      )
                    else
                      UIButton(
                        onPressed: submit,
                        type: UIButtonType.raised,
                        text: "Login",
                        fillContainer: true,
                      ),
                  ],
                );
              })
        ],
      ),
    );
  }
}
