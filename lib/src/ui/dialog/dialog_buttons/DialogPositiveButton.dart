import 'package:code_brew/src/ui/dialog/dialog_actions.dart';
import 'package:flutter/material.dart';

///
/// project: code_brew
/// @package:
/// @author dammyololade <dammyololade2010@gmail.com>
/// created on 2020-01-24
class DialogPositiveButton extends StatelessWidget {
  OnPositiveBtnClicked onPositiveBtnClicked;
  String text;
  TextStyle textStyle;
  Color backgroundColor;

  DialogPositiveButton(
      {@required this.onPositiveBtnClicked,
      @required this.text,
      this.textStyle,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(
        text,
        style: textStyle,
      ),
      onPressed: onPositiveBtnClicked,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
    );
  }
}
