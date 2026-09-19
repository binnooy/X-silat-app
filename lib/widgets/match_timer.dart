import 'dart:async';
import 'package:flutter/material.dart';

class MatchTimer extends StatefulWidget {
  final int initialSeconds;
  final VoidCallback? onTimeUp;

  const MatchTimer({
    super.key,
    this.initialSeconds = 180,
    this.onTimeUp,
  });

  @override
  State<MatchTimer> createState() => _MatchTimerState();
}

class _MatchTimerState extends State<MatchTimer> {
  late int remainingSeconds;
  Timer? timer;
  bool isRunning = false;

  @override
  void initState() {
    super.initState();
    remainingSeconds = widget.initialSeconds;
  }

  void startTimer() {
    if (isRunning || remainingSeconds <= 0) return;

    setState(() {
      isRunning = true;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        stopTimer();

        if (widget.onTimeUp != null) {
          widget.onTimeUp!();
        }
      }
    });
  }

  void pauseTimer() {
    timer?.cancel();

    setState(() {
      isRunning = false;
    });
  }

  void resetTimer() {
    timer?.cancel();

    setState(() {
      remainingSeconds = widget.initialSeconds;
      isRunning = false;
    });
  }

  void stopTimer() {
    timer?.cancel();

    setState(() {
      isRunning = false;
    });
  }

  String formatTime() {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;

    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          formatTime(),
          style: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: isRunning ? pauseTimer : startTimer,
              child: Text(isRunning ? 'PAUSE' : 'START'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: resetTimer,
              child: const Text('RESET'),
            ),
          ],
        ),
      ],
    );
  }
}
