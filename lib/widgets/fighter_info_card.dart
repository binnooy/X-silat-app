import 'package:flutter/material.dart';

import '../models/fighter.dart';

class FighterInfoCard extends StatelessWidget {
  final Fighter fighter;
  final Color color;
  final VoidCallback onEdit;

  const FighterInfoCard({
    super.key,
    required this.fighter,
    required this.color,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(
          color: color,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            Icons.person,
            color: color,
            size: 45,
          ),
          const SizedBox(height: 5),
          Text(
            fighter.name.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'AGE: ${fighter.age}',
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
          Text(
            'WEIGHT: ${fighter.weight.toStringAsFixed(1)} KG',
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
          Text(
            'FROM: ${fighter.from}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
          Text(
            'TEAM: ${fighter.team}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
          Text(
            'CATEGORY: ${fighter.category}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: onEdit,
            icon: const Icon(Icons.edit),
            label: const Text('EDIT FIGHTER'),
            style: OutlinedButton.styleFrom(
              foregroundColor: color,
              side: BorderSide(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
