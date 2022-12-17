class CommentModel{
  String text;
  String datetime;
  String reciverId;
  String senderId;


  CommentModel({this.text,
    this.reciverId, this.senderId, this.datetime});
  CommentModel.fromJson(Map<String,dynamic>Json){
    text=Json['text'];
    datetime=Json['datetime'];
    reciverId=Json['reciverId'];
    senderId=Json['senderId'];
  }

  Map<String,dynamic> tomap(){
    return {
      'text':text,
      'datetime':datetime,
      'reciverId':reciverId,
      'senderId':senderId,
    };
  }

}