import 'package:flutter/material.dart';
import 'package:monarch/screens/session_screen.dart';
import 'package:monarch/screens/wordlist_select_screen.dart';
import 'package:monarch/widgets/start_screen/horizontal_counter.dart';
import 'package:monarch/widgets/start_screen/title_card.dart';
import 'package:monarch/widgets/start_screen/wordlist_selector.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int wordCount = 5;
  int repeatCount = 2;
  Map<String, dynamic> selectedWordlist = {
    "label": "Goethe A1 Wordlist",
    "path": "assets/wordlists/goethe-a1.json",
  };

  void incrementWordCount() => setState(() => wordCount++);
  void decrementWordCount() => setState(() {
    if (wordCount > 1) wordCount--;
  });

  void incrementRepeatCount() => setState(() => repeatCount++);
  void decrementRepeatCount() => setState(() {
    if (repeatCount > 1) repeatCount--;
  });

  Future<void> switchWordlist() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WordlistSelectScreen()),
    );
    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        selectedWordlist = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 18,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TitleCard(),
            SizedBox(
              width: 250,
              child: Column(
                spacing: 10,
                children: [
                  HorizontalCounter(
                    onIncrement: incrementWordCount,
                    onDecrement: decrementWordCount,
                    count: wordCount,
                    text: "Word Count",
                  ),
                  HorizontalCounter(
                    onIncrement: incrementRepeatCount,
                    onDecrement: decrementRepeatCount,
                    count: repeatCount,
                    text: "Repeat Count",
                  ),
                  WordlistSelector(
                    selectedWordlist: selectedWordlist["label"],
                    onPressed: switchWordlist,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SessionScreen(
                            wordCount: wordCount,
                            repeatCount: repeatCount,
                            selectedWordlist: selectedWordlist,
                          ),
                        ),
                      );
                    },
                    child: Text("Start"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
