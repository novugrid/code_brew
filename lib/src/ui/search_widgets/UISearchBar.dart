import 'package:code_brew/src/ui/search_widgets/UiSearch.dart';
import 'package:flutter/material.dart';

/// 
/// project: code_brew
/// @package: 
/// @author dammyololade <damola@kobo360.com>
/// created on 2020-01-23

class UISearchBar extends StatelessWidget {
  TextEditingController controller;
  String hint;
  bool hasBorder;
  Color borderColor;
  FocusNode focus;
  ValueNotifier<bool> showLoadingNotifier;


  UISearchBar( {@required this.controller,
    this.hint = "Search",
    this.hasBorder = false,
    this.borderColor,
    this.showLoadingNotifier,
    this.focus});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 15),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color:  Color(0xFF292724).withOpacity(0.06),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.search,
            size: 24,
            color: Colors.black26,
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(child: UiSearch(
              controller: controller,
            hint: hint,
            hasBorder: hasBorder,
            focus: focus,
          )),

          showLoadingNotifier != null ? ValueListenableBuilder(
              valueListenable: showLoadingNotifier,
              builder: (context, bool value, child) {
                return !value ? SizedBox() : Container(
                  height: 15, width: 15,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(Colors.black26),
                  )
                );
              }
          ) : SizedBox()
        ],
      ),
    );
  }

}