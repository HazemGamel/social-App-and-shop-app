import 'package:flutter/material.dart';

class HomeModel{
  bool status;
  HomeDataModel data;
  HomeModel.fromJson(Map<String ,dynamic>jason){
    status=jason['status'];
    data=jason['data'] != null?HomeDataModel.fromJson(jason['data']):null;
  }
}
class HomeDataModel{
  List< BannersModel> banners=[];
  List< ProductsModel> products=[];
  HomeDataModel.fromJson(Map<String,dynamic>jason){
     jason['banners'].forEach((e){
       banners.add(BannersModel.fromJson(e));
     });
     jason['products'].forEach((e){
       products.add(ProductsModel.fromJson(e));
     });
  }
}

class BannersModel{
  int id;
  String image;
  BannersModel.fromJson(Map<String,dynamic>jason){
    id=jason['id'];
    image=jason['image'];
  }

}
class ProductsModel{
   int id;
   dynamic price;
   dynamic oldPrice;
   dynamic discount;
   String image;
   String name;
   bool inFavorites;
   bool inCart;
  ProductsModel.fromJson(jason){
    id=jason['id'];
    price=jason['price'];
    oldPrice=jason['old_price'];
    discount=jason['discount'];
    image=jason['image'];
    name=jason['name'];
    inFavorites=jason['in_favorites'];
    inCart=jason['in_cart'];
  }

}