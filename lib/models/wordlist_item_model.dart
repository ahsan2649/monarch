class WordlistItemModel {
  final String word;
  final String translation;
  final String sentences;

  const WordlistItemModel({
    required this.word,
    required this.translation,
    required this.sentences,
  });


  factory WordlistItemModel.fromMap(Map<String, dynamic> map){
    return WordlistItemModel(word: map["Word"] ?? map["Wort"], translation: map["Übersetzung"] ?? map["Translation"], sentences: map["Satz"] ?? map["Sentence"]);
  }
}
