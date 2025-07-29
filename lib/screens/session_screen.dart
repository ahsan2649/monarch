import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monarch/models/flashcard_model.dart';
import 'package:monarch/models/session_info_model.dart';
import 'package:monarch/models/wordlist_item_model.dart';
import 'package:monarch/models/wordlist_model.dart';
import 'package:monarch/screens/results_screen.dart';
import 'package:monarch/widgets/session_screen/flashcard_stack.dart';

class SessionScreen extends StatefulWidget {
  final SessionInfoModel sessionInfo;
  const SessionScreen({super.key, required this.sessionInfo});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  int cardIndex = 0;
  List<FlashcardModel> wordlist = [];
  List<FlashcardModel> sessionList = [];

  void _nextCard(DismissDirection direction) {
    setState(() {
      if (sessionList.isNotEmpty) {
        var word = sessionList.removeAt(cardIndex);
        if (direction == DismissDirection.startToEnd) {
          wordlist
              .firstWhere((i) => i.frontText == word.frontText)
              .rememberCount++;
          wordlist
              .firstWhere((i) => i.frontText == word.frontText)
              .reviewCount++;
        }

        if (direction == DismissDirection.endToStart) {
          wordlist
              .firstWhere((i) => i.frontText == word.frontText)
              .forgetCount++;
          wordlist
              .firstWhere((i) => i.frontText == word.frontText)
              .reviewCount++;
        }
      }

      if (cardIndex >= sessionList.length) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsScreen(wordlist: wordlist),
          ),
        );
      }
    });
  }

  Future<void> _loadWordlist() async {
    final wordlistFile = await rootBundle.loadString(
      widget.sessionInfo.wordlistToUse.path,
    );
    final List<dynamic> wordlistJson = json.decode(wordlistFile);
    final wordlistModel = WordlistModel(
      words: wordlistJson
          .map(
            (item) => WordlistItemModel(
              word: item["Wort"] ?? item["Word"],
              translation: item["Übersetzung"] ?? item["Translation"],
              sentences: item["Satz"] ?? item["Sentence"],
            ),
          )
          .toList(),
    );

    wordlistModel.words.shuffle(Random());
    final int count = widget.sessionInfo.wordCount.clamp(
      1,
      wordlistModel.words.length,
    );

    setState(() {
      var words = wordlistModel.words.take(count).toList();
      wordlist = words
          .map(
            (item) => FlashcardModel(
              frontText: item.word,
              backText: item.translation,
              extraText: item.sentences,
            ),
          )
          .toList();
      sessionList = List.generate(widget.sessionInfo.repeatCount, (i) => words)
          .expand((i) {
            i.shuffle();
            return i;
          })
          .toList()
          .map(
            (item) => FlashcardModel(
              frontText: item.word,
              backText: item.translation,
              extraText: item.sentences,
            ),
          )
          .toList();
      sessionList.shuffle();
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
      appBar: AppBar(title: Text(widget.sessionInfo.wordlistToUse.name)),
      body: sessionList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlashcardStack(
                    cards: sessionList,
                    cardIndex: cardIndex,
                    nextCard: _nextCard,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          _nextCard(DismissDirection.endToStart);
                        },
                        icon: Icon(Icons.close),
                      ),
                      IconButton(
                        onPressed: () {
                          _nextCard(DismissDirection.startToEnd);
                        },
                        icon: Icon(Icons.check),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
