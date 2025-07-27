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
    return FilledButton.icon(
      style: FilledButton.styleFrom(padding: EdgeInsets.all(24)),
      onPressed: onPressed,
      icon: Icon(Icons.list, size: 28,),
      label: Text(selectedWordlist, style: TextStyle(fontSize: 18),),
      iconAlignment: IconAlignment.start,
    );
  }
}
