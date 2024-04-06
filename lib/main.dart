import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tip_calculator/providers/tip_calculator_model.dart';
import 'package:tip_calculator/widgets/bill_amount_field.dart';
import 'package:tip_calculator/widgets/person_counter.dart';
import 'package:tip_calculator/widgets/tip_slider.dart';
import 'package:tip_calculator/widgets/total_per_person.dart';

void main() {
  // runApp(const MyApp()); // This is the original code
  runApp(ChangeNotifierProvider(
      create: (context) => TipCalculatorModel(), child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //   useMaterial3: true,
        // ),
        //home: const UTip());
        home: UTip(
          onThemeChanged: (isDarkModeEnabled) {
            setState(() {
              _isDarkMode = isDarkModeEnabled;
            });
          },
        ));
  }
}

class UTip extends StatefulWidget {
  final Function(bool) onThemeChanged;

  const UTip({super.key, required this.onThemeChanged});

  @override
  State<UTip> createState() => _UTipState();
}

class _UTipState extends State<UTip> {
  double _billTotal = 100.00;
  int _personCount = 1;
  double _tipPercentage = 0.00;

  // double _totalPerPerson(double billAmount, int splitBy, double tipPercentage) {
  //   var totalTip = billAmount * tipPercentage;
  //   var total = billAmount + totalTip;
  //   return total / splitBy;
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final model = Provider.of<TipCalculatorModel>(context); // Add this line

    // Add style
    final style = theme.textTheme.titleMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.bold,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('UTip'),
        actions: [
          Switch(
            value: Theme.of(context).brightness == Brightness.dark,
            onChanged: (value) {
              widget.onThemeChanged(
                  value); // Notify the parent widget about the theme change
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //total per person display = Refactored!
            TotalPerPerson(
              theme: theme,
              style: style,
              billTotal: model.billTotal,
              tipPercentage: model.tipPercentage,
              personCount: model.personCount,
              // old code
              // billTotal: _billTotal,
              // tipPercentage: _tipPercentage,
              // personCount: _personCount,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  //color: theme.colorScheme.primary.withAlpha(150),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: theme.colorScheme.primary,
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BillAmountField(
                        billTotal:
                        model.billTotal.toString(), //_billTotal.toString(),
                        onChanged: (value) {
                          try {
                            // using provider
                            model.updateBillTotal(double.parse(value));
                            // setState(() {
                            //   _billTotal = double.parse(value);
                            // });
                          } catch (e) {
                            // handle error for invalid input
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),

                    // Split Section == Refactored
                    PersonSplit(
                        theme: theme,
                        personCount: model.personCount, //_personCount,
                        onDecrement: () {
                          if (model.personCount > 1) {
                            model.updatePersonCount(model.personCount - 1);
                          }
                          // setState(() {
                          //   if (_personCount > 1) {
                          //     _personCount--;
                          //   }
                          // });
                        },
                        onIncrement: () => model.updatePersonCount(
                            model.personCount + 1) // using provider,
                      // onIncrement: () => setState(() {
                      //   _personCount++;
                      // }),
                    ),

                    // Tip Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tip',
                          style: theme.textTheme.titleMedium,
                        ),
                        Text(
                          '\$${(model.billTotal * model.tipPercentage).toStringAsFixed(2)}',
                          style: theme.textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Slider
                    Text('${model.tipPercentage * 100}%'),
                    // === Refactored ===
                    TipSlider(
                        tipPercentage: model.tipPercentage,
                        onChanged: (value) {
                          model.updateTipPercentage(value);
                          // setState(() {
                          //   _tipPercentage = value;
                          // });
                        }),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
