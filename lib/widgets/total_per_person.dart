import 'package:flutter/material.dart';

class TotalPerPerson extends StatelessWidget {
  const TotalPerPerson({
    super.key,
    required this.theme,
    required this.style,
    required double billTotal,
    required double tipPercentage,
    required int personCount,
  })  : _billTotal = billTotal,
        _tipPercentage = tipPercentage,
        _personCount = personCount;

  final ThemeData theme;
  final TextStyle style;
  final double _billTotal;
  final double _tipPercentage;
  final int _personCount;

  @override
  Widget build(BuildContext context) {
    print(_billTotal);
    print(_personCount);
    print(_tipPercentage);
    double total =
        ((_billTotal * _tipPercentage) + (_billTotal)) / _personCount;

    print("total-->$total");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withAlpha(150),
          // color: Colors.purple.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        //TODO:  ==== REFACTOR: at the end of the video, refactor this into its own widget!
        // === Use VScode refactor shortcut - cmd + . refactor into its own widget ===
        child: Column(
          children: [
            Text(
              'Total Per Person',
              textAlign: TextAlign.center,
              style: style,
            ),
            Text(
              '\$${((_billTotal * _tipPercentage + (_billTotal)) / _personCount).toStringAsFixed(2)}',
              textAlign: TextAlign.center,
              style: style.copyWith(
                color: theme.colorScheme.onPrimary,
                fontSize: theme.textTheme.displaySmall!.fontSize! * 0.8,
              ),
            ) //theme.textTheme.titleMedium,
          ],
        ),
        // === refactor into its own widget ===
      ),
    );
  }
}
