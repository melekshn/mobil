import 'package:flutter/material.dart';

class EggInputViewModel extends ChangeNotifier {

  bool kontrol=true;

  void SayiKontrol(String imgpath,String sayi){
    if(imgpath == sayi){
      kontrol =true;
    }else{
      kontrol =false;
    }
    notifyListeners();
  }
}
