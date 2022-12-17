import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/SocialModels/ChatModel.dart';
import 'package:first_app/SocialModels/PostModel.dart';
import 'package:first_app/SocialModels/SocialUserModel.dart';
import 'package:first_app/SocialModels/commentmodel.dart';
import 'package:first_app/SocialModules/Add_post.dart';
import 'package:first_app/SocialModules/Chat_Screen.dart';
import 'package:first_app/SocialModules/FeedScreen.dart';
import 'package:first_app/SocialModules/SocialSettingScreen.dart';
import 'package:first_app/SocialModules/UsersScreen.dart';
import 'package:first_app/shared/CONSTS.dart';
import 'package:first_app/social_app/SocialStates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates>{

  SocialCubit() : super(InitialSocialState());
  static SocialCubit get(context)=>BlocProvider.of(context);
  SocialUserModel usermodel;
  void getuserdate(){
    emit(LoadingSocialState());
    FirebaseFirestore.instance.collection('Users').doc(UId).get().then((value) {
      usermodel=SocialUserModel.fromJson(value.data());
  // print(value.data());
   emit(SocialSuccessState());
    }).catchError((error){
print("error get is ${error.toString()}");
emit(SocialErrorState(error));
    });
//  emit(LoadingSocialState());
//  FirebaseFirestore.instance.collection('Users').doc(UId).snapshots()
//      .listen((event) {
//    usermodel=SocialUserModel.fromJson(event.data());
//    emit(SocialSuccessState());
//  });
  }
  var currentindex=0;
  List<Widget> screens=[
    FeedsScreen(),
    ChatsScreen(),
    AddPostScreen(),
    UsersScreen(),
    SettingScreen(),
  ];
  List<String> titles=[
    'Facebooketa',
    'Chats',
    'Post',
    'Users',
    'Setting',
  ];
void changnav(int index){
  if(index==1)
    getallusers();
  if(index ==2){
    emit(SocialAddpostChange());
  }else{
    currentindex=index;
    emit(SocialNavigaChange());
  }

}
File profileimage;
final picker=ImagePicker();
Future getImageProfile()async{
  final FilePicker= await picker.getImage(source: ImageSource.gallery);
  if(FilePicker != null){
    profileimage=File(FilePicker.path);
    emit(ImageProfileSuccessState());
  }else{
    print("No image selected");
    emit(ImageProfileErrorState());
  }
}
File CoverImage;
  Future getImageCover()async{
    final FilePicker= await picker.getImage(source: ImageSource.gallery);
    if(FilePicker != null){
      CoverImage=File(FilePicker.path);
      emit(ImageProfileCoverSuccessState());
    }else{
      print("No image selected");
      emit(ImageProfileCoverErrorState());
    }
  }

void uploadeprofileimage({
  @required String name,
  @required String phone,
  @required String bio}){
  emit(UpdateUserLodingState());
    firebase_storage.FirebaseStorage.instance.ref()
        .child('users/${Uri.file(profileimage.path).pathSegments.last}')
        .putFile(profileimage).then((value){
          value.ref.getDownloadURL().then((value) {
            //emit(SocialUploadeimageProfileSuccessState());
            updatuserdate(
              name: name,
              phone: phone,
              bio: bio,
              image: value,
            );
           // print(value);
          }).catchError((){
            emit(SocialUploadeimageProfileErrorState());
          });
    }).catchError((error){
          print(error.toString());
          emit( SocialUploadeimageProfileErrorState());
    });
}


  void uploadeCoverimage({
    @required String name,
    @required String phone,
    @required String bio}){
    emit(UpdateUserLodingState());
    firebase_storage.FirebaseStorage.instance.ref()
        .child('users/${Uri.file(CoverImage.path).pathSegments.last}')
        .putFile(CoverImage).then((value){
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadeimageCovereSuccessState());
        updatuserdate(name: name, phone: phone, bio: bio,cover: value);
        //print(value);
      }).catchError((){
        emit(SocialUploadeimageCovereErrorState());
      });
    }).catchError((error){
      print(error.toString());
      emit( SocialUploadeimageCovereErrorState());
    });
  }

//  void updateuser({@required String name,
//  @required String phone,
//  @required String bio,
//  }){
//    emit(UpdateUserLodingState());
//    if(CoverImage != null){
//      uploadeCoverimage();
//    }else if(profileimage !=null)
//    {
//      uploadeprofileimage();
//    }else if(CoverImage != null && profileimage !=null ){
//
//
//    }else{
//     updatuserdate(name: name, phone: phone, bio: bio);
//    }
//
//  }
//

void updatuserdate(
    {
  @required String name,
  @required String phone,
  @required String bio,
      String cover,
      String image,
   }){
    emit(UpdateUserLodingState());
  SocialUserModel model=SocialUserModel(
    name: name,
    phone: phone,
    password: usermodel.password,
    email: usermodel.email,
    uid:usermodel.uid ,
    image:image?? usermodel.image,
    cover:cover?? usermodel.cover,
    bio: bio,
  );
  FirebaseFirestore.instance.collection('Users').
  doc(model.uid).
  update(model.tomap()).
  then((value) {
    getuserdate();
  }).
  catchError((error){
    emit(UpdateUserErrorState());
  });
}

  File postImage;
  Future getpostimage()async{
    final FilePicker= await picker.getImage(source: ImageSource.gallery);
    if(FilePicker != null){
      postImage=File(FilePicker.path);
      emit(SocialpickpostimageSuccessstate());
    }else{
      print("No image selected");
      emit(SocialpickpostimageErrorstate());
    }
  }

  void createpostwithImage({
    @required String datetime,
    @required String text}){
    emit(Sociacreatpostimageloadingstate());
    firebase_storage.FirebaseStorage.instance.ref()
        .child('posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage).then((value){
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadeimageCovereSuccessState());
       createpost(datetime: datetime, text: text,postImage: value);
        //print(value);
      }).catchError((){
        emit(SocialcreatpostimageSuccessstate());
      });
    }).catchError((error){
      print(error.toString());
      emit( SocialcreatpostimageErrorstate());
    });
  }

void removepostimage(){
    postImage=null;
    emit(Socialremovepostimagestate());

}

  void createpost(
      {
        @required String datetime,
        @required String text,
         String postImage,
      }){
    emit(Sociacreatpostimageloadingstate());
    PostModel model=PostModel(
      name: usermodel.name,
      text: text,
      datetime: datetime,
      uid:usermodel.uid ,
      image: usermodel.image,
      postimage: postImage?? "",
    );
    FirebaseFirestore.instance.collection('posts').
    add(model.tomap()).
    then((value) {
     emit(SocialcreatpostimageSuccessstate());
    }).
    catchError((error){
      emit(SocialcreatpostimageSuccessstate());
    });
  }
List<PostModel> posts =[];
  List<String> postId=[];
  List<int> likes=[];
void getposts({@required String datetime,}){
    emit(Getpostssuccessloading());
//    FirebaseFirestore.instance.collection('posts').get().
//    then((value) {
//      value.docs.forEach((element){
//        postId.add(element.id);
//        posts.add(PostModel.fromJson(element.data()));
//      });
//    }).catchError((error){
//      emit(GetpostssuccessError(error.toString()));
//    });
      FirebaseFirestore.instance.collection('posts').orderBy('datetime').
      snapshots().listen((event) {
        event.docs.forEach((element) {
          if(element.data()['UId'] != usermodel.uid)
          posts.add(PostModel.fromJson(element.data()));

          emit(GetpostssuccessSuccess());
        });
      });

}
//String postid;
void likePost(postId){
  FirebaseFirestore.instance.collection('posts').
  doc(postId).collection('likes').doc(usermodel.uid).set({
    'like':true,
  }).then((value) {
    emit(GetlikepostssuccessSuccess());
  }).catchError((error){
    emit(GetlikepostssuccessError(error.toString()));
  });
}
void getLikes(){
  FirebaseFirestore.instance.collection('posts').doc(usermodel.uid).collection('likes').doc(usermodel.uid).
  get(
  ).then((value){
        postId.add(value.id);
        likes.add(value.data().length);
    emit(GetlikepostssuccessSuccess());
  }).catchError((error){
    emit(GetlikepostssuccessError(error.toString()));
  });
}
bool like=false;
int lik=0;
void changelike(){
  like= !like;
  if(like==false){
    lik=0;
  // ignore: unrelated_type_equality_checks
  }else if(like==true){
    lik++;
  }else{
    lik=0;
  }
  //postId=usermodel.uid;
  emit(changelikeState());
}
List<SocialUserModel> users=[];
void getallusers(){

  emit(getalluserloading());
  if(users.length==0)
  FirebaseFirestore.instance.collection('Users').get().
  then((value) {
    value.docs.forEach((element){
      if(element.data()['UId'] != usermodel.uid){
        users.add(SocialUserModel.fromJson(element.data()));
      }
      emit(getalluserSuccess());
    });
  }).catchError((error){
    emit(getalluserError(error.toString()));
  });
}

void sendmessage({
  @required String text,
  @required String datetime,
  @required String reciverId,
}){
ChatModel model=ChatModel(
  text: text,
  datetime: datetime,
  reciverId: reciverId,
  senderId: usermodel.uid,
);
FirebaseFirestore.instance.collection('Users').
  doc(usermodel.uid).collection('chats').doc(reciverId).
  collection('messages').add(model.tomap()).then((value) {
    emit(SendmessageSuccess());
}).catchError((){
  emit(SendmessageError());
});

FirebaseFirestore.instance.collection('Users').
doc(reciverId).collection('chats').doc(usermodel.uid).
collection('messages').add(model.tomap()).then((value) {
  emit(SendmessageSuccess());
}).catchError((){
  emit(SendmessageError());
});

}
List<ChatModel> messages=[];
void getmessages({ @required String reciverId,}){

  FirebaseFirestore.instance.collection('Users').
  doc(usermodel.uid).collection('chats').doc(reciverId).
  collection('messages').orderBy('datetime').snapshots().
  listen((event) {
    messages=[];
    event.docs.forEach((element) {
      messages.add(ChatModel.fromJson(element.data()));
    });
    emit(GetmessageSuccess());
  });
}

List<CommentModel> comments=[];
void sendcomment({@required String text,
  @required String datetime,
  @required String reciverId,}){
  CommentModel model=CommentModel(
    text: text,
    datetime: datetime,
    reciverId: reciverId,
    senderId: usermodel.uid,
  );
  FirebaseFirestore.instance.collection('Users').
  doc(usermodel.uid).collection('comments').doc(reciverId).
  collection('comment').add(model.tomap()).then((value) {
    emit(SendcommentSuccess());
  }).catchError((error){
    emit(SendcommentError());
  });
}

void getcomments({ @required String reciverId,}){

  FirebaseFirestore.instance.collection('Users').
  doc(usermodel.uid).collection('comments').doc(reciverId).
  collection('comment').orderBy('datetime').snapshots().
  listen((event) {
    comments=[];
    event.docs.forEach((element) {
      comments.add(CommentModel.fromJson(element.data()));
    });
    emit(GetcommentSuccess());
  });


}
//  void updateuser({@required String name,
//  @required String phone,
//  @required String bio,
//  }){
//    emit(UpdateUserLodingState());
//    if(CoverImage != null){
//      uploadeCoverimage();
//    }else if(profileimage !=null)
//    {
//      uploadeprofileimage();
//    }else if(CoverImage != null && profileimage !=null ){
//
//
//    }else{
//     updatuserdate(name: name, phone: phone, bio: bio);
//    }
//
//  }
//
}