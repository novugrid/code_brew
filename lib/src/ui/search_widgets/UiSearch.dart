import 'package:flutter/material.dart';

///
/// project: code_brew
/// @package:
/// @author dammyololade <dammyololade2010@gmail.com>
/// created on 2020-01-23

typedef OnSearchCompleted = Function(bool completed);

class UiSearch extends StatelessWidget {
  TextEditingController controller;
  String hint;
  bool hasBorder;
  Color borderColor;
  FocusNode focus;

  UiSearch(
      {@required this.controller,
      this.hint = "Search",
      this.hasBorder = false,
      this.borderColor,
      this.focus});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Color(0XFF292724).withOpacity(0.3),
          fontSize: 17,
        ),
        border: !hasBorder
            ? InputBorder.none
            : UnderlineInputBorder(
                borderSide:
                    BorderSide(color: borderColor ?? Colors.black26, width: 1)),
        enabledBorder: !hasBorder
            ? InputBorder.none
            : UnderlineInputBorder(
                borderSide:
                    BorderSide(color: borderColor ?? Colors.black26, width: 1)),
        contentPadding: EdgeInsets.all(4),
      ),
      controller: controller,
      maxLines: 1,
      focusNode: focus ?? FocusNode(),
      enabled: true,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      style: TextStyle(
        color: Colors.black,
      ),
    );
  }
}
