import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentProvider with ChangeNotifier {
  String? _paymentStatus;
  Color _buttonColor = Colors.pink;
  int _payment = 0;

  String? get paymentStatus => _paymentStatus;
  Color get colorButton => _buttonColor;
  int get payment => _payment;

  set setPaymentStatus(String value) {
    _paymentStatus = value;
    notifyListeners();
  }

  set setPayment(int value) {
    _payment = value;
    notifyListeners();
  }
}
