import 'package:flutter/cupertino.dart';

class MevsimViewModel extends ChangeNotifier{
  bool iskontrol = false;

  void kontrol(String path, String mevsim){
    if(path == mevsim){
      iskontrol = true;
    }else{
      iskontrol=false;
    }
    notifyListeners();
  }
}