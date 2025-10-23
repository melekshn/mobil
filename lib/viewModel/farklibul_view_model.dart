import 'package:flutter/cupertino.dart';

class FarkliBulViewModel extends ChangeNotifier{
  bool kontrol = false;

  void Kontrol(String imagepath, String harf){
    if(imagepath == harf){
      kontrol =true;
    }else{
      kontrol=false;
    }
    notifyListeners();
  }
}