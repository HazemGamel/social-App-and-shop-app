class FavoritesGetModel{
  bool status;
  Favoritesdata  data;
  FavoritesGetModel.fomJson(Map<String ,dynamic>json){
    status =json['status'];
    data=Favoritesdata.fromJson(json['data']);
  }
}
class Favoritesdata{
  int current_page;
 List<ProductData> data=[];
  Favoritesdata.fromJson(Map<String,dynamic>Json){
    current_page=Json['current_page'];
    Json['data'].forEach((el){
      data.add(ProductData.fromJson(el));
    });

  }
}
 class ProductData{
  int id;
  products product;
  ProductData.fromJson(Map<String,dynamic>json){
    id=json['id'];
    product=products.fromJson(json['product']);
  }
 }

 class products{
  int id;
  dynamic price;
  dynamic oldprice;
  dynamic discount;
  String image;
  String name;
  products.fromJson(Map<String,dynamic>json){
    id=json['id'];
    price=json['price'];
    oldprice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
  }

 }
