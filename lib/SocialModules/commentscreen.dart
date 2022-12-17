import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_app/SocialModels/ChatModel.dart';
import 'package:first_app/SocialModels/SocialUserModel.dart';
import 'package:first_app/SocialModels/commentmodel.dart';
import 'package:first_app/social_app/SocialCubit.dart';
import 'package:first_app/social_app/SocialStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentScreen extends StatelessWidget {
  SocialUserModel userModel;
  CommentScreen({this.userModel});
  var textcontrol=TextEditingController();
  @override
  Widget build(BuildContext context) {
        return  BlocConsumer<SocialCubit,SocialStates>(
          listener: (context,state){
            if(state is SendcommentSuccess)
              SocialCubit.get(context).getcomments(reciverId:SocialCubit.get(context).usermodel.uid);
          },
          builder: (context,state){
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Text("write your comment ")
              ),
              body:Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context,index){
                            var comment=SocialCubit.get(context).comments[index];
                            if(SocialCubit.get(context).usermodel.uid==comment.senderId)
                              return buildmycomment(comment);
                            return buildcomment(comment);
                          },
                          separatorBuilder:(context,index)=>SizedBox(height: 10,),
                          itemCount: SocialCubit.get(context).comments.length),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: Colors.grey
                          )
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: TextFormField(
                                controller: textcontrol,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'write your comment..'
                                ),
                              ),
                            ),
                          ),
                          MaterialButton(onPressed: (){
                            SocialCubit.get(context).sendcomment(
                                text: textcontrol.text,
                                 reciverId: SocialCubit.get(context).usermodel.uid,
                                datetime: DateTime.now().toString(),
                                );
                          },
                            child:Icon(Icons.send,size: 25,color: Colors.blueAccent,) ,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },

        );
  }
  Widget buildcomment(CommentModel model)=> Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius:BorderRadiusDirectional.only(
            topEnd: Radius.circular(10),
            topStart: Radius.circular(10),
            bottomEnd: Radius.circular(10),
          )
      ),
      child: Text(model.text,style: TextStyle(fontSize: 20),),
    ),
  );
  Widget buildmycomment(CommentModel model)=>  Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.3),
          borderRadius:BorderRadiusDirectional.only(
            topEnd: Radius.circular(10),
            topStart: Radius.circular(10),
            bottomStart: Radius.circular(10),
          )
      ),
      child: Text(model.text,style: TextStyle(fontSize: 20),),
    ),
  );
}
