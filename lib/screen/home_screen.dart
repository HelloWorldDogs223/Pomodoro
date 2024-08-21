import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;
  int totalSeconds = twentyFiveMinutes;
  late Timer timer;
  bool isRunning = false;

  int totalPomodoros = 0;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoros++;
        totalSeconds = twentyFiveMinutes;
        isRunning = false;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds--;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(
      Duration(seconds: 1),
      onTick,
    );

    setState(() {
      isRunning = true;
    });
  }

  void onPuasePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2,7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
              flex: 1,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  format(totalSeconds),
                  style: TextStyle(
                      color: Theme.of(context).cardColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 89),
                ),
              )),
          Flexible(
              flex: 2,
              child: Container(
                child: Center(
                    child: IconButton(
                  color: Theme.of(context).cardColor,
                  iconSize: 120,
                  icon: Icon(isRunning
                      ? Icons.pause_circle_outline
                      : Icons.play_circle_outline),
                  onPressed: isRunning ? onPuasePressed : onStartPressed,
                )),
              )),
          Flexible(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(50)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "pomodoros",
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .color),
                          ),
                          Text(
                            "$totalPomodoros",
                            style: TextStyle(
                                fontSize: 60,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .color),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
