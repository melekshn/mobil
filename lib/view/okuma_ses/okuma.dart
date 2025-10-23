import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/hikayeler.dart';

class ReadingPage extends StatelessWidget {
  final int storyIndex;

  const ReadingPage({super.key, required this.storyIndex});

  static const Map<String, Color> highlightColors = {
    'b': Color(0xFFC70039),
    'd': Color(0xFF9400FF),
    'p': Color(0xFF059212),
  };
  @override
  Widget build(BuildContext context) {
    // Ekranı dikey moda sabitle
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final story = stories[storyIndex];

    // Metni kelimelere ayır
    final words = story.text.split(' ');

    List<TextSpan> textSpans = [];

    for (var word in words) {
      // Her kelimedeki harfleri kontrol et
      List<TextSpan> letterSpans = word.split('').map((char) {
        final lowerChar = char.toLowerCase();
        final color = highlightColors[lowerChar] ?? Colors.black;
        return TextSpan(
          text: char,
          style: TextStyle(
            fontFamily: 'OpenDyslexic',
            fontSize: 22,
            height: 2,
            color: color,
          ),
        );
      }).toList();

      // Her kelimeden sonra bir boşluk ekle
      textSpans.add(TextSpan(children: letterSpans));
      textSpans.add(const TextSpan(text: ' '));
    }

    return Container(
        decoration: const BoxDecoration(
        image: DecorationImage(
        image: AssetImage('assets/images/background.png'),
    fit: BoxFit.cover,
    alignment: Alignment.center,
    ),
    ),
    child: Scaffold(
    backgroundColor: Colors.transparent,
    body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 100,right: 16,left: 16,bottom: 16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: const Color(0xFFEDD1B0),
          ),
          padding: const EdgeInsets.only(top: 30,right: 16,left: 16,bottom: 16),
          child: RichText(
            textAlign: TextAlign.start,
            text: TextSpan(children: textSpans),
          ),
        ),
      ),
    ),
    );
  }
}

