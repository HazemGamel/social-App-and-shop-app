import 'package:first_app/modelsShop/CategoryModel.dart';
import 'package:first_app/shop_app/shopcubit.dart';
import 'package:first_app/shop_app/shopstates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        builder: (context,state)=>ListView.separated(
            itemBuilder: (context,index)=>Categoryitem(ShopCubit.get(context).categoryModel.data.data[index]),
            separatorBuilder: (context,index)=>Container(
              padding: EdgeInsets.only(right: 20.0),
              width: double.infinity,
              height: 1,
              color: Colors.grey,
            ),
            itemCount: ShopCubit.get(context).categoryModel.data.data.length),
        listener: (context,state){}) ;
  }

  Widget Categoryitem(DataModel model)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(image: NetworkImage(model.image),
          height: 120,
          width: 120,
          fit: BoxFit.cover,),
        SizedBox(width: 15,),
        Text(model.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
        Spacer(),
        Icon(Icons.arrow_forward_ios),
      ],
    ),
  );
}