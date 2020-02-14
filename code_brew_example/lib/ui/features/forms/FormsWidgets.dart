import 'package:code_brew_example/models/ExamplesModel.dart';
import 'package:flutter/material.dart';
import 'package:code_brew/code_brew.dart';

class FormsWidgetScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FormsWidgetsScreenState();
}

class _FormsWidgetsScreenState extends State<FormsWidgetScreen> {
  List<String> dropDownItems = [
    "Apple",
    "Microsoft",
    "Amazon",
    "Facebook",
    "IBM"
  ];
  List<ExamplesModel> dropDownObjectItems = ExamplesModel.generate(20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(25.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                UIPasswordField(),
                UIPasswordField(
                ),
                Container(
                  child: UIPhoneNumberField(),
                ),
                Divider(color: Colors.blue,),
                Text("Dropdowns"),
                Divider(),
                Container(
                  child: UIDropdown<String>(
                    dropDownItems,
                    initialValue: dropDownItems[1],
                    builder: (context, value) {
                      return Text(value);
                    },
                  ),
                ),
                Container(
                  child: UIDropdown<ExamplesModel>(
                    dropDownObjectItems,
                    initialValue: dropDownObjectItems[0],
                    builder: (context, value) {
                      return dropDownItem(value);
                    },
                  ),
                ),

                Divider(),
                Text("Pin Field"),

                UIPinField(focusOnEnter: false, onPinComplete: (pin) {
                  print("Pin Complete: $pin");
                },),

                SizedBox(height: 50,),
                RaisedButton(
                  onPressed: () {},
                  child: Text("Let's Go"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dropDownItem(ExamplesModel value) {
    return Container(
      // width: 200,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(right: 5.0),
            child: Text(value.id.toString(), style: TextStyle(fontSize: 12, color: Colors.grey),),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(value.name, style: TextStyle(fontWeight: FontWeight.bold,),),
              Text(value.subtitle, style: TextStyle(fontSize: 13),),
            ],
          ),
        ],
      ),
    );
  }
}
