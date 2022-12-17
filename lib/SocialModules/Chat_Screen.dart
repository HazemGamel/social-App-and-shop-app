import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_app/SocialModels/SocialUserModel.dart';
import 'package:first_app/SocialModules/ChatDetails.dart';
import 'package:first_app/social_app/SocialCubit.dart';
import 'package:first_app/social_app/SocialStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.length>0,
          builder: (context)=>ListView.separated(
              itemBuilder: (context,index)=>buildchatitem(SocialCubit.get(context).users[index],context),
              separatorBuilder: (context,index)=>Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey,
              ),
              itemCount: SocialCubit.get(context).users.length),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );

  }
  Widget buildchatitem(SocialUserModel model,context)=> InkWell(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (_)=>ChatScreenDetiles(
        userModel: model,
      )));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 23,
            backgroundImage: NetworkImage('${model.image}'),
          ),
          SizedBox(width: 10,),
          Expanded(
            child:Text("${model.name}",
              style: TextStyle(fontWeight: FontWeight.w600,height: 1.4),),
          ),
        ],
      ),
    ),
  );
}