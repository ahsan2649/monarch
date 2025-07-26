import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monarch/models/flashcard_model.dart';
import 'package:monarch/widgets/session_screen/flashcard_stack.dart';

class SessionScreen extends StatefulWidget {
  final int wordCount;
  final int repeatCount;
  final Map<String, dynamic> selectedWordlist;
  const SessionScreen({
    super.key,
    required this.wordCount,
    required this.repeatCount,
    required this.selectedWordlist,
  });

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  int cardIndex = 0;
  List<FlashcardModel> wordlist = [];

  void _nextCard() {
    setState(() {
      if (wordlist.isNotEmpty) {
        wordlist.removeAt(cardIndex);
      }

      if (cardIndex >= wordlist.length) {
        Navigator.pop(context);
      }
    });
  }

  Future<void> _loadWordlist() async {
    final wordlistFile = await rootBundle.loadString(
      widget.selectedWordlist["path"],
    );
    final List<dynamic> wordlistJson = json.decode(wordlistFile);
    List<Map<String, dynamic>> allWords = wordlistJson
        .cast<Map<String, dynamic>>();
    allWords.shuffle(Random());
    final int count = widget.wordCount.clamp(1, allWords.length);
    setState(() {
      wordlist = allWords
          .take(count)
          .map(
            (word) => FlashcardModel(
              frontText: word["Wort"] ?? word["Word"],
              backText: word["Übersetzung"] ?? word["Translation"],
              extraText: word["Satz"] ?? word["Sentence"],
            ),
          )
          .toList();
      cardIndex = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadWordlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.selectedWordlist["label"])),
      body: wordlist.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlashcardStack(
                    cards: wordlist,
                    cardIndex: cardIndex,
                    nextCard: _nextCard,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(onPressed: _nextCard, icon: Icon(Icons.close)),
                      IconButton(onPressed: _nextCard, icon: Icon(Icons.check)),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
