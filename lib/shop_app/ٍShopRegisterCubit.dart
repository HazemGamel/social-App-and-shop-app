import 'package:first_app/Network/Dio.dart';
import 'package:first_app/modelsShop/loginmodel.dart';
import 'package:first_app/shared/CONSTS.dart';
import 'package:first_app/shop_app/ShopRegisterStates.dart';
import 'package:first_app/shop_app/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterstates> {
  ShopRegisterCubit() :super(InitialShopRegister());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel loginModel;
  void userRegister({
    @required String email,
    @required String name,
    @required String phone,
    @required String password,
  }) {
    emit(LodingShopRegister());
    DoiHelper.postdata(
        url: 'register',
        data: {
          'email':email,
          'name':name,
          'phone':phone,
          'password': password,
        }).then((value) {
      loginModel = ShopLoginModel.fromJason(value.data);
      // print("message is ${loginModel.message}");
      // print(loginModel.status);
      emit(ShopRegisterSuccess(loginModel));
    }).catchError((error) {
      print("the error is $error");
      emit(ShopRegisterError(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off;
  bool ispassword = true;
  void changpassword() {
    ispassword = !ispassword;
    suffix = ispassword ? Icons.visibility_off : Icons.visibility;
    emit(RegisterChangpassword());
  }
}