
class PostModel{
  String name;
  String uid;
  String image;
  String text;
  String datetime;
  String postimage;
  bool isEmailVerified;

  PostModel({this.name,
    this.postimage, this.text, this.datetime, this.uid,this.image});
  PostModel.fromJson(Map<String,dynamic>Json){
    name=Json['name'];
    image=Json['image'];
    text=Json['text'];
    datetime=Json['datetime'];
    postimage=Json['postimage'];
    uid=Json['uid'];
  }

  Map<String,dynamic> tomap(){
    return {
      'name':name,
      'text':text,
      'uid':uid,
      'image':image,
      'datetime':datetime,
      'postimage':postimage,
    };
  }

}