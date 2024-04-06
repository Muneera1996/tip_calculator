import 'package:flutter/material.dart';

class PersonSplit extends StatelessWidget {
  const PersonSplit({
    super.key,
    required this.theme,
    required int personCount,
    required this.onIncrement,
    required this.onDecrement,
  }) : _personCount = personCount;

  final ThemeData theme;
  final int _personCount;

  //add these manually
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Split',
          style: theme.textTheme.titleMedium,
        ),
        Row(
          children: [
            IconButton(
              onPressed: onDecrement,
              icon: Icon(
                Icons.remove,
                color: theme.colorScheme.primary,
              ),
            ),
            Text(
              '$_personCount',
              style: theme.textTheme.titleMedium,
            ),
            IconButton(
              onPressed: onIncrement,
              icon: Icon(
                Icons.add,
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
