
import 'package:first_app/modelsShop/loginmodel.dart';
abstract class Shoploginstates{}

class InitialShopLogin extends Shoploginstates{}
class LodingShopLogin extends Shoploginstates{}
class ShopLoginSuccess extends Shoploginstates{
  final ShopLoginModel loginModel;

  ShopLoginSuccess(this.loginModel);
}
class ShopLoginError extends Shoploginstates{
  final String error;
  ShopLoginError(this.error);
}
class Changpassword extends Shoploginstates{}