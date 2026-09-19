import 'package:flutter/material.dart';

class FighterHeader extends StatelessWidget {
  final String name;
  final Color color;

  const FighterHeader({
    super.key,
    required this.name,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        border: Border.all(
          color: color,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person,
            color: color,
            size: 40,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              name.toUpperCase(),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
