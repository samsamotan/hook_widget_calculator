import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';
import 'value_model.dart';

void main() {
  runApp(MyApp());
}

T useChangeNotifierListenable<T extends ChangeNotifier>(T data) {
  final state = useState<T>(data);
  return useListenable(state.value);
}

class MyApp extends HookWidget {
  var userInput = '';
  var answer = '';

// Array of button
  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    final valueChangeNotifier = useChangeNotifierListenable(CalcValueNotifier());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: new AppBar(
          title: new Text("Calculator"),
        ), //AppBar
        backgroundColor: Colors.white38,
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(20),
                        alignment: Alignment.centerRight,
                        child: Text(
                          valueChangeNotifier.userInput,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        alignment: Alignment.centerRight,
                        child: Text(
                          valueChangeNotifier.answer,
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ]),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemBuilder: (BuildContext context, int index) {
                      // Clear Button
                      if (index == 0) {
                        return MyButton(
                          buttontapped: () {
                            valueChangeNotifier.clearPressed();
                            // setState(() {
                            // userInput = '';
                            // answer = '0';
                            // });
                          },
                          buttonText: buttons[index],
                          color: Colors.blue[50],
                          textColor: Colors.black,
                        );
                      }

                      // +/- button
                      else if (index == 1) {
                        return MyButton(
                          buttonText: buttons[index],
                          color: Colors.blue[50],
                          textColor: Colors.black,
                        );
                      }
                      // % Button
                      else if (index == 2) {
                        return MyButton(
                          buttontapped: () {
                            valueChangeNotifier.valuePressed(buttons[index]);
                            // setState(() {
                            // userInput += buttons[index];
                            // });
                          },
                          buttonText: buttons[index],
                          color: Colors.blue[50],
                          textColor: Colors.black,
                        );
                      }
                      // Delete Button
                      else if (index == 3) {
                        return MyButton(
                          buttontapped: () {
                            valueChangeNotifier.deletePressed();
                            // setState(() {
                            // userInput =
                            // userInput.substring(0, userInput.length - 1);
                            // });
                          },
                          buttonText: buttons[index],
                          color: Colors.blue[50],
                          textColor: Colors.black,
                        );
                      }
                      // Equal_to Button
                      else if (index == 18) {
                        return MyButton(
                          buttontapped: () {
                            valueChangeNotifier.equalPressed();
                            // setState(() {
                            // equalPressed();
                            // });
                          },
                          buttonText: buttons[index],
                          color: Colors.orange[700],
                          textColor: Colors.white,
                        );
                      }

                      // other buttons
                      else {
                        return MyButton(
                          buttontapped: () {
                            valueChangeNotifier.valuePressed(buttons[index]);
                            // setState(() {
                            // userInput += buttons[index];
                            // });
                          },
                          buttonText: buttons[index],
                          color: isOperator(buttons[index])
                              ? Colors.blueAccent
                              : Colors.white,
                          textColor: isOperator(buttons[index])
                              ? Colors.white
                              : Colors.black,
                        );
                      }
                    }), // GridView.builder
              ),
            ),
          ],
        ),
      ),
    ); // MaterialApp
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

}
