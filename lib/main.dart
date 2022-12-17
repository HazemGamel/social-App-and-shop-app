import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:first_app/LOgin.dart';
import 'package:first_app/Network/CacheHelper.dart';
import 'package:first_app/SocialModels/SocialUserModel.dart';
import 'package:first_app/ToDoApp/Todo_Home.dart';
import 'package:first_app/counter/cubit/NewsAppStates.dart';
import 'package:first_app/counter/cubit/cubit.dart';
import 'package:first_app/shared/CONSTS.dart';
import 'package:first_app/shared/bloc_observer.dart';
import 'package:first_app/shop_app/bordinglogin.dart';
import 'package:first_app/shop_app/bordingscreen.dart';
import 'package:first_app/shop_app/shopcubit.dart';
import 'package:first_app/shop_app/shoplyoute.dart';
import 'package:first_app/shop_app/shopstates.dart';
import 'package:first_app/social_app/HomeLayout.dart';
import 'package:first_app/social_app/SocialCubit.dart';
import 'package:first_app/social_app/SocialLoginScreen.dart';
import 'package:first_app/styles/thems.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'BMI.dart';
import 'Network/Dio.dart';
import 'counter/NewsAppHome.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  DoiHelper.init();
  await CacheHelper.init();
  HttpOverrides.global = MyHttpOverrides();
  Widget widget;
  bool onBording = CacheHelper.getdata(key:'onBording');
   token = CacheHelper.getdata(key:'token');
    UId =CacheHelper.getdata(key: 'UId');
   print(token);
//  if(onBording != null){
//    if(token!=null) {widget=ShopHome();}
//    else{
//      widget=LoginScreen();
//    }
//  }else{
//    widget=BordingScreen();
//  }
  if(UId !=null ){
    widget=HomeLayout();
  }else{
    widget=SocialLoginScreen();
  }
  //print(onBording);
  runApp(MyApp(
    startwidget:widget,
  ));
}
class MyApp extends StatelessWidget {
  final Widget startwidget;
   MyApp({this.startwidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
        BlocProvider(
        create: (BuildContext context)=>NewsAppCubit()),
        BlocProvider(
        create:(BuildContext context)=>ShopCubit()),//..getHomeData()..getCategoryData(),),
        BlocProvider(
        create:(BuildContext context)=>SocialCubit()..getuserdate()..getposts(
          datetime: DateTime.now().toString(),
        ),),
         ],
        child: BlocConsumer<NewsAppCubit,NewsAppStates>(
    listener: (context,state){},
    builder: (context,state){
        return  MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: lightThem,
    darkTheme: DarkThem,
    themeMode: NewsAppCubit.get(context).isDark? ThemeMode.dark:ThemeMode.light,
    home: Scaffold(
    body:startwidget,
    ),
    );
    },

    ),);

  }
}

