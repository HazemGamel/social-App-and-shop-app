import 'package:first_app/SocialModels/SocialUserModel.dart';
import 'package:first_app/social_app/SocialCubit.dart';
import 'package:first_app/social_app/SocialStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPostScreen extends StatelessWidget {
  var textcontrol=TextEditingController();
  SocialUserModel model;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){
      },
      builder: (context,state){
        return  Scaffold(
          appBar: AppBar(
            title: Text("Add Your Post"),
            actions: [
              TextButton(onPressed: (){
                var now =DateTime.now();
                if(SocialCubit.get(context).postImage ==null){
                  SocialCubit.get(context).createpost(datetime: now.toString(), text:textcontrol.text);
                }else{
                  SocialCubit.get(context).createpostwithImage(datetime: now.toString(), text: textcontrol.text);
                }
              }, child:Text("Post",style: TextStyle(fontSize: 20),)),
              SizedBox(width: 10,),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is Sociacreatpostimageloadingstate)
                LinearProgressIndicator(),
                if(state is Sociacreatpostimageloadingstate)
                SizedBox(height: 10,),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 23,
                      backgroundImage: NetworkImage('${SocialCubit.get(context).usermodel.image}'),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Text("${SocialCubit.get(context).usermodel.name}",style: TextStyle(fontWeight: FontWeight.w600,height: 1.4),),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.text,

                    maxLines: 3,
                    controller: textcontrol,
                    decoration: InputDecoration(
                      hintText: 'what is on your mind...',
                      border:InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                if(SocialCubit.get(context).postImage != null)
                  Expanded(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 300,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(7),
                                      topRight: Radius.circular(7),
                                    ),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:FileImage(SocialCubit.get(context).postImage),
                                    )
                                ),
                              ),
                              IconButton(icon: CircleAvatar(
                                  radius: 20,
                                  child: Icon(Icons.close)), onPressed: (){

                                SocialCubit.get(context).removepostimage();
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(onPressed: (){
                        SocialCubit.get(context).getpostimage();
                      },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image),
                            SizedBox(width: 5,),
                            Text("Add Photo"),
                          ],
                        ),),
                    ),
                    Expanded(
                      child: TextButton(onPressed: (){},
                        child: Text("# tags"),),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },

    );
  }
}
