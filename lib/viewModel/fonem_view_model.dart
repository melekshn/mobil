import 'package:flutter/cupertino.dart';

class FonemViewModel extends ChangeNotifier {
  bool kontrol = false;
  bool kontrol2=false;

  void Kontrol(String harf, String text) {
    text = text.toLowerCase();
    if (text.startsWith(harf.toLowerCase())) {
      kontrol = true;
    } else {
      kontrol = false;
    }
    notifyListeners();
  }
  void Kontrol2(String harf, String text) {
    text = text.toLowerCase();
    if (text.contains(harf.toLowerCase())) {
      kontrol2=true;
    }
    else{
      kontrol2=false;
    }
    notifyListeners();
  }
}
