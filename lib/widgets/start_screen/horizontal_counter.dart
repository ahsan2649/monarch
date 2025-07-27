import 'package:flutter/material.dart';

class HorizontalCounter extends StatelessWidget {
  const HorizontalCounter({
    super.key,
    required this.onIncrement,
    required this.onDecrement,
    required this.count,
    required this.text,
  });

  final int count;
  final String text;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 16,
      children: [
        Text(text, style: TextStyle(fontSize: 16),),
        Card(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 10,
            children: [
              IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: onDecrement,
                icon: const Icon(Icons.chevron_left_rounded),
              ),
              SizedBox(width: 28, child: Center(child: Text("$count", style: TextStyle(fontSize: 14)))),
              IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: onIncrement,
                icon: const Icon(Icons.chevron_right_rounded),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
