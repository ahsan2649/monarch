class WordlistItemModel {
  final String word;
  final String translation;
  final List<String> sentences;

  const WordlistItemModel({
    required this.word,
    required this.translation,
    required this.sentences,
  });
}
