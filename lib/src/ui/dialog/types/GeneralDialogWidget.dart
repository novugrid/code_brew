import 'package:code_brew/code_brew.dart';
import 'package:code_brew/src/helpers/extension.dart';
import 'package:code_brew/src/ui/dialog/dialog_actions.dart';
import 'package:flutter/material.dart';

///
/// project: code_brew
/// @package:
/// @author dammyololade <damola@kobo360.com>
/// created on 2020-01-25
class GeneralDialogWidget extends StatelessWidget {
  String title;
  String message;
  String btnText;
  Icon icon;
  TextStyle titleStyle;
  TextStyle messageStyle;
  OnPositiveBtnClicked onPositiveBtnClicked;

  GeneralDialogWidget(
      {this.title,
      this.message,
      this.btnText,
      this.icon,
      this.titleStyle =
          const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
      this.messageStyle,
      this.onPositiveBtnClicked});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (icon != null) icon,
          if (!title.isNullOrEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 5, top: 15),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).dialogTheme.titleTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  message,
                  style: Theme.of(context)
                      .dialogTheme
                      .contentTextStyle, //  messageStyle,
                  textAlign: TextAlign.center,
                ))
              ],
            ),
          ),
          if (btnText.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: Text(
                    btnText,
                    style: CodeBrewTheme
                        .dialogButtonTextStyle, // TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  onPressed: onPositiveBtnClicked ??
                      () {
                        Navigator.of(context).pop();
                      },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
              ],
            )
        ],
      ),
    );
  }
}
