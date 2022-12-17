import 'package:first_app/Network/CacheHelper.dart';
import 'package:first_app/Network/Dio.dart';
import 'package:first_app/counter/cubit/SearchScreen.dart';
import 'package:first_app/counter/cubit/cubit.dart';
import 'package:first_app/counter/cubit/NewsAppStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class NewsAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>NewsAppCubit()..getBusiness(),
      child: BlocConsumer<NewsAppCubit,NewsAppStates>(
        listener: (context,state){},
        builder:(context,state) {
          var cub=NewsAppCubit.get(context);
          return  Scaffold(
            appBar: AppBar(
              title: Text("NewsApp"),
              actions: [
                IconButton(icon: Icon(Icons.search), onPressed:(){
                  Navigator.push(context,MaterialPageRoute(builder:(_)=>SearchScreen()));
                }),
                IconButton(icon: Icon(Icons.brightness_4_outlined),
                    onPressed:(){
                     cub.changeModeApp();
                    }),
              ],
            ),
            body: cub.screens[cub.currentindex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cub.currentindex,
              onTap: (index){
                cub.changebuttomNav(index);
              },
              items:cub.Items,
            ),
          );
        },
      ),
    );
  }
}


