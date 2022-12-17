import 'package:first_app/modelsShop/Favorites_Model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopNavState extends ShopStates{}
class HomeDataloding extends ShopStates{}
class HomeDataSuccess extends ShopStates{}
class HomeDateError extends ShopStates{}
class CategoryDataSuccess extends ShopStates{}
class CategoryDateError extends ShopStates{}

class FavoriteGetDataSuccess extends ShopStates{}
class FavoriteLodingGetDataSuccess extends ShopStates{}
class FavoriteGetDateError extends ShopStates{}

class UpdateSuccess extends ShopStates{}
class UpdateLodingSuccess extends ShopStates{}
class UpdateError extends ShopStates{}

class SettingGetDataSuccess extends ShopStates{}
class SettingLodingGetDataSuccess extends ShopStates{}
class SettingGetDateError extends ShopStates{}


class FavoritesDataSuccess extends ShopStates{
  final FavoritesModel model;

  FavoritesDataSuccess(this.model);

}
class FavoritesDateError extends ShopStates{}
class FavoritesDateSuccess2 extends ShopStates{}