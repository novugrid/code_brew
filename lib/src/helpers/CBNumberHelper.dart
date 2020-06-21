
import 'package:intl/intl.dart';

class CBNumberHelper {

  /// Convert a string to a floating number for use on amount field e.t.c
  static  double convertToNumber(String  value){
    if(value.isEmpty){
      value = "0";
    }
    String _onlyDigits = value.replaceAll(RegExp('[^0-9]'), "");
    double _doubleValue = double.parse(_onlyDigits);
    if(!value.contains(".")) {
      return _doubleValue;
    }
    return  _doubleValue/100;
  }

  static  double amountFieldConvert(String  value){
    if(value.isEmpty){
      value = "0";
    }
    String newValue = value.replaceAll(",", "");
    double _doubleValue = double.parse(newValue);
    return  _doubleValue;
  }

  static String formatToCurrency(String val) {
    final formatter = new NumberFormat("#,##0.00", "en_US");
    double totalAmount = 0.00;
    totalAmount =  amountFieldConvert(val);
    return  "${formatter.format(totalAmount)}";  //totalAmount ; //;//formatAmount(totalAmount);

  }

}