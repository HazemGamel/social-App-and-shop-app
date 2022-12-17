import 'package:first_app/social_app/SocialCubit.dart';
import 'package:first_app/social_app/SocialStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  var namecontrol=TextEditingController();
  var biocontrol=TextEditingController();
  var phonecontrol=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var usermodel=SocialCubit.get(context).usermodel;
        var imageprofil=SocialCubit.get(context).profileimage;
        var imagecover=SocialCubit.get(context).CoverImage;
        namecontrol.text=usermodel.name;
        biocontrol.text=usermodel.bio;
        phonecontrol.text=usermodel.phone;
        return Scaffold(
          appBar: AppBar(
            title: Text("Edit Your Profile"),
            titleSpacing: 5,
            actions: [
              TextButton(onPressed: (){
                SocialCubit.get(context).updatuserdate(
                    name: namecontrol.text, phone: phonecontrol.text,
                    bio: biocontrol.text);
              },
                  child:Text("UPDATE")),
              SizedBox(width: 10,),
            ],

          ),
          body:SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is UpdateUserLodingState)
                    LinearProgressIndicator(
                      backgroundColor: Colors.green,
                    ),
                  SizedBox(height: 10,),
                  Container(
                    height: 180,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(7),
                                      topRight: Radius.circular(7),
                                    ),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:imagecover==null? NetworkImage('${usermodel.cover}'):FileImage(imagecover),
                                    )
                                ),
                              ),
                              IconButton(icon: CircleAvatar(
                                radius: 20,
                                  child: Icon(Icons.camera_alt)), onPressed: (){
                                SocialCubit.get(context).getImageCover();
                              }),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 51,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage:imageprofil == null? NetworkImage('${usermodel.image}'):FileImage(imageprofil)),
                            ),
                            IconButton(icon: CircleAvatar(
                                radius: 20,
                                child: Icon(Icons.camera_alt)), onPressed: (){
                              SocialCubit.get(context).getImageProfile();
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  if(SocialCubit.get(context).profileimage != null ||SocialCubit.get(context).CoverImage != null )
                  Row(
                    children: [
                      if(SocialCubit.get(context).profileimage != null)
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              child: MaterialButton(onPressed: (){
                                SocialCubit.get(context).uploadeprofileimage(
                                    name: namecontrol.text,
                                    phone: phonecontrol.text,
                                    bio: biocontrol.text);
                              },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                //padding: EdgeInsets.all(15.0),
                                color: Colors.blueAccent.withOpacity(0.8),
                                child: Text("Uploade Image Profile",style: TextStyle(fontSize: 13),),
                              ),
                            ),
                            if(state is UpdateUserLodingState)
                            SizedBox(height: 0.6,),
                            if(state is UpdateUserLodingState )
                            LinearProgressIndicator(
                              backgroundColor: Colors.green,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 5,),
                      if(SocialCubit.get(context).CoverImage != null)
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              child: MaterialButton(onPressed: (){
                                SocialCubit.get(context).uploadeCoverimage(
                                    name: namecontrol.text,
                                    phone: phonecontrol.text,
                                    bio: biocontrol.text);
                              },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                //padding: EdgeInsets.all(15.0),
                                color: Colors.blueAccent.withOpacity(0.8),
                                child: Text("Uploade Image Cover"),
                              ),
                            ),
                            if(state is UpdateUserLodingState)
                            SizedBox(height: 0.6,),
                            if(state is UpdateUserLodingState)
                            LinearProgressIndicator(
                              backgroundColor: Colors.green,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if(SocialCubit.get(context).profileimage != null ||SocialCubit.get(context).CoverImage != null )
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: namecontrol,
                    validator: (value){
                      if(value.isEmpty){
                        return 'Your Name must not empty ';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelStyle:TextStyle(color: Colors.grey) ,
                      labelText: 'Name',
                      prefixIcon: Icon(Icons.person,color: Colors.blueAccent,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: biocontrol,
                    validator: (value){
                      if(value.isEmpty){
                        return 'Please write your bio..';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelStyle:TextStyle(color: Colors.grey) ,
                      labelText: 'Bio',
                      prefixIcon: Icon(Icons.circle,color: Colors.blueAccent,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: phonecontrol,
                    validator: (value){
                      if(value.isEmpty){
                        return 'Please write your phone..';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelStyle:TextStyle(color: Colors.grey) ,
                      labelText: 'Phone',
                      prefixIcon: Icon(Icons.call,color: Colors.blueAccent,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ) ,
        );
      },

    );
  }
}
