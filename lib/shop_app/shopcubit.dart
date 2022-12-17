import 'package:bloc/bloc.dart';
import 'package:first_app/Network/Dio.dart';
//import 'package:first_app/counter/cubit/SettingScreen.dart';
import 'package:first_app/modelsShop/CategoryModel.dart';
import 'package:first_app/modelsShop/FavoritesGetModel.dart';
import 'package:first_app/modelsShop/Favorites_Model.dart';
import 'package:first_app/modelsShop/Home_Model.dart';
import 'package:first_app/modelsShop/loginmodel.dart';
import 'package:first_app/shared/CONSTS.dart';
import 'package:first_app/shop_app/CategoryScreen.dart';
import 'package:first_app/shop_app/FavouriteScreen.dart';
import 'package:first_app/shop_app/ProductsScreen.dart';
import 'package:first_app/shop_app/settingscreen.dart';
import 'package:first_app/shop_app/shopstates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() :super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentindex = 0;
  List<Widget>bottomscreens=[
    ProductsScreen(),
    CategoryScreen(),
    FavouriteScreen(),
    settingscreen(),
  ];
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.category),
      label: 'Category',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Favorite',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Setting',
    ),
  ];
  void chandenav(index){
    currentindex=index;
      getCategoryData();
    emit(ShopNavState());
  }
 HomeModel homeModel;
  Map<int ,bool> favorites={};
  void getHomeData(){
    emit(HomeDataloding());
    DoiHelper.getData(
     Url:'home',
    token: token,).
    then((value){
      homeModel=HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((element) {
        favorites.addAll({
          element.id:element.inFavorites,
        });
      });
      //print(favorites.toString());
     //print(homeModel.status);
    // print(homeModel.data.banners[0].image);
      emit(HomeDataSuccess());
    }).catchError((e){
      print("error be ${e.toString()}");
      emit(HomeDateError());
    });
  }
  CategoryModel categoryModel;
  void getCategoryData(){
    DoiHelper.getData(Url:'categories').
    then((value) {
      categoryModel=CategoryModel.fomJason(value.data);
      emit(CategoryDataSuccess());
    }).catchError((error){
      print('Category error is${error.toString()}');
      emit(CategoryDateError());
    });
  }
 FavoritesModel favoritesModel;
  void ChangeFavorites(int ProductId){
  favorites[ProductId]=!favorites[ProductId];
  emit(FavoritesDateSuccess2());
    DoiHelper.postdata(
        url: 'favorites',
        data: {
      'product_id':ProductId,
        },
    token: token).then((value) {
         favoritesModel=FavoritesModel.fromJson(value.data);
         if(!favoritesModel.status){
           favorites[ProductId]=!favorites[ProductId];
         }else{
           getfavoritesdata();
         }
         //print(value.data);
          emit(FavoritesDataSuccess(favoritesModel));
    }).catchError((error){
      favorites[ProductId]=!favorites[ProductId];
      print("Favorites error is ${error.toString()}");
      emit(FavoritesDateError());
    });
  }


  FavoritesGetModel favoritesGetModel;

  void getfavoritesdata(){

     emit(FavoriteLodingGetDataSuccess());
    DoiHelper.getData(Url: 'favorites',token: token).then((value) {
      favoritesGetModel=FavoritesGetModel.fomJson(value.data);
     // print(value.data);
      emit(FavoriteGetDataSuccess());
    }).catchError((error){
      print("Favorite get data error is ${error.toString()}");
      emit(FavoriteGetDateError());
    });
  }

  ShopLoginModel UserModel;
  void getsettingdata(){
     emit(SettingLodingGetDataSuccess());
    DoiHelper.getData(Url: 'profile',
        token: token).then((value) {
          UserModel=ShopLoginModel.fromJason(value.data);
          // print(UserModel.data.name);
          emit(SettingGetDataSuccess());
    }).catchError((error){
      print("get data setting error is ${error.toString()}");
      emit(SettingGetDateError());
    });
  }
  void updatedata({
  @required String name,
  @required String email,
  @required String phone,
}){
    emit(UpdateLodingSuccess());

    DoiHelper.putData(url:'update-profile', token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      }
    ).then((value) {
      UserModel=ShopLoginModel.fromJason(value.data);
      // print(UserModel.data.name);
      emit(UpdateSuccess());
    }).catchError((error){
      print("get data setting error is ${error.toString()}");
      emit(UpdateError());
    });
  }


}