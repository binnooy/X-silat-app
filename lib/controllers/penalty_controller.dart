import 'package:flutter/foundation.dart';

class PenaltyController extends ChangeNotifier {
  int redPenalty = 0;
  int bluePenalty = 0;

  // Add RED penalty
  void addRedPenalty() {
    redPenalty++;
    notifyListeners();
  }

  // Add BLUE penalty
  void addBluePenalty() {
    bluePenalty++;
    notifyListeners();
  }

  // Reset penalties
  void resetPenalties() {
    redPenalty = 0;
    bluePenalty = 0;
    notifyListeners();
  }
}
