import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  RandomWordsState createState() => RandomWordsState();
}

// RandomWordsState state -> internal state dari RandomWords Classes/States
// kenapa gk ada super? karena ini didalam class RandomWords(sebagai body(di MyApp))
// builder method untuk menjadikan  dynamic, seperti halnya iterator

class RandomWordsState extends State<RandomWords> {
  // berupa kata random berbahasa inggris( Wordpair milik package)
  // FLutter App is Just A Bunch of WIDGETS
  final _randomWordPairs = <WordPair>[];
  // need a place to store our saved word - Literal Wordpair {} MAP
  final _savedWordPairs = <WordPair>{};

  Widget _buildlist() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, item) {
          // jika ganjil kasih devider
          if (item.isOdd) return const Divider();
          // The ~/ operator returns an int --> int operator ~/(num other);
          final index = item ~/ 2;
          // menambahkan semua list integer sebanyak 10 kali
          if (index >= _randomWordPairs.length) {
            _randomWordPairs.addAll(generateWordPairs().take(10));
          }
          // HASILKAN widget row2 yang berparameter kata2 random sebanayk index
          return _buildRow(_randomWordPairs[index]);
        }
        /*
         children: <Widget>[
           Container(
             height: 50,
             color: Colors.amber[600],
             child: const Center(child: Text('Entry A')),
           ),
           Container(
             height: 50,
             color: Colors.amber[500],
             child: const Center(child: Text('Entry B')),
           ),
           Container(
             height: 50,
             color: Colors.amber[100],
             child: const Center(child: Text('Entry C')),
           ),
         ],
        */
        );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _savedWordPairs.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: const TextStyle(fontSize: 18.0),
      ),
      // Trailing - A widget to display after the title.
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _savedWordPairs.remove(pair);
          } else {
            _savedWordPairs.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _savedWordPairs.map((WordPair pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: const TextStyle(fontSize: 16.0),
          ),
        );
      });

      final List<Widget> divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();

      return Scaffold(
          appBar: AppBar(title: const Text('Saved Wordpair')),
          body: ListView(children: divided));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("simple app"),
        actions: <Widget>[
          IconButton(onPressed: _pushSaved, icon: const Icon(Icons.list))
        ],
      ),
      body: _buildlist(),
    );
  }
}

/// Widget untuk membuat cabang pohon (bikin sendiri widget)
