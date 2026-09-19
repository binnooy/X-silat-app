import 'package:flutter/material.dart';

import '../controllers/score_controller.dart';

class ScoreBoard extends StatelessWidget {
  final ScoreController scoreController;

  const ScoreBoard({
    super.key,
    required this.scoreController,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scoreController,
      builder: (context, child) {
        return Container(
          height: 190,
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(
              color: Colors.white,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // RED SCORE
              Expanded(
                child: Center(
                  child: Text(
                    scoreController.redScore.toString().padLeft(2, '0'),
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 90,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),

              // CENTER LINE
              Container(
                width: 2,
                height: double.infinity,
                color: Colors.white,
              ),

              // BLUE SCORE
              Expanded(
                child: Center(
                  child: Text(
                    scoreController.blueScore.toString().padLeft(2, '0'),
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 90,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
