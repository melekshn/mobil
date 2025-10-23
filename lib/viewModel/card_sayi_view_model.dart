import 'package:flutter/material.dart';

class CardViewModel extends ChangeNotifier {
  final List<Color> _cardColors = List.generate(12, (index) => Colors.white);

  List<Color> get cardColors => _cardColors;

  final List<String> _numbers = [
    "12","34","56","87","90","14","30","69","77","26","23","45",
  ];

  List<String> get numbers => _numbers;

}
