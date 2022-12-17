import 'package:first_app/modelsShop/loginmodel.dart';
abstract class ShopRegisterstates{}

class InitialShopRegister extends ShopRegisterstates{}
class LodingShopRegister extends ShopRegisterstates{}
class ShopRegisterSuccess extends ShopRegisterstates{
  final ShopLoginModel loginModel;

  ShopRegisterSuccess(this.loginModel);
}
class ShopRegisterError extends ShopRegisterstates{
  final String error;
  ShopRegisterError(this.error);
}
class RegisterChangpassword extends ShopRegisterstates{}