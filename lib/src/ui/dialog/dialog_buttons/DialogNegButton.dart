import 'package:code_brew/src/ui/dialog/dialog_actions.dart';
import 'package:flutter/material.dart';

///
/// project: code_brew
/// @package:
/// @author dammyololade <dammyololade2010@gmail.com>
/// created on 2020-01-24
class DialogNegButton extends StatelessWidget {
  OnNegativeBtnClicked onNegativeBtnClicked;
  String text;
  TextStyle textStyle;

  DialogNegButton({@required this.text,
    this.onNegativeBtnClicked,
    this.textStyle
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onNegativeBtnClicked,
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
