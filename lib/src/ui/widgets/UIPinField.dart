import 'package:flutter/material.dart';
import 'package:code_brew/src/uiservices/PinTextInputFormatter.dart';

class UIPinField extends StatefulWidget {
  final int boxes;
  final ValueChanged<String> onPinComplete;
  final ValueChanged<String> onPinEntered;
  final bool focusOnEnter;

  UIPinField(
      {this.boxes = 4,
      this.focusOnEnter = true,
      this.onPinComplete,
      this.onPinEntered});

  @override
  _UIPinFieldState createState() => _UIPinFieldState();
}

class _UIPinFieldState extends State<UIPinField> {
  List<TextEditingController> textEditingControllers = [];
  List<FocusNode> focusNodes = [];

  List<String> pin = [];

  int currentFocusBoxIndex = 0;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.boxes; i++) {
      focusNodes.add(FocusNode());
      textEditingControllers.add(TextEditingController());
      focusNodes[i].addListener(onPinBoxFocused);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.focusOnEnter) {
        FocusScope.of(context).requestFocus(focusNodes[0]);
      }
    });
  }

  //
  onPinBoxFocused() {
    print("One of the boxes has been focused on..");
    int boxFocusIndex = 0;
    for (int i = 0; i < focusNodes.length; i++) {
      if (focusNodes[i].hasFocus) {
        print("The Correct focus node is: $i");
        boxFocusIndex = i;
      }
    }
    if (boxFocusIndex > 0) {
      currentFocusBoxIndex = pin.isEmpty ? 0 : (pin.length - 1);
      print("Request focus at: $currentFocusBoxIndex");
      // send the focus back to the last one
      FocusScope.of(context).requestFocus(focusNodes[currentFocusBoxIndex]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.boxes, (index) {
        return Expanded(child: pinBox(index));
      }),
    );
  }

  Widget pinBox(int index) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      width: 68,
      height: 64,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        alignment: Alignment.center,
        height: 24,
        child: TextField(
          key: ValueKey('$index'),
          controller: textEditingControllers[index],
          focusNode: focusNodes[index],
          // enabled: index == 0 ? true : false,
          showCursor: false,
          enableInteractiveSelection: false,
          /*onTap: () {
            print("Index Tapped at..... $index");
            if (index > 0) {
              int focusPoint = pin.isEmpty ? 0 : (pin.length - 1);
              print("Request focus at: $focusPoint");
              // send the focus back to the last one
              FocusScope.of(context).requestFocus(focusNodes[focusPoint]);
            }
          },*/
          decoration: InputDecoration(
            filled: true,
            hintText: "\u002D",
            contentPadding: EdgeInsets.only(bottom: 14),
            border: InputBorder.none,
            // focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
          ),

          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          inputFormatters: [
            PinTextInputFormatter(
                maxLength: 1,
                onNewCharacterEntered: (newValue) {
                  print("Future Value is: $newValue");
                  this.jumpToNextPinBox(newValue);
                }),
          ],
//          inputFormatters: [PinTextInputFormatter(), LengthLimitingTextInputFormatter(1)],
          keyboardType:
              TextInputType.numberWithOptions(signed: false, decimal: false),
          onChanged: (val) {
            print("Onchanged Val - $val");
            // Note: The onchange can only be called

            print("Onchanged(): Pin Before: $pin");

            if (val.isNotEmpty) {
              if (pin.isEmpty) {
                pin.add(val);
              }
            } else {
              pin.removeLast();
              if (pin.isNotEmpty) focusOn(pin.length - 1);
              // pin.removeAt(index);
            }
            print("Onchanged(): Pin After: $pin");

            /*if (val.isNotEmpty) {

              if (pin.length < widget.boxes) { pin.add(val); }

              if (pin.length >= widget.boxes) {
                if (widget.onPinComplete != null) {
                  widget.onPinComplete(pin.join());
                }
              }

              if (index < (focusNodes.length - 1) ) {
                FocusScope.of(context).requestFocus(focusNodes[index + 1]);
              }
              print("------------ \n");

            } else {
              pin.removeAt(index); // [index] = "";
              focusOnPrevious(index);
            }
            print("Pin Values - $val & Length + $pin");*/
          },
        ),
      ),
    );
  }

  void jumpToNextPinBox(String value) {
    var index = (pin.length);
    var lastEntry = value[value.length - 1];
    print("Last Entry: $lastEntry");

    if (pin.length < widget.boxes) {
      pin.add(lastEntry);
      textEditingControllers[index].text = lastEntry;
      FocusScope.of(context).requestFocus(focusNodes[index]);
      print("Pin COntents: $pin");

      // Check for the end here
      if (pin.length >= widget.boxes) {
        if (widget.onPinComplete != null) {
          print("COMPLETE PIN --- current focus : $currentFocusBoxIndex");

          // Bug Alert:(Lekan) - the keyboard not auto closing while navigating off the screen
          // this will help force the pin boxes to loose focus and drop the keyboard down
          // focusNodes[currentFocusBoxIndex].unfocus();
          focusNodes[currentFocusBoxIndex + 1].unfocus();
          FocusScope.of(context).unfocus();

          widget.onPinComplete(pin.join());
        }
      }
    }
  }

  void focusOn(int position) {
    FocusScope.of(context).requestFocus(focusNodes[position]);
  }
}
