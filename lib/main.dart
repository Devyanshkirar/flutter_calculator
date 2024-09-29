import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String displayText = '0'; // Stores the current input/output
  double num1 = 0;
  double num2 = 0;
  String operator = '';
  bool shouldClear = false;

  void onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        displayText = '0';
        num1 = 0;
        num2 = 0;
        operator = '';
        shouldClear = false;
      } else if (value == '+' || value == '-' || value == '*' || value == '/') {
        num1 = double.parse(displayText);
        operator = value;
        shouldClear = true;
      } else if (value == '=') {
        num2 = double.parse(displayText);
        if (operator == '+') {
          displayText = (num1 + num2).toString();
        } else if (operator == '-') {
          displayText = (num1 - num2).toString();
        } else if (operator == '*') {
          displayText = (num1 * num2).toString();
        } else if (operator == '/') {
          displayText = num2 != 0 ? (num1 / num2).toString() : 'Error';
        }
        operator = '';
      } else {
        if (shouldClear) {
          displayText = value;
          shouldClear = false;
        } else {
          displayText = displayText == '0' ? value : displayText + value;
        }
      }
    });
  }

  Widget buildButton(String text) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => onButtonPressed(text),
          child: Text(
            text,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(24),
              child: Text(
                displayText,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  buildButton('7'),
                  buildButton('8'),
                  buildButton('9'),
                  buildButton('/'),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton('4'),
                  buildButton('5'),
                  buildButton('6'),
                  buildButton('*'),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton('1'),
                  buildButton('2'),
                  buildButton('3'),
                  buildButton('-'),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton('0'),
                  buildButton('.'),
                  buildButton('='),
                  buildButton('+'),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton('C'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
