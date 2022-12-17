import 'dart:ffi';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_app/SocialModels/PostModel.dart';
import 'package:first_app/SocialModels/SocialUserModel.dart';
import 'package:first_app/SocialModules/commentscreen.dart';
import 'package:first_app/social_app/SocialCubit.dart';
import 'package:first_app/social_app/SocialStates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedsScreen extends StatelessWidget {
  SocialUserModel model;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(

      listener: (context,state){},
      builder: (context,state){

        return ConditionalBuilder(
          condition:SocialCubit.get(context).posts.length != null && SocialCubit.get(context).usermodel != null ,
          builder:(context)=>SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 10,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Image(
                          image: NetworkImage('https://cnn-arabic-images.cnn.io/cloudinary/image/upload/w_1120,c_scale,q_auto/cnnarabic/2020/11/23/images/170677.jpg'),
                          fit: BoxFit.cover,
                          height: 170,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Communication with new friends",
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
                        ),
                      ],

                    ),
                  ),
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index)=>buildPostItem(SocialCubit.get(context).posts[index],context,index),
                    separatorBuilder: (context,index)=>SizedBox(height: 10,),
                    itemCount:SocialCubit.get(context).posts.length ),
                SizedBox(height: 8,),

              ],
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),

        );
      },

    );
  }

  Widget buildPostItem(PostModel postModel,context,index)=> Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5,
    margin: EdgeInsets.symmetric(horizontal: 6.0),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 23,
                backgroundImage: NetworkImage('${postModel.image}'),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("${postModel.name}",style: TextStyle(fontWeight: FontWeight.w600,height: 1.4),),
                        SizedBox(width: 4,),
                        Icon(Icons.check_circle,size: 16,color: Colors.blue,),
                      ],
                    ),
                    SizedBox(height: 6,),
                    Text(" ${postModel.datetime}",style: Theme.of(context).textTheme.caption.copyWith(
                      // height: 1.4,
                    ),),

                  ],
                ),
              ),
              IconButton(icon: Icon(Icons.more_horiz,), onPressed:(){}),

            ],
          ),
          SizedBox(height: 2,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),
          ),
          Text(" ${postModel.text} ",
            style: TextStyle(fontWeight: FontWeight.w600),

          ),
//          Padding(
//            padding: const EdgeInsets.symmetric(vertical: 6),
//            child: Container(
//              width: double.infinity,
//              child: Wrap(
//                children: [
//                  Padding(
//                    padding: const EdgeInsetsDirectional.only(end: 6),
//                    child: Container(
//                      height: 25,
//                      child: MaterialButton(onPressed: (){},
//                        padding: EdgeInsets.zero,
//                        minWidth: 1,
//                        child: Text("#software",style: Theme.of(context).textTheme.caption.copyWith(
//                            color: Colors.blue
//                        ),),),
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ),
        // ignore: unrelated_type_equality_checks
        if(postModel.postimage != "")
          Padding(
            padding: const EdgeInsetsDirectional.only(top: 15),
            child: Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage('${postModel.postimage}'),
                    fit: BoxFit.cover,
                  )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          Icon(Icons.favorite_border,color: Colors.pinkAccent,size: 20,),
                          SizedBox(width: 5,),
                          Text("${SocialCubit.get(context).lik}",style: Theme.of(context).textTheme.caption,),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.comment,color: Colors.amber[300],size: 20,),
                          SizedBox(width: 5,),
                          Text("0",style: Theme.of(context).textTheme.caption,),
                          SizedBox(width: 5,),
                          Text("comment",style: Theme.of(context).textTheme.caption,),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[300],
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_)=>
                            CommentScreen(
                              userModel: model,
                    )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundImage: NetworkImage('${SocialCubit.get(context).usermodel.image}'),
                        ),
                        SizedBox(width: 5,),
                        Text("write a comment.."),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  SocialCubit.get(context).likePost(SocialCubit
                      .get(context).postId[index]);
                  SocialCubit.get(context).getLikes();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      IconButton(icon:Icon(Icons.favorite,size: 20,),
                       padding: EdgeInsets.zero,
                       onPressed: (){
                        SocialCubit.get(context).changelike();
                       },
                       color: SocialCubit.get(context).like ? Colors.pinkAccent:Colors.grey,
                        ),
                      //SizedBox(width: 0.1,),
                      Text("like",style: Theme.of(context).textTheme.caption,),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 5,),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Icon(Icons.share,color: Colors.amberAccent,size: 20,),
                      SizedBox(width: 5,),
                      Text("share",style: Theme.of(context).textTheme.caption,),
                    ],
                  ),
                ),
              ),
            ],
          ),


        ],
      ),
    ),
  );
}
