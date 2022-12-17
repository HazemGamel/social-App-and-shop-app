import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_app/modelsShop/FavoritesGetModel.dart';
import 'package:first_app/shop_app/shopcubit.dart';
import 'package:first_app/shop_app/shopstates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'items.dart';
class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return   BlocConsumer<ShopCubit,ShopStates>(
        builder: (context,state)=>ConditionalBuilder(
          condition: state is! FavoriteLodingGetDataSuccess,
          builder: (context)=> ListView.separated(
              itemBuilder: (context,index)=>favoriteItem(ShopCubit.get(context).favoritesGetModel.data.data[index].product,context),
              separatorBuilder:(context,index)=>Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey,
              ),
              itemCount: ShopCubit.get(context).favoritesGetModel.data.data.length),
          fallback:(context)=>Center(child: CircularProgressIndicator()),
        ),
        listener: (context,state){
          if(state is FavoritesDataSuccess){
            if(state.model.status){
              Fluttertoast.showToast(
                msg:state.model.massage,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                fontSize: 16.0, );
            }
          }
        });
  }





}