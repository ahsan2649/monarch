import 'package:flutter/material.dart';
import 'package:monarch/models/flashcard_model.dart';
import 'package:monarch/widgets/session_screen/flashcard.dart';

class FlashcardStack extends StatelessWidget {
  final List<FlashcardModel> cards;
  final int cardIndex;
  final DismissDirectionCallback nextCard;

  const FlashcardStack({
    super.key,
    required this.cards,
    required this.cardIndex,
    required this.nextCard,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (cardIndex < cards.length - 1)
          Card(
            color: Colors.grey[300],
            child: SizedBox(width: 225, height: 225),
          ),
        Dismissible(
          key: ValueKey(cards[cardIndex]),
          direction: DismissDirection.horizontal,
          onDismissed: nextCard,
          child: Flashcard(flashcardInfo: cards[cardIndex]),
        ),
      ],
    );
  }
}
