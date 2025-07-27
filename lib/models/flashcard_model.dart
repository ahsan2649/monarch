class FlashcardModel {
  final String frontText;
  final String backText;
  final String extraText;
  
  int rememberCount = 0;
  int forgetCount = 0;
  int reviewCount = 0;

  FlashcardModel({
    required this.frontText,
    required this.backText,
    required this.extraText,
  });
}
