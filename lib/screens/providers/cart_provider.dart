import 'package:flutter/cupertino.dart';

class CartProvider with ChangeNotifier {
  int? _nbItems ;
  int get nbitems => _nbItems ?? 3;
  
  void initialize(int k){
    print("hhhhhhhhhhhhhhhhhhh");
    _nbItems = k;
  }
  

  void update(){
    var temp = _nbItems;
    if(temp!=null){
      temp++;
    }
    _nbItems = temp;
    notifyListeners();
  }
}