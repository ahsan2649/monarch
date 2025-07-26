import 'package:flutter/material.dart';

class WordlistSelector extends StatelessWidget {
  final String selectedWordlist;
  final VoidCallback onPressed;

  const WordlistSelector({
    super.key,
    required this.selectedWordlist,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      onPressed: onPressed,
      child: Text(selectedWordlist, style: TextStyle(fontSize: 16)),
    );
  }
}
