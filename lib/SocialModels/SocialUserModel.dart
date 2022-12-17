
class SocialUserModel{
 String name;
 String email;
 String password;
 String phone;
 String uid;
 String image;
 String cover;
 String bio;
 bool isEmailVerified;

  SocialUserModel({this.name,
    this.email, this.password, this.phone, this.uid,this.image,this.cover,this.bio});
  SocialUserModel.fromJson(Map<String,dynamic>Json){
   name=Json['name'];
   image=Json['image'];
   cover=Json['cover'];
   bio=Json['bio'];
   email=Json['email'];
   password=Json['password'];
   phone=Json['phone'];
   uid=Json['uid'];
   isEmailVerified=Json['isEmailVerified'];
  }

  Map<String,dynamic> tomap(){
    return {
      'name':name,
      'email':email,
      'password':password,
      'phone':phone,
      'uid':uid,
      'image':image,
      'cover':cover,
      'bio':bio,
      'isEmailVerified':isEmailVerified,
    };
  }

}