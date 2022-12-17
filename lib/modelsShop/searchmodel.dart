class SearchModel{
  bool status;
  Favoritesdata  data;
  SearchModel.fomJson(Map<String ,dynamic>json){
    status =json['status'];
    data=Favoritesdata.fromJson(json['data']);
  }
}
class Favoritesdata{
  int current_page;
  List<productss> data=[];
  Favoritesdata.fromJson(Map<String,dynamic>Json){
    current_page=Json['current_page'];
    Json['data'].forEach((el){
      data.add(productss.fromJson(el));
    });

  }
}

class productss{
  int id;
  dynamic price;
 // dynamic oldprice;
  dynamic discount;
  String image;
  String name;
  productss.fromJson(Map<String,dynamic>json){
    id=json['id'];
    price=json['price'];
   // oldprice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
  }

}
