import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastService {
  ToastService._privateConstructor();

  static final ToastService _instance = ToastService._privateConstructor();
  static ToastService get instance => _instance;

  void _makeToast(String message, Color color){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  void toastValidate(String message)  {
    _makeToast(message, Colors.green);
  }

  void toastError(String message)  {
    _makeToast(message, Colors.red);
  }

  void toastWarning(String message)  {
    _makeToast(message, Colors.yellow);
  }


}
