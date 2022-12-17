class FavoritesModel{

  bool status;
  String massage;
  FavoritesModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    massage=json['message'];
  }
}