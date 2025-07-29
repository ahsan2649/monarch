import 'package:flutter/material.dart';
import 'package:monarch/models/flashcard_model.dart';
import 'package:monarch/screens/start_screen.dart';

class ResultsScreen extends StatelessWidget {
  final List<FlashcardModel> wordlist;
  const ResultsScreen({super.key, required this.wordlist});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => StartScreen()),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => StartScreen()),
              );
            },
            icon: Icon(Icons.home),
          ),
          title: Text("Well Done!"),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(wordlist[index].frontText),
                            Text(wordlist[index].backText),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          spacing: 8,
                          children: [
                            Container(
                              height: 8,
                              width:
                                  100 *
                                  (wordlist[index].rememberCount /
                                      wordlist[index].reviewCount) + 5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.blueAccent,
                              ),
                            ),
                            Container(
                              height: 8,
                              width:
                                  100 *
                                  (wordlist[index].forgetCount /
                                      wordlist[index].reviewCount) + 5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(),
                  ],
                ),
              ),
            );
          },
          itemCount: wordlist.length,
        ),
      ),
    );
  }
}
