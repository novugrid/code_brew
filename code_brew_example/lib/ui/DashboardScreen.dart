import 'package:code_brew/code_brew.dart';
import 'package:flutter/material.dart';

///
/// project: code_brew
/// @package:
/// @author dammyololade <damola@kobo360.com>
/// created on 2020-01-24
class DashboardScreen extends StatelessWidget {
  UIDialog dialog;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DialogPositiveButton(
            text: "Show normal dialog",
            onPositiveBtnClicked: () {
              UIDialog(context: context, type: DialogType.basic).show();
            },
          ),
          SizedBox(
            height: 20,
          ),
          DialogPositiveButton(
            text: "Confirmation dialog",
            onPositiveBtnClicked: () {
              showStuff(context);
            },
          ),
          SizedBox(
            height: 20,
          ),
          DialogPositiveButton(
            text: "Loading dialog",
            onPositiveBtnClicked: () {
              UIDialog(
                      context: context,
                      type: DialogType.loading,
                      size: DialogSize.normal)
                  .show();
            },
          ),
        ],
      ),
    );
  }

  void showStuff(BuildContext context) async {
    dialog = UIDialog(
        context: context,
        type: DialogType.confirmation,
        size: DialogSize.big,
        onPositiveBtnClicked: () async {
          dialog.changeType(DialogType.loading);
          await Future.delayed(Duration(seconds: 3));
          dialog.changeType(DialogType.success);
        });
    dialog.show();
  }
}
