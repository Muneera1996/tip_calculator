import 'package:flutter/material.dart';

class TipCalculatorModel with ChangeNotifier {
  double _billTotal = 0;
  double _tipPercentage = 0.15;
  int _personCount = 1;

  // Getters to retrieve the current state
  double get billTotal => _billTotal;
  double get tipPercentage => _tipPercentage;
  int get personCount => _personCount;

  void updateBillTotal(double billTotal) {
    _billTotal = billTotal;

    notifyListeners();
  }

  void updateTipPercentage(double tipPercentage) {
    _tipPercentage = tipPercentage;
    notifyListeners();
  }

  void updatePersonCount(int personCount) {
    _personCount = personCount;
    notifyListeners();
  }

  double get totalPerPerson {
    return ((_billTotal * _tipPercentage) + (_billTotal)) / _personCount;
  }
}
