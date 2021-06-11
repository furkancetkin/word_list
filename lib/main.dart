import 'package:flutter/material.dart';
import 'package:word_list/words.dart';

var keyAllWords = PageStorageKey("key_all_words");

void main() {
  runApp(MaterialApp(
    title: 'Words',
    routes: {
      '/': (context) => AllWords(keyAllWords),
    },
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        fontFamily: 'Mukta',
        accentColor: Colors.amber,
        primarySwatch: Colors.amber,
        buttonColor: Colors.amber),
  ));
}
