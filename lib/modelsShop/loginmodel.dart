import 'package:flutter/cupertino.dart';

class ShopLoginModel{
  bool status;
  String message;
  UserData data;
  ShopLoginModel.fromJason(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    data=json['data'] != null? UserData.fromJason(json['data']):null;
  }
}
class UserData{
  int id;
  String name;
  String phone;
  String email;
  String image;
  String token;
  int points;
  int credit;

  UserData.fromJason(Map<String,dynamic>json){
     id=json['id'];
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    image=json['image'];
    token=json['token'];
    points=json['points'];
    credit=json['credit'];
  }
}