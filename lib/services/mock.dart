import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:uuid/v4.dart';
import 'dart:math' as math;

const List<String> colors = [
  "green",
  "red",
  "orange",
  "yellow",
  "blue",
  "pink",
  "cyan",
  "magenta",
  "coral",
  "brown"
];

class Mock {
  static String firstName() {
    return lorem(paragraphs: 1, words: 1).replaceAll(".", "");
  }

  static String lastName() {
    return lorem(paragraphs: 1, words: 1).replaceAll(".", "");
  }

  static String email() {
    return "${firstName()}@${lastName()}.com";
  }

  static String uid() {
    return UuidV4().generate();
  }

  static String imageUrl({String? firstName, String? lastName}) {
    return 'https://placehold.co/600x400/'
        '${colors[math.Random().nextInt(10)]}'
        '/${colors[math.Random().nextInt(10)]}.png';
  }
}
