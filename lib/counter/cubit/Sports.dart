import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Business.dart';
import 'NewsAppStates.dart';
import 'cubit.dart';
class SportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit,NewsAppStates>(
      listener: (context,state){},
      builder: (context,state){
        var list=NewsAppCubit.get(context).Sports;
        return ConditionalBuilder(
          condition:list.length>0,
          builder: (context)=>ListView.separated(
              itemBuilder: (context,index)=>buiditem(list[index],context),
              separatorBuilder: (context,index)=> Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey,
              ),
              itemCount: list.length),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}