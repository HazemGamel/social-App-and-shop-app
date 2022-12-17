abstract class Socialloginstates{}

class InitialSocialLogin extends Socialloginstates{}
class LodingSocialLogin extends Socialloginstates{}
class SocialLoginSuccess extends Socialloginstates{
  final String UId;

  SocialLoginSuccess(this.UId);
}
class SocialLoginError extends Socialloginstates{
  final String error;
  SocialLoginError(this.error);
}
class SocialChangpassword extends Socialloginstates{}