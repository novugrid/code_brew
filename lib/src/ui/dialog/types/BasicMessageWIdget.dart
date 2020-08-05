import 'package:code_brew/src/ui/dialog/dialog_actions.dart';
import 'package:code_brew/src/ui/theme/CodeBrewTheme.dart';
import 'package:flutter/material.dart';

///
/// project: code_brew
/// @package:
/// @author dammyololade <dammyololade2010@gmail.com>
/// created on 2020-01-24
class BasicMessageWidget extends StatelessWidget {
  String message;
  String title;
  TextStyle titleStyle;
  TextStyle messageStyle;
  String btnText;
  OnPositiveBtnClicked onPositiveBtnClicked;

  BasicMessageWidget({this.message,
    this.title = "",
    this.titleStyle = const TextStyle(fontSize: 16),
    this.messageStyle = const TextStyle(fontSize: 14),
    this.btnText = "",
    this.onPositiveBtnClicked});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (title.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 15, right: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                        title,
                        style: Theme
                            .of(context)
                            .dialogTheme
                            .titleTextStyle,
                      )),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, right: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    message,
                    style: Theme
                        .of(context)
                        .dialogTheme
                        .contentTextStyle,
                    textAlign: TextAlign.center,
                  ),
                )
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
                    style: CodeBrewTheme.dialogButtonTextStyle,
                  ),
                  onPressed: onPositiveBtnClicked ??
                          () {
                        print("No action attached");
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
