
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/Network/Dio.dart';
import 'package:first_app/modelsShop/loginmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_states.dart';

class SocialLoginCubit extends Cubit<Socialloginstates> {
  SocialLoginCubit() :super(InitialSocialLogin());
  static SocialLoginCubit get(context) => BlocProvider.of(context);
  void userlogin({
    @required String email,
    @required String password,
  }) {
    emit(LodingSocialLogin());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password).then((value) {
          //print("yes");
          emit(SocialLoginSuccess(value.user.uid));
    }).catchError((error){
      emit(SocialLoginError(error));
    });
  }
  IconData suffix = Icons.visibility_off;
  bool ispassword = true;
  void changpassword() {
    ispassword = !ispassword;
    suffix = ispassword ? Icons.visibility_off : Icons.visibility;
    emit(SocialChangpassword());
  }
}