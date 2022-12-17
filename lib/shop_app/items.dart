


import 'package:first_app/modelsShop/FavoritesGetModel.dart';
import 'package:first_app/shop_app/shopcubit.dart';
import 'package:flutter/material.dart';
Widget favoriteItem(model,context,)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image(image: NetworkImage('${model.image}'),
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
            if(model.discount !=0)
              Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text("DISCOUNT",style: TextStyle(
                    fontSize: 12,
                    color: Colors.white
                ),),
              ),
          ],
        ),
        SizedBox(width: 20,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(model.name,style: TextStyle(
                fontSize: 14.0,
                height: 1.2,
              ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,),
              Spacer(),
              Row(
                children: [
                  Text('${model.price.round()}'
                    ,style: TextStyle(color: Colors.blueAccent),),
                  SizedBox(width: 10,),
                  if(model.discount != 0)

                   Text('${model.oldprice.toString()}'
                      ,style: TextStyle(fontSize:12,
                          color: Colors.grey,decoration: TextDecoration.lineThrough),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: (){
                      ShopCubit.get(context).ChangeFavorites(model.id);
                    },
                    icon: CircleAvatar(
                      radius: 15.0,
                      backgroundColor:ShopCubit.get(context).favorites[model.id]?Colors.red: Colors.grey,
                      child: Icon(Icons.favorite_border,color: Colors.white,),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);