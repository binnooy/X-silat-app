class MatchData {
  String redFighter;
  String blueFighter;

  int redScore;
  int blueScore;

  int redPenalties;
  int bluePenalties;

  MatchData({
    required this.redFighter,
    required this.blueFighter,
    this.redScore = 0,
    this.blueScore = 0,
    this.redPenalties = 0,
    this.bluePenalties = 0,
  });

  void addRedScore(int points) {
    redScore += points;
  }

  void addBlueScore(int points) {
    blueScore += points;
  }

  void addRedPenalty() {
    redPenalties++;
  }

  void addBluePenalty() {
    bluePenalties++;
  }

  String getWinner() {
    if (redScore > blueScore) {
      return redFighter;
    } else if (blueScore > redScore) {
      return blueFighter;
    } else {
      return 'DRAW';
    }
  }
}
