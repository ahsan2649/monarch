  import 'package:flutter/material.dart';
  import 'package:monarch/models/session_info_model.dart';
  import 'package:monarch/models/wordlist_info_model.dart';
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
    SessionInfoModel sessionInfo = SessionInfoModel();

    void incrementWordCount() => setState(() => sessionInfo.wordCount++);
    void decrementWordCount() => setState(() {
      if (sessionInfo.wordCount > 1) sessionInfo.wordCount--;
    });

    void incrementRepeatCount() => setState(() => sessionInfo.repeatCount++);
    void decrementRepeatCount() => setState(() {
      if (sessionInfo.repeatCount > 1) sessionInfo.repeatCount--;
    });

    Future<void> switchWordlist() async {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WordlistSelectScreen()),
      );
      if (result != null && result is WordlistInfoModel) {
        setState(() {
          sessionInfo.wordlistToUse = result;
        });
      }
    }

    @override
    void initState() {
      super.initState();
      sessionInfo.wordlistToUse = WordlistInfoModel(name: "Goethe A1 Wordlist", path: "assets/wordlists/goethe-a1.json");
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
                      count: sessionInfo.wordCount,
                      text: "Word Count",
                    ),
                    HorizontalCounter(
                      onIncrement: incrementRepeatCount,
                      onDecrement: decrementRepeatCount,
                      count: sessionInfo.repeatCount,
                      text: "Repeat Count",
                    ),
                    WordlistSelector(
                      selectedWordlist: sessionInfo.wordlistToUse.name,
                      onPressed: switchWordlist,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SessionScreen(
                              sessionInfo: sessionInfo,
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
