import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Number Generator App'),
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
  int _randomNumber1 = 0;
  int _randomNumber2 = 0;
  int _numPresses = 0;

  int _numGreaterPresses = 0;
  int _numSmallerPresses = 0;
  bool _isGameOver = false;

  void _generateRandomNumbers() {
    setState(() {
      _randomNumber1 = Random().nextInt(100);
      _randomNumber2 = Random().nextInt(100);
      _numPresses++;

      if (_numPresses >= 10) {
        _isGameOver = true;
      }
    });
  }

  void _onPressGreater() {
    setState(() {
      if (_randomNumber1 > _randomNumber2) {
        _numGreaterPresses++;
      } else if (_randomNumber2 > _randomNumber1) {
        _numGreaterPresses++;
      }
      _generateRandomNumbers();
    });
  }

  void _onPressSmaller() {
    setState(() {
      if (_randomNumber1 < _randomNumber2) {
        _numSmallerPresses++;
      } else if (_randomNumber2 < _randomNumber1) {
        _numSmallerPresses++;
      }
      _generateRandomNumbers();
    });
  }

  void _restartGame() {
    setState(() {
      _randomNumber1 = 0;
      _randomNumber2 = 0;
      _numPresses = 0;

      _numGreaterPresses = 0;
      _numSmallerPresses = 0;
      _isGameOver = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 150,
                      height: 200,
                      child: ElevatedButton(
                          onPressed: !_isGameOver
                              ? () => {
                                    _generateRandomNumbers(),
                                    _onPressGreater(),
                                    _onPressSmaller()
                                  }
                              : null,
                          child: Text('$_randomNumber1'))),
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                      width: 150,
                      height: 200,
                      child: ElevatedButton(
                          onPressed: !_isGameOver
                              ? () => {
                                    _onPressGreater(),
                                    _generateRandomNumbers(),
                                    _onPressSmaller()
                                  }
                              : null,
                          child: Text('$_randomNumber2'))),
                ],
              ),
              SizedBox(height: 20),
              _isGameOver
                  ? Column(
                      children: <Widget>[
                        Text(
                          'Correct Answer: $_numGreaterPresses',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Incorrect Answer: $_numSmallerPresses',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _restartGame,
                          child: Text('Restart Game'),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ));
  }
}
