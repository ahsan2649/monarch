import 'package:monarch/models/wordlist_info_model.dart';

class SessionInfoModel {
  final int wordCount;
  final int repeatCount;
  final WordlistInfoModel wordlistToUse;

  const SessionInfoModel({
    required this.wordCount,
    required this.repeatCount,
    required this.wordlistToUse,
  });
}
