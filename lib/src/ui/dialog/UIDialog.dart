import 'package:code_brew/src/ui/dialog/dialog_actions.dart';
import 'package:code_brew/src/ui/dialog/dialog_enum.dart';
import 'package:code_brew/src/ui/dialog/sizes/BigDialog.dart';
import 'package:code_brew/src/ui/dialog/types/BasicMessageWIdget.dart';
import 'package:code_brew/src/ui/dialog/types/ConfirmationWidget.dart';
import 'package:code_brew/src/ui/dialog/types/DialogLoadingWidget.dart';
import 'package:code_brew/src/ui/dialog/types/GeneralDialogWidget.dart';
import 'package:flutter/material.dart';

///
/// project: code_brew
/// @package:
/// @author dammyololade <dammyololade2010@gmail.com>
/// created on 2020-01-24
class UIDialog {
  DialogType type;
  DialogSize size;
  DialogPosition position;
  bool dismissable;
  BuildContext context;
  ValueNotifier<DialogType> typeChangedNotifier;
  OnPositiveBtnClicked onPositiveBtnClicked;
  OnNegativeBtnClicked onNegativeBtnClicked;
  String title;
  String message;
  String positiveText;
  bool showIcon;

  UIDialog({
    @required this.context,
    this.type,
    this.size = DialogSize.normal,
    this.position = DialogPosition.center,
    this.dismissable = true,
    this.onPositiveBtnClicked,
    this.onNegativeBtnClicked,
    this.title,
    this.message,
    this.showIcon = true,
  });

  void show() {
    typeChangedNotifier = ValueNotifier(this.type);
    switch (position) {
      case DialogPosition.center:
        _handleCenterPosition();
        break;
      case DialogPosition.bottom:
        // TODO: Handle this case.
        break;
    }
  }

  void _handleCenterPosition() {
    showDialog(
        context: context,
        // ignore: missing_return
        builder: (context) {
          switch (size) {
            case DialogSize.normal:
              return SimpleDialog(
                titlePadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.zero,
                children: <Widget>[
                  ValueListenableBuilder(
                      valueListenable: typeChangedNotifier,
                      builder: (context, type, child) =>
                          mapDialogTypeToWidget(type))
                ],
              );
            case DialogSize.big:
              return BigDialog(
                titlePadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.zero,
                children: <Widget>[
                  ValueListenableBuilder(
                      valueListenable: typeChangedNotifier,
                      builder: (context, type, child) =>
                          mapDialogTypeToWidget(type))
                ],
              );
          }
        });
  }

  Widget mapDialogTypeToWidget(DialogType type) {
    switch (type) {
      case DialogType.confirmation:
        return ConfirmationWidget(
          title: title ?? "Delete Stuff",
          message: message ??
              "Confirm this action before you proceed, Really a cool message to be passed, and you really "
              "need to check this stuff out cos its a great "
              "stuff holding stuff together",
          onPositiveBtnClicked: onPositiveBtnClicked,
          onNegativeBtnClicked: () {
            Navigator.of(context).pop();
          },
        );
      case DialogType.loading:
        return DialogLoadingWidget();
      case DialogType.basic:
        return BasicMessageWidget(
          message: "Really a cool message to be passed, and you really "
              "need to check this stuff out cos its a great "
              "stuff holding stuff together",
          title: "Hello title",
          btnText: "OK",
          onPositiveBtnClicked: () {
            Navigator.of(context).pop();
          },
        );
      case DialogType.warning:
        return ConfirmationWidget(
            message: message ??
                "Confirm this action before you proceed, Really a cool message to be passed, and you really "
                "need to check this stuff out cos its a great "
                "stuff holding stuff together",
            title: title ?? "Confirm this",
            onNegativeBtnClicked: onNegativeBtnClicked,
            onPositiveBtnClicked: onPositiveBtnClicked);
      case DialogType.success:
        return GeneralDialogWidget(
          title: title ?? "Hello!",
          message: message ?? "Item deleted auccessfully from the api.",
          btnText: "Ok",
          icon: Icon(
            Icons.check_circle_outline,
            size: 50,
            color: Colors.green.shade400,
          ),
        );
      case DialogType.error:
        return GeneralDialogWidget(
          title: title ?? "Opps Error!",
          message: message ?? "Unable to delete item, oops error",
          btnText: positiveText ?? "Ok",
          icon: showIcon ? Icon(
            Icons.error_outline,
            size: 30,
            color: Colors.red.shade400,
          ) : null,
        );
      case DialogType.general:
        return GeneralDialogWidget(
          title: "Hello!",
          message: "Item deleted auccessfully from the api.",
          btnText: "Ok",
        );
    }
  }

  void changeType(DialogType type) {
    typeChangedNotifier.value = type;
  }
}
