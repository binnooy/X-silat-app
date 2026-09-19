import 'dart:async';
import 'package:flutter/foundation.dart';

class TimerController extends ChangeNotifier {
  Timer? _timer;

  int remainingSeconds = 180;

  bool isRunning = false;

  final int roundDuration = 180;

  // START
  void startTimer() {
    if (isRunning || remainingSeconds <= 0) {
      return;
    }

    isRunning = true;
    notifyListeners();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (remainingSeconds > 0) {
          remainingSeconds--;
          notifyListeners();
        } else {
          stopTimer();
        }
      },
    );
  }

  // PAUSE
  void pauseTimer() {
    _timer?.cancel();

    isRunning = false;

    notifyListeners();
  }

  // RESET
  void resetTimer() {
    _timer?.cancel();

    remainingSeconds = roundDuration;

    isRunning = false;

    notifyListeners();
  }

  // STOP
  void stopTimer() {
    _timer?.cancel();

    isRunning = false;

    notifyListeners();
  }

  // FORMAT TIME
  String get formattedTime {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;

    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
