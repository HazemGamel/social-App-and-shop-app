import 'package:first_app/SocialModules/Add_post.dart';
import 'package:first_app/social_app/SocialCubit.dart';
import 'package:first_app/social_app/SocialStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){
        if(state is SocialAddpostChange){
          Navigator.push(context,MaterialPageRoute(builder: (_)=>AddPostScreen()));
        }
      },
      builder: (context,state){
        var cubit=SocialCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            elevation: 8,
            title: Text(cubit.titles[cubit.currentindex]),
            actions: [
              IconButton(icon: Icon(Icons.notification_important_outlined,), onPressed:(){}),
              IconButton(icon: Icon(Icons.search), onPressed:(){}),
            ],
          ),
          body: cubit.screens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentindex,
            selectedItemColor: Colors.pinkAccent,
            unselectedItemColor: Colors.grey,
            onTap: (index){
              cubit.changnav(index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.chat_bubble),label: 'Chat'),
              BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline),label: 'Post'),
              BottomNavigationBarItem(icon: Icon(Icons.location_on_outlined),label: 'Users'),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Setting'),
            ],
          ),
        );
      },
    );
  }
}
