
import 'package:scoped_model/scoped_model.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'dart:async';
//example model
class UserModel extends Model{

  //model parameters
  String _name = 'aaron';
  int _id = 0;
  Map<String, double> _location = new Map();

  //model functions
  void changeName(String name){
    _name = name;
    notifyListeners();
  }

  void incrementID(){
    _id++;
    notifyListeners();
  }

   void setLocal (Map local) async{
    _location = local;
    notifyListeners();

  }

  //example retrieval
  int get id => _id;

  String get name => _name;

  Map<String, double> get location => _location;
}