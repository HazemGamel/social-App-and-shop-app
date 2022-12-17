abstract class SocialRegisterstates{}

class InitialSocialRegister extends SocialRegisterstates{}
class LodingSocialRegister extends SocialRegisterstates{}
class SocialRegisterSuccess extends SocialRegisterstates{
}
class SocialRegisterError extends SocialRegisterstates{
  final String error;
  SocialRegisterError(this.error);
}

class SocialCreateUserSuccess extends SocialRegisterstates{
}
class SocialCreateUserError extends SocialRegisterstates{
  final String error;
  SocialCreateUserError(this.error);
}
class SocialRegisterChangpassword extends SocialRegisterstates{}