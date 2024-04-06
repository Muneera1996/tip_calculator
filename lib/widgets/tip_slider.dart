import 'package:flutter/material.dart';

class TipSlider extends StatelessWidget {
  final ValueChanged<double> onChanged;
  final double tipPercentage;

  const TipSlider({
    Key? key,
    required this.onChanged,
    required this.tipPercentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: tipPercentage,
      onChanged: onChanged,
      min: 0,
      max: 0.5,
      divisions: 5,
      label: '${(tipPercentage * 100).round()}%',
    );
  }
}