import 'package:flutter/material.dart';

import '../controllers/timer_controller.dart';

class TimerDisplay extends StatelessWidget {
  final TimerController timerController;

  const TimerDisplay({
    super.key,
    required this.timerController,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: timerController,
      builder: (context, child) {
        return Column(
          children: [
            Text(
              timerController.formattedTime,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 42,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: timerController.isRunning
                      ? timerController.pauseTimer
                      : timerController.startTimer,
                  child: Text(
                    timerController.isRunning ? 'PAUSE' : 'START',
                  ),
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                  onPressed: timerController.resetTimer,
                  child: const Text('RESET'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
