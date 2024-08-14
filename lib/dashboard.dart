// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Timer _timer;
  int _counter = 0;
  final int _limit = 200;

  @override
  void initState() {
    super.initState();
    // Start the timer when the widget is initialized
    _startTimer();
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed to prevent memory leaks
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    // Create a timer that runs every second and increments the counter
    _timer = Timer.periodic(const Duration(milliseconds: 2), (timer) {
      setState(() {
        _counter++;
        if (_counter >= _limit) {
          // Stop the timer when the counter reaches the limit
          _timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Subscribers: $_counter',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}

