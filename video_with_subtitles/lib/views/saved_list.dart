import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class SavedWordsListPage extends StatefulWidget {
    final Set<WordPair> _saved;
    SavedWordsListPage(this._saved);
  @override
  _SavedWordsListPageState createState() => new _SavedWordsListPageState();
}
class _SavedWordsListPageState extends State<SavedWordsListPage> {
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    final Iterable<ListTile> tiles = widget._saved.map(
      (WordPair pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
        );
      },
    );

    final List<Widget> divided = ListTile
    .divideTiles(
      context: context,
      tiles: tiles,
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Suggestions'),
      ),
      body: ListView(children: divided),
      );
  }
}