import 'package:first_app/modelsShop/FavoritesGetModel.dart';
import 'package:first_app/modelsShop/searchmodel.dart';
import 'package:first_app/shop_app/SearchCubit.dart';
import 'package:first_app/shop_app/searchStates.dart';
import 'package:first_app/shop_app/shopcubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'items.dart';
class SearchScreen extends StatelessWidget {
  var formk=GlobalKey<FormState>();
  var searchcontroler=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder: (context,state){
          return  Scaffold(
            appBar: AppBar(
              title: Text("search"),
            ),
            body: Form(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextFormField(
                     controller: searchcontroler,
                      onChanged: (String text){
                       SearchCubit.get(context).SearchProduct(text);
                      },
                      validator: (v){
                       if(v.isEmpty){
                         return 'please enter any word';
                       }
                       return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Search',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          )
                      ),
                    ),
                    SizedBox(height: 10,),
                    if(state is LodingSearchState)
                      LinearProgressIndicator(
                        backgroundColor: Colors.green,
                      ),
                    SizedBox(height: 10,),
                    if(state is SuccessSearchState)
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context,index)=>searchitem(SearchCubit.get(context).Model.data.data[index],context),
                          separatorBuilder:(context,index)=>Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.grey,
                          ),
                          itemCount: SearchCubit.get(context).Model.data.data.length),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget searchitem(productss model,context)=>Padding(
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
              if(model.discount !=0 )
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
                      Text('${model.price.round()}'
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
                        //backgroundColor:ShopCubit.get(context).favorites[model.id]?Colors.red: Colors.grey,
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


}