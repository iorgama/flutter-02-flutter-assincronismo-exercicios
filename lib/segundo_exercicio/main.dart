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
      title: 'CorraBomba',
      theme: ThemeData(
        textTheme: const TextTheme(
          headline4: TextStyle(color: Colors.white, fontSize: 50.0),
          bodyText1: TextStyle(color: Colors.black, fontSize: 22.0),
          bodyText2: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
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
  final pageController = PageController();
  late Timer _timer;
  String buttonText = 'INICIAR';
  String buttonTextBack = 'VOLTAR';
  int _start = 15;

  void jumpToPage(int page) {
    pageController.jumpToPage(page);
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            _start = 15;
            jumpToPage(2);
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Corra da bomba',
                    style: Theme.of(context).textTheme.bodyText1),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    startTimer();
                    jumpToPage(1);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 15),
                  ),
                  child: Text(buttonText,
                      style: Theme.of(context).textTheme.bodyText2),
                )
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(100, 0, 0, 0),
                  child: Image.network(
                      alignment: Alignment.centerRight,
                      width: 570,
                      'https://i.pinimg.com/originals/97/00/ff/9700ff5255003108cbb1c7b49e666637.gif'),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text('Passe a bomba',
                    style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Você perdeu!!',
                    style: Theme.of(context).textTheme.bodyText1),
                const SizedBox(
                  height: 50,
                ),
                Image.network(
                    alignment: Alignment.center,
                    'https://opengameart.org/sites/default/files/explosion1.gif'),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    jumpToPage(0);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 15),
                  ),
                  child: Text(buttonTextBack,
                      style: Theme.of(context).textTheme.bodyText2),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
