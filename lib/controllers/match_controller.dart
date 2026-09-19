import 'package:flutter/foundation.dart';

import 'score_controller.dart';
import 'penalty_controller.dart';
import 'timer_controller.dart';

class MatchController extends ChangeNotifier {
  final ScoreController scoreController;
  final PenaltyController penaltyController;
  final TimerController timerController;

  MatchController({
    required this.scoreController,
    required this.penaltyController,
    required this.timerController,
  });

  // ============================================================
  // ROUND
  // ============================================================

  int currentRound = 1;

  final int totalRounds = 3;

  // ============================================================
  // TOTAL MATCH SCORE
  // ============================================================

  int redTotalScore = 0;
  int blueTotalScore = 0;

  // ============================================================
  // NEXT ROUND
  // ============================================================

  void nextRound() {
    // Add current round score to match total
    redTotalScore += scoreController.redScore;
    blueTotalScore += scoreController.blueScore;

    // Stop timer
    timerController.stopTimer();

    // Move to next round
    if (currentRound < totalRounds) {
      currentRound++;

      // Reset current round score
      scoreController.resetRound();

      // Reset timer
      timerController.resetTimer();

      notifyListeners();
    }
  }

  // ============================================================
  // FINAL RED SCORE
  // ============================================================

  int get finalRedScore {
    return redTotalScore + scoreController.redScore;
  }

  // ============================================================
  // FINAL BLUE SCORE
  // ============================================================

  int get finalBlueScore {
    return blueTotalScore + scoreController.blueScore;
  }

  // ============================================================
  // WINNER
  // ============================================================

  String getWinner(
    String redFighter,
    String blueFighter,
  ) {
    if (finalRedScore > finalBlueScore) {
      return redFighter;
    }

    if (finalBlueScore > finalRedScore) {
      return blueFighter;
    }

    return 'DRAW';
  }

  // ============================================================
  // RESET EVERYTHING
  // ============================================================

  void resetMatch() {
    currentRound = 1;

    redTotalScore = 0;
    blueTotalScore = 0;

    scoreController.resetRound();

    penaltyController.resetPenalties();

    timerController.resetTimer();

    notifyListeners();
  }
}
