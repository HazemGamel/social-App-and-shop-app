import 'package:first_app/SocialModules/EditProfileScreen.dart';
import 'package:first_app/social_app/Register_Cubit.dart';
import 'package:first_app/social_app/SocialCubit.dart';
import 'package:first_app/social_app/SocialLoginScreen.dart';
import 'package:first_app/social_app/SocialStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var mm=SocialCubit.get(context).usermodel;
        return   Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Container(
                height: 180,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,

                      child: Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(7),
                              topRight: Radius.circular(7),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage('${mm.cover}'),
                            )
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 41,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage('${mm.image}'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Text("${mm.name}",style: Theme.of(context).textTheme.bodyText1,),
              SizedBox(height: 5,),
              Text("${mm.bio}",style: Theme.of(context).textTheme.caption,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text("100",style: Theme.of(context).textTheme.subtitle1,),
                            SizedBox(height: 5,),
                            Text("posts",style: Theme.of(context).textTheme.caption,),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text("256",style: Theme.of(context).textTheme.subtitle1,),
                            SizedBox(height: 5,),
                            Text("photos",style: Theme.of(context).textTheme.caption,),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text("100",style: Theme.of(context).textTheme.subtitle1,),
                            SizedBox(height: 5,),
                            Text("Followers",style: Theme.of(context).textTheme.caption,),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text("50",style: Theme.of(context).textTheme.subtitle1,),
                            SizedBox(height: 5,),
                            Text("Following",style: Theme.of(context).textTheme.caption,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(onPressed: (){},
                        child: Text("Edit Photos")),
                  ),
                  SizedBox(width: 10,),
                  OutlinedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>EditProfileScreen()));
                  },
                      child: Icon(Icons.edit)),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(onPressed: (){
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (_)=>SocialLoginScreen())
                          , (route) => false);
                    },
                        child: Text("LogOut")),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}