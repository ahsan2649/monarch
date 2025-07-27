class WordlistInfoModel {
  final String name;
  final String path;

  const WordlistInfoModel({required this.name, required this.path});

  factory WordlistInfoModel.fromMap(Map<String, dynamic> map) {
    return WordlistInfoModel(
      name: map['label'],  // Assuming 'label' is the name you want to use
      path: map['path'],   // Assuming 'path' is the key for the file path
    );
  }
}
