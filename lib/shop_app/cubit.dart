
import 'package:first_app/Network/Dio.dart';
import 'package:first_app/modelsShop/loginmodel.dart';
import 'package:first_app/shared/CONSTS.dart';
import 'package:first_app/shop_app/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<Shoploginstates> {
  ShopLoginCubit() :super(InitialShopLogin());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel loginModel;
  void userlogin({
    @required String email,
    @required String password,
  }) {
    emit(LodingShopLogin());
    DoiHelper.postdata(
        url: 'login',
        data: {
          'email': email,
          'password': password,
        }).then((value) {
      loginModel = ShopLoginModel.fromJason(value.data);
      // print("message is ${loginModel.message}");
      // print(loginModel.status);
      emit(ShopLoginSuccess(loginModel));
    }).catchError((error) {
      print("the error is $error");
      emit(ShopLoginError(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off;
  bool ispassword = true;
  void changpassword() {
    ispassword = !ispassword;
    suffix = ispassword ? Icons.visibility_off : Icons.visibility;
    emit(Changpassword());
  }
}