import 'package:flutter/material.dart';

import '../controllers/score_controller.dart';
import '../controllers/penalty_controller.dart';
import '../controllers/match_controller.dart';

class ScoreBoard extends StatelessWidget {
  final ScoreController scoreController;
  final PenaltyController penaltyController;
  final MatchController matchController;

  const ScoreBoard({
    super.key,
    required this.scoreController,
    required this.penaltyController,
    required this.matchController,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        scoreController,
        penaltyController,
      ]),
      builder: (context, child) {
        final redNet = matchController.finalRedScore;
        final blueNet = matchController.finalBlueScore;

        return Container(
          height: 190,
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.white, width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    redNet.toString().padLeft(2, '0'),
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 90,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              Container(width: 2, height: double.infinity, color: Colors.white),
              Expanded(
                child: Center(
                  child: Text(
                    blueNet.toString().padLeft(2, '0'),
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
