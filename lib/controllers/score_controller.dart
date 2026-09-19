import 'package:flutter/foundation.dart';

class ScoreController extends ChangeNotifier {
  // Current round scores
  int redScore = 0;
  int blueScore = 0;

  // RED scoring
  void addRedScore(int points) {
    redScore += points;
    notifyListeners();
  }

  // BLUE scoring
  void addBlueScore(int points) {
    blueScore += points;
    notifyListeners();
  }

  // Reset current round
  void resetRound() {
    redScore = 0;
    blueScore = 0;
    notifyListeners();
  }
}
