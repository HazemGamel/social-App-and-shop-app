
import 'package:first_app/Network/CacheHelper.dart';
import 'package:first_app/shop_app/SearchScreen.dart';
import 'package:first_app/shop_app/shopcubit.dart';
import 'package:first_app/shop_app/shopstates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bordinglogin.dart';

class ShopHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopCubit()..getHomeData()..getCategoryData()..getfavoritesdata()..getsettingdata(),
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          var cub=ShopCubit.get(context);
          return  Scaffold(
            appBar: AppBar(
              title: Text("Shopping"),
              actions: [
                IconButton(icon: Icon(Icons.search), onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_)=>SearchScreen()));
                }),
                IconButton(icon:Icon(Icons.shopping_cart_rounded,color: Colors.teal),onPressed: (){},),
              ],
            ),
            body: cub.bottomscreens[cub.currentindex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cub.currentindex,
              onTap: (index){
                cub.chandenav(index);
              },
              items: cub.items,
            ),
          );
        },
      ),
    );
  }
}