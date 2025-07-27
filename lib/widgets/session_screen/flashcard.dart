import 'dart:math';
import 'package:flutter/material.dart';
import 'package:monarch/models/flashcard_model.dart';

class Flashcard extends StatefulWidget {
  final FlashcardModel flashcardInfo;

  const Flashcard({super.key, required this.flashcardInfo});

  @override
  State<Flashcard> createState() => _FlashcardState();
}

class _FlashcardState extends State<Flashcard> {
  bool showFront = true;

  void _flipCard() {
    setState(() {
      showFront = !showFront;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flipCard,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          final rotate = Tween(begin: pi, end: 0.0).animate(animation);
          return AnimatedBuilder(
            animation: rotate,
            child: child,
            builder: (context, child) {
              final isUnder = (ValueKey(showFront) != child!.key);
              var tilt = (animation.value - 0.5).abs() - 0.5;
              tilt *= isUnder ? -0.003 : 0.003;
              final value = isUnder ? min(rotate.value, pi / 2) : rotate.value;
              return Transform(
                transform: Matrix4.rotationY(value)..setEntry(3, 0, tilt),
                alignment: Alignment.center,
                child: child,
              );
            },
          );
        },
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        child: showFront
            ? Card(
                key: ValueKey(true),
                child: SizedBox(
                  width: 225,
                  height: 225,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(child: Text(widget.flashcardInfo.frontText)),
                  ),
                ),
              )
            : Card(
                key: ValueKey(false),
                color: Colors.blue[100],
                child: SizedBox(
                  width: 225,
                  height: 225,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(child: Text(widget.flashcardInfo.backText)),
                  ),
                ),
              ),
      ),
    );
  }
}
