import 'dart:math';
import 'package:flutter/cupertino.dart';

class SecViewModel extends ChangeNotifier {
  String harf = 'D';
  bool dogru = false;
  bool tiklandi = false;
  List<String> secenekler = [];

  SecViewModel() {
    karistir(); // ilk başta karıştır
  }

  void DKontrol(String secilenHarf) {
    dogru = (secilenHarf == harf);
    tiklandi = true;
    notifyListeners();
  }

  void karistir() {
    secenekler = ['B', harf];
    secenekler.shuffle(Random());
    notifyListeners();
  }

  void reset() {
    dogru = false;
    tiklandi = false;
    notifyListeners();
  }
}
