import 'package:flutter/material.dart';

import '../controllers/score_controller.dart';
import '../controllers/timer_controller.dart';
import '../controllers/penalty_controller.dart';
import '../controllers/match_controller.dart';

import '../models/fighter.dart';
import '../widgets/fighter_info_card.dart';
import '../widgets/score_board.dart';
import '../widgets/scoring_button.dart';
import '../widgets/penalty_panel.dart';
import '../widgets/timer_display.dart';

class ScoringScreen extends StatefulWidget {
  const ScoringScreen({
    super.key,
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
  // FIGHTERS
  // ============================================================

  late Fighter redFighter;
  late Fighter blueFighter;

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

    // Default RED fighter
    redFighter = Fighter(
      name: 'RED FIGHTER',
      age: 18,
      weight: 55,
      from: 'Philippines',
      team: 'Team Red',
      category: 'Tanding',
    );

    // Default BLUE fighter
    blueFighter = Fighter(
      name: 'BLUE FIGHTER',
      age: 18,
      weight: 55,
      from: 'Philippines',
      team: 'Team Blue',
      category: 'Tanding',
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
  // EDIT FIGHTER
  // ============================================================

  void editFighter(Fighter fighter) {
    final nameController = TextEditingController(
      text: fighter.name,
    );

    final ageController = TextEditingController(
      text: fighter.age.toString(),
    );

    final weightController = TextEditingController(
      text: fighter.weight.toString(),
    );

    final fromController = TextEditingController(
      text: fighter.from,
    );

    final teamController = TextEditingController(
      text: fighter.team,
    );

    final categoryController = TextEditingController(
      text: fighter.category,
    );

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF151515),
          title: const Text(
            'EDIT FIGHTER',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SizedBox(
            width: 450,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTextField(
                    controller: nameController,
                    label: 'Name',
                    icon: Icons.person,
                  ),
                  _buildTextField(
                    controller: ageController,
                    label: 'Age',
                    icon: Icons.cake,
                    keyboardType: TextInputType.number,
                  ),
                  _buildTextField(
                    controller: weightController,
                    label: 'Weight (kg)',
                    icon: Icons.monitor_weight,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                  _buildTextField(
                    controller: fromController,
                    label: 'From / Hometown',
                    icon: Icons.location_on,
                  ),
                  _buildTextField(
                    controller: teamController,
                    label: 'Team / Club',
                    icon: Icons.groups,
                  ),
                  _buildTextField(
                    controller: categoryController,
                    label: 'Category',
                    icon: Icons.emoji_events,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'CANCEL',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  fighter.name = nameController.text.trim().isEmpty
                      ? fighter.name
                      : nameController.text.trim();

                  fighter.age =
                      int.tryParse(ageController.text.trim()) ?? fighter.age;

                  fighter.weight =
                      double.tryParse(weightController.text.trim()) ??
                          fighter.weight;

                  fighter.from = fromController.text.trim().isEmpty
                      ? fighter.from
                      : fromController.text.trim();

                  fighter.team = teamController.text.trim().isEmpty
                      ? fighter.team
                      : teamController.text.trim();

                  fighter.category = categoryController.text.trim().isEmpty
                      ? fighter.category
                      : categoryController.text.trim();
                });

                Navigator.pop(dialogContext);
              },
              icon: const Icon(Icons.save),
              label: const Text('SAVE'),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // TEXT FIELD
  // ============================================================

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.white70,
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.white70,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.white30,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
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
      redFighter.name,
      blueFighter.name,
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
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
                  // RED
                  Column(
                    children: [
                      Text(
                        redFighter.name.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
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

                  // BLUE
                  Column(
                    children: [
                      Text(
                        blueFighter.name.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
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
                textAlign: TextAlign.center,
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
                Navigator.pop(dialogContext);

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // RED FIGHTER
                  Expanded(
                    child: FighterInfoCard(
                      fighter: redFighter,
                      color: Colors.red,
                      onEdit: () {
                        editFighter(redFighter);
                      },
                    ),
                  ),

                  const SizedBox(width: 10),

                  // TIMER + ROUND
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
                        const SizedBox(height: 5),
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

                  // BLUE FIGHTER
                  Expanded(
                    child: FighterInfoCard(
                      fighter: blueFighter,
                      color: Colors.blue,
                      onEdit: () {
                        editFighter(blueFighter);
                      },
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
                penaltyController: penaltyController,
                matchController: matchController,
              ),

              const SizedBox(height: 20),

              // ==================================================
              // SCORING BUTTONS
              // ==================================================

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ==================================================
                  // RED SCORING
                  // ==================================================

                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          redFighter.name.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 18,
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

                  // ==================================================
                  // BLUE SCORING
                  // ==================================================

                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          blueFighter.name.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
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
                  // RED PENALTY
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

                  // BLUE PENALTY
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
                  // NEXT ROUND
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

                  // END MATCH
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

              const SizedBox(height: 15),

              // ==================================================
              // FIGHTER INFORMATION NOTE
              // ==================================================

              const Text(
                'Fighter information can be edited using the EDIT FIGHTER button.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
