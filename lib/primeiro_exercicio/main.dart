import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PomoCubos',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.pink,
        textTheme: const TextTheme(
          headline4: TextStyle(color: Colors.white, fontSize: 50.0),
          bodyText1: TextStyle(color: Colors.white, fontSize: 16.0),
          bodyText2: TextStyle(
              color: Colors.pink, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Timer _timer;
  int _start = 1500;
  String text = 'inativo';
  String buttonText = 'Iniciar';

  void stopTimer() {
    setState(() {
      _timer.cancel();
      text = 'inativo';
      buttonText = 'Iniciar';
    });
  }

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            _start = 1500;
            text = 'inativo';
            buttonText = 'Iniciar';
          });
        } else {
          setState(() {
            _start--;
            text = 'ativo';
            buttonText = 'Parar';
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PomoCubos'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text, style: Theme.of(context).textTheme.bodyText1),
            const SizedBox(
              height: 10,
            ),
            Text(
              formatTime(_start),
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 35,
            ),
            ElevatedButton(
              onPressed: () {
                text == 'inativo' ? startTimer() : stopTimer();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
              ),
              child: Text(buttonText,
                  style: Theme.of(context).textTheme.bodyText2),
            )
          ],
        ),
      ),
    );
  }
}
