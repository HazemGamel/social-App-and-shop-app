abstract class SocialStates{}

class InitialSocialState extends SocialStates{}
class LoadingSocialState extends SocialStates{}
class SocialSuccessState extends SocialStates{}
class SocialErrorState extends SocialStates{
  final String error;

  SocialErrorState(this.error);
}

class SocialNavigaChange extends SocialStates{}
class SocialAddpostChange extends SocialStates{}

class ImageProfileSuccessState extends SocialStates{}
class ImageProfileErrorState extends SocialStates{}

class ImageProfileCoverSuccessState extends SocialStates{}
class ImageProfileCoverErrorState extends SocialStates{}

class SocialUploadeimageProfileSuccessState extends SocialStates{}
class SocialUploadeimageProfileErrorState extends SocialStates{}
class SocialUploadeimageCovereSuccessState extends SocialStates{}
class SocialUploadeimageCovereErrorState extends SocialStates{}

class UpdateUserErrorState extends SocialStates{}
class UpdateUserLodingState extends SocialStates{}

class Socialpickpostimageloadingstate extends SocialStates{}
class SocialpickpostimageSuccessstate extends SocialStates{}
class SocialpickpostimageErrorstate extends SocialStates{}

class Sociacreatpostimageloadingstate extends SocialStates{}
class SocialcreatpostimageSuccessstate extends SocialStates{}
class SocialcreatpostimageErrorstate extends SocialStates{}

class Socialremovepostimagestate extends SocialStates{}

class Getpostssuccessloading extends SocialStates{}
class GetpostssuccessSuccess extends SocialStates{}
class GetpostssuccessError extends SocialStates{
  final String error;

  GetpostssuccessError(this.error);
}

class GetlikepostssuccessSuccess extends SocialStates{}
class GetlikepostssuccessError extends SocialStates{
  final String error;

  GetlikepostssuccessError(this.error);
}
class changelikeState extends SocialStates{}

class getalluserloading extends SocialStates{}
class getalluserSuccess extends SocialStates{}
class getalluserError extends SocialStates{
  final String error;

  getalluserError(this.error);

}

class SendmessageSuccess extends SocialStates{}
class SendmessageError extends SocialStates{}
class GetmessageSuccess extends SocialStates{}
class GetmessageError extends SocialStates{}

class SendcommentSuccess extends SocialStates{}
class SendcommentError extends SocialStates{}
class GetcommentSuccess extends SocialStates{}
class GetcommentError extends SocialStates{}