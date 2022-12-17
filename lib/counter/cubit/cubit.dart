import 'package:bloc/bloc.dart';
import 'package:first_app/Network/CacheHelper.dart';
import 'package:first_app/Network/Dio.dart';
import 'package:first_app/counter/cubit/NewsAppStates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Business.dart';
import 'Sciense.dart';
import 'SettingScreen.dart';
import 'Sports.dart';

class NewsAppCubit extends Cubit<NewsAppStates>{

  NewsAppCubit():super(NewsAppInitialState());
  static NewsAppCubit get(context)=>BlocProvider.of(context);

  int currentindex=0;
  List<Widget> screens=[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  List<BottomNavigationBarItem> Items=[
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
  ];
  void changebuttomNav(int index){
    currentindex=index;
    if(index==1)
      getSports();
    if(index==2)
      getScience();
    emit(ButtomAppStates());
  }


  List<dynamic> business=[];

  void getBusiness(){
    emit(BusinessLoadingSuccess());
    DoiHelper.getData(Url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'business',
          'apiKey':'33a6190deaf143b488f76d6e3387edca',
        }).then((value) {
      business=value.data['articles'];
     // print(business[0]['title']);
      emit(BusinessSuccess());
    }).catchError((erorr){
      print(erorr.toString());
      emit(BusinessErorr());
    });
  }
  List<dynamic> Sports=[];
  void getSports(){
    emit(SportsLoadingSuccess());
    if(Sports.length==0){
      DoiHelper.getData(Url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'sports',
            'apiKey':'33a6190deaf143b488f76d6e3387edca',
          }).then((value) {
        Sports=value.data['articles'];
        // print(business[0]['title']);
        emit(SportsSuccess());
      }).catchError((erorr){
        print(erorr.toString());
        emit(SportsErorr());
      });
    }else{
      emit(SportsSuccess());
    }
  }

  List<dynamic> Science=[];
  void getScience(){
    emit(ScienceLoadingSuccess());
    if(Science.length==0){
      DoiHelper.getData(Url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'science',
            'apiKey':'33a6190deaf143b488f76d6e3387edca',
          }).then((value) {
        Science=value.data['articles'];
        //print(business[0]['title']);
        emit(ScienceSuccess());
      }).catchError((erorr){
        print(erorr.toString());
        emit(ScienceErorr());
      });
    }else{
      emit(ScienceSuccess());
    }

  }
  bool isDark=false;
  void changeModeApp()
  {
      isDark = !isDark;
      CacheHelper.putboolean(key: 'isDark', value: isDark).then((value) {
        emit(ChangeModeApp());
      }).catchError((erorr){
        emit(ChangeErorrModeApp());
        print("erorr is $erorr");
      });
  }

  var search=[];
  void getsearch(String value)
  {
    emit(SearchLoadingSuccess());
    DoiHelper.getData(Url: 'v2/everything',
        query:{
      'q':'$value',
       'apiKey':'33a6190deaf143b488f76d6e3387edca',
        }).then((value) =>{
          search=value.data['articles'],
      emit(SearchSuccess()),
    }).catchError((erorr){
      print("erorr is $erorr");
      emit(SearchErorr());
    });

  }

}