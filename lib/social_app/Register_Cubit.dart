import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/Network/Dio.dart';
import 'package:first_app/SocialModels/SocialUserModel.dart';
import 'package:first_app/modelsShop/loginmodel.dart';
import 'package:first_app/shared/CONSTS.dart';
import 'package:first_app/shop_app/ShopRegisterStates.dart';
import 'package:first_app/shop_app/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Register_States.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterstates> {
  SocialRegisterCubit() :super(InitialSocialRegister());
  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  SocialUserModel model;

  void userRegister({
    @required String email,
    @required String name,
    @required String phone,
    @required String password,
  }) {
    emit(LodingSocialRegister());
   FirebaseAuth.instance.createUserWithEmailAndPassword(
       email: email,
       password: password).then((value) {
         CreateUser(email: email,
             name: name, phone: phone, password: password, uId: value.user.uid);
        // print(value.user.email);
         emit(SocialRegisterSuccess());
   }).catchError((error){
     print("error register is ${error.toString()}");
     emit(SocialRegisterError(error));
   });
  }

  void CreateUser({
    @required String email,
    @required String name,
    @required String phone,
    @required String password,
    @required String uId,
  }){
    SocialUserModel model=SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      password: password,
      uid: uId,
      image:"https://cnn-arabic-images.cnn.io/cloudinary/image/upload/w_1120,c_scale,q_auto/cnnarabic/2020/11/23/images/170677.jpg",
      cover:'https://cnn-arabic-images.cnn.io/cloudinary/image/upload/w_1120,c_scale,q_auto/cnnarabic/2020/11/23/images/170677.jpg',
      bio: 'bio',
    );
    FirebaseFirestore.instance.collection('Users').doc(uId)
        .set(model.tomap())
        .then((value){
          emit(SocialCreateUserSuccess());
    }).catchError((error){
      print("error create user is ${error.toString()}");
      emit(SocialCreateUserError(error));
    });
  }

  IconData suffix = Icons.visibility_off;
  bool ispassword = true;
  void changpassword() {
    ispassword = !ispassword;
    suffix = ispassword ? Icons.visibility_off : Icons.visibility;
    emit(SocialRegisterChangpassword());
  }
}