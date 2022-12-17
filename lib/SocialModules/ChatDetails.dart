import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_app/SocialModels/ChatModel.dart';
import 'package:first_app/SocialModels/SocialUserModel.dart';
import 'package:first_app/social_app/SocialCubit.dart';
import 'package:first_app/social_app/SocialStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreenDetiles extends StatelessWidget {
  SocialUserModel userModel;
  ChatScreenDetiles({this.userModel});
 var textcontrol=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context){
        SocialCubit.get(context).getmessages(reciverId: userModel.uid);
        return  BlocConsumer<SocialCubit,SocialStates>(
          listener: (context,state){},
          builder: (context,state){
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(userModel.image),
                    ),
                    SizedBox(width: 15,),
                    Text(userModel.name),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).messages.length !=null,
                builder:(context)=> Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context,index){
                              var message=SocialCubit.get(context).messages[index];
                             if(SocialCubit.get(context).usermodel.uid==message.senderId)
                               return buildmymessage(message);
                             return buildmessage(message);
                            },
                            separatorBuilder:(context,index)=>SizedBox(height: 10,),
                            itemCount: SocialCubit.get(context).messages.length),
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
                                      hintText: 'write your message..'
                                  ),
                                ),
                              ),
                            ),
                            MaterialButton(onPressed: (){
                              SocialCubit.get(context).sendmessage(
                                  text: textcontrol.text,
                                  datetime: DateTime.now().toString(),
                                  reciverId: userModel.uid);
                            },
                              child:Icon(Icons.send,size: 25,color: Colors.blueAccent,) ,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallback:(context)=>Center(child: CircularProgressIndicator()) ,

              ),
            );
          },

        );
      },
    );
  }
  Widget buildmessage(ChatModel model)=> Align(
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
  Widget buildmymessage(ChatModel model)=>  Align(
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
