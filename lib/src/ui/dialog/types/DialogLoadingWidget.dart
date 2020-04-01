import 'package:flutter/material.dart';

///
/// project: code_brew
/// @package:
/// @author dammyololade <damola@kobo360.com>
/// created on 2020-01-24
class DialogLoadingWidget extends StatelessWidget {
  String text;

  DialogLoadingWidget({this.text = "Loading"});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: <Widget>[
          Container(
            height: 70,
            width: 70,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
