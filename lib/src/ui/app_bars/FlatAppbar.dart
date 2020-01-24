import 'package:flutter/material.dart';

///
/// project: code_brew
/// @package:
/// @author dammyololade <damola@kobo360.com>
/// created on 2020-01-23
class FlatAppbar extends StatefulWidget implements PreferredSizeWidget{
  String title;
  Color backgroundColor;
  double elevation;
  Widget bottom;
  List<Widget> actions;
  bool centerTitle;

  FlatAppbar(
      {@required this.title,
        this.backgroundColor = Colors.white,
        this.elevation = 0,
      this.bottom,
      this.actions,
      this.centerTitle = true});

  @override
  _FlatAppbarState createState() => _FlatAppbarState();

  Size get preferredSize => Size(double.infinity, 50);
}

class _FlatAppbarState extends State<FlatAppbar>{

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.backgroundColor,
      elevation: widget.elevation,
      title: Text(
        "${widget.title}",
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: widget.centerTitle,
      bottom: widget.bottom,
      actions: widget.actions,
    );
  }
}
