import 'package:code_brew/code_brew.dart';
import 'package:code_brew/src/helpers/extension.dart';
import 'package:code_brew/src/ui/dialog/dialog_actions.dart';
import 'package:code_brew/src/ui/dialog/dialog_buttons/DialogNegButton.dart';
import 'package:flutter/material.dart';

///
/// project: code_brew
/// @package:
/// @author dammyololade <dammyololade2010@gmail.com>
/// created on 2020-01-24
class ConfirmationWidget extends StatelessWidget {
  String title;
  String message;
  Icon icon;
  OnPositiveBtnClicked onPositiveBtnClicked;
  OnNegativeBtnClicked onNegativeBtnClicked;

  ConfirmationWidget(
      {this.title = "",
      @required this.message,
      this.icon = const Icon(
        Icons.warning,
        size: 50,
        color: Colors.orangeAccent,
      ),
      @required this.onPositiveBtnClicked,
      this.onNegativeBtnClicked});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 20),
        //icon,
        if (!title.isNullOrEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              title,
              style: Theme
                  .of(context)
                  .dialogTheme
                  .titleTextStyle,
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: Theme
                        .of(context)
                        .dialogTheme
                        .contentTextStyle,
                  ))
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          children: <Widget>[
            Expanded(
                child: DialogNegButton(
                  text: "Cancel",
                  onNegativeBtnClicked: onNegativeBtnClicked,
                )),
            Container(
              color: Color(0xffE0E0E0).withOpacity(0.2),
              width: 1,
              height: 60,
            ),
            Expanded(
                child: DialogPositiveButton(
                  text: "Submit",
                  onPositiveBtnClicked: onPositiveBtnClicked,
                  backgroundColor: Colors.transparent,
                  textStyle: CodeBrewTheme
                      .dialogButtonTextStyle,
                )),
          ],
        )
      ],
    );
  }
}
