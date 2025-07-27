import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:monarch/models/wordlist_info_model.dart';

class WordlistSelectScreen extends StatelessWidget {
  const WordlistSelectScreen({super.key});

  Future<List<WordlistInfoModel>> _loadManifest() async {
      final manifestString = await rootBundle.loadString(
      'assets/wordlists/manifest.json',
    );
    final List<dynamic> manifestJson = json.decode(manifestString);

    return manifestJson.map((e) => WordlistInfoModel.fromMap(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Wordlist")),
      body: FutureBuilder<List<WordlistInfoModel>>(
        future: _loadManifest(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final wordlists = snapshot.data!;
          return ListView.builder(
            itemCount: wordlists.length,
            itemBuilder: (context, index) {
              final wordlist = wordlists[index];
              return ListTile(
                title: Text(wordlist.name),
                onTap: () {
                  Navigator.pop(context, wordlist);
                },
              );
            },
          );
        },
      ),
    );
  }
}
