
import 'dart:math';
import 'package:english_words/english_words.dart';

class ExamplesModel {

  int id;
  String name;
  String subtitle;
  String tag;
  DateTime createdOn;

  ExamplesModel({this.id, this.name, this.subtitle, this.tag, this.createdOn}) {
    if (createdOn == null) this.createdOn = DateTime.now();
    if (id == null) {
       this.id = Random().nextInt(100);
    }
  }

  static List<ExamplesModel> generate(int count) {
    return List.generate(count, (index) {
      return ExamplesModel(name: nouns[index] + " " + nouns[Random().nextInt(nouns.length - 2)], subtitle: adjectives[index]);
    });
  }

}