import 'package:flutter/material.dart';

import '../controllers/score_controller.dart';
import '../controllers/timer_controller.dart';
import '../controllers/penalty_controller.dart';
import '../controllers/match_controller.dart';

import '../widgets/fighter_header.dart';
import '../widgets/score_board.dart';
import '../widgets/scoring_button.dart';
import '../widgets/penalty_panel.dart';
import '../widgets/timer_display.dart';

class ScoringScreen extends StatefulWidget {
  final String redFighter;
  final String blueFighter;

  const ScoringScreen({
    super.key,
    this.redFighter = 'RED',
    this.blueFighter = 'BLUE',
  });

  @override
  State<ScoringScreen> createState() => _ScoringScreenState();
}

class _ScoringScreenState extends State<ScoringScreen> {
  // ============================================================
  // CONTROLLERS
  // ============================================================

  late ScoreController scoreController;
  late TimerController timerController;
  late PenaltyController penaltyController;
  late MatchController matchController;

  // ============================================================
  // INITIALIZE
  // ============================================================

  @override
  void initState() {
    super.initState();

    scoreController = ScoreController();

    timerController = TimerController();

    penaltyController = PenaltyController();

    matchController = MatchController(
      scoreController: scoreController,
      penaltyController: penaltyController,
      timerController: timerController,
    );
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    scoreController.dispose();
    timerController.dispose();
    penaltyController.dispose();
    matchController.dispose();

    super.dispose();
  }

  // ============================================================
  // NEXT ROUND
  // ============================================================

  void nextRound() {
    if (matchController.currentRound < matchController.totalRounds) {
      matchController.nextRound();

      setState(() {});
    } else {
      showMatchResult();
    }
  }

  // ============================================================
  // SHOW MATCH RESULT
  // ============================================================

  void showMatchResult() {
    final redFinal = matchController.finalRedScore;

    final blueFinal = matchController.finalBlueScore;

    final winner = matchController.getWinner(
      widget.redFighter,
      widget.blueFighter,
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF151515),
          title: const Text(
            'MATCH RESULT',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text(
                        'RED',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$redFinal',
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    '-',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  Column(
                    children: [
                      const Text(
                        'BLUE',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$blueFinal',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'WINNER: $winner',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);

                // Reset entire match
                matchController.resetMatch();

                setState(() {});
              },
              child: const Text(
                'NEW MATCH',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              // ==================================================
              // FIGHTERS + TIMER
              // ==================================================

              Row(
                children: [
                  Expanded(
                    child: FighterHeader(
                      name: widget.redFighter,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          'TANDING',
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                          ),
                        ),
                        const SizedBox(height: 5),
                        TimerDisplay(
                          timerController: timerController,
                        ),
                        AnimatedBuilder(
                          animation: matchController,
                          builder: (context, child) {
                            return Text(
                              'ROUND ${matchController.currentRound} '
                              '/ ${matchController.totalRounds}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FighterHeader(
                      name: widget.blueFighter,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ==================================================
              // SCOREBOARD
              // ==================================================

              ScoreBoard(
                scoreController: scoreController,
              ),

              const SizedBox(height: 20),

              // ==================================================
              // SCORING BUTTONS
              // ==================================================

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // RED
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          'RED',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ScoringButton(
                          title: 'KICK',
                          points: 2,
                          color: Colors.red,
                          onPressed: () {
                            scoreController.addRedScore(2);
                          },
                        ),
                        const SizedBox(height: 8),
                        ScoringButton(
                          title: 'HAND',
                          points: 1,
                          color: Colors.red,
                          onPressed: () {
                            scoreController.addRedScore(1);
                          },
                        ),
                        const SizedBox(height: 8),
                        ScoringButton(
                          title: 'TAKEDOWN',
                          points: 3,
                          color: Colors.red,
                          onPressed: () {
                            scoreController.addRedScore(3);
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 20),

                  // BLUE
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          'BLUE',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ScoringButton(
                          title: 'KICK',
                          points: 2,
                          color: Colors.blue,
                          onPressed: () {
                            scoreController.addBlueScore(2);
                          },
                        ),
                        const SizedBox(height: 8),
                        ScoringButton(
                          title: 'HAND',
                          points: 1,
                          color: Colors.blue,
                          onPressed: () {
                            scoreController.addBlueScore(1);
                          },
                        ),
                        const SizedBox(height: 8),
                        ScoringButton(
                          title: 'TAKEDOWN',
                          points: 3,
                          color: Colors.blue,
                          onPressed: () {
                            scoreController.addBlueScore(3);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // ==================================================
              // PENALTIES
              // ==================================================

              Row(
                children: [
                  Expanded(
                    child: AnimatedBuilder(
                      animation: penaltyController,
                      builder: (context, child) {
                        return PenaltyPanel(
                          title: 'RED PENALTY',
                          color: Colors.red,
                          penaltyCount: penaltyController.redPenalty,
                          onPressed: penaltyController.addRedPenalty,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: AnimatedBuilder(
                      animation: penaltyController,
                      builder: (context, child) {
                        return PenaltyPanel(
                          title: 'BLUE PENALTY',
                          color: Colors.blue,
                          penaltyCount: penaltyController.bluePenalty,
                          onPressed: penaltyController.addBluePenalty,
                        );
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // ==================================================
              // MATCH CONTROLS
              // ==================================================

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: nextRound,
                      icon: const Icon(
                        Icons.skip_next,
                      ),
                      label: const Text(
                        'NEXT ROUND',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: showMatchResult,
                      icon: const Icon(
                        Icons.flag,
                      ),
                      label: const Text(
                        'END MATCH',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
