import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_app/modelsShop/CategoryModel.dart';
import 'package:first_app/modelsShop/Home_Model.dart';
import 'package:first_app/shop_app/shopcubit.dart';
import 'package:first_app/shop_app/shopstates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is FavoritesDataSuccess){
          if(!state.model.status){
            Fluttertoast.showToast(
              msg:state.model.massage,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16,
            );
          }else {
            Fluttertoast.showToast(
              msg:state.model.massage,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16,
            );
          }

        }
      },
      builder: (context,state){
        return ConditionalBuilder(
            condition:ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoryModel != null ,
            builder: (context)=>productsbuider(ShopCubit.get(context).homeModel,ShopCubit.get(context).categoryModel,context),
            fallback: (context)=>Center(child: CircularProgressIndicator()),);
      },
    );
  }

  Widget productsbuider(HomeModel model,CategoryModel categoryModel,context)=>SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
            CarouselSlider(
                items:model.data.banners.map((e) =>Image(
          image: NetworkImage('${e.image}'),
         width: double.infinity,
         fit: BoxFit.cover,
            ) ).toList(),
                options: CarouselOptions(
                  height: 200.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  viewportFraction: 0.95,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                  scrollDirection: Axis.horizontal,

                )),
        SizedBox(height: 8,),
         Padding(
           padding: const EdgeInsets.symmetric(
      horizontal: 10.0,
      ),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text("Categories",style: TextStyle(fontSize: 24,color: Colors.black,
                   fontWeight: FontWeight.w800),),
               SizedBox(height: 8,),
                 Container(
                   height: 100,
                   child: ListView.separated(
                     scrollDirection: Axis.horizontal,
                       itemBuilder: (context,index)=>CatItem(categoryModel.data.data[index]) ,
                       separatorBuilder: (context,index)=>SizedBox(width: 10,),
                       itemCount: categoryModel.data.data.length),
                 )  ,
               SizedBox(height: 10,),
               Text("New Products",style: TextStyle(fontSize: 24,color: Colors.black,
                   fontWeight: FontWeight.w800),),
             ],
           ),
         ),
        Container(
          color: Colors.grey,
          child: GridView.count(
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
            childAspectRatio: 1/1.74,
            shrinkWrap: true,
             physics: NeverScrollableScrollPhysics(),
             crossAxisCount: 2,

             children: List.generate(model.data.products.length,
                     (index) => ItemGrid(model.data.products[index],context),),
             ),
        ),
            ],
    ),
  );

  Widget ItemGrid(ProductsModel model,context)=>Container(
    color: Colors.white,
    child: Column(
         children: [
           Stack(
             alignment: Alignment.bottomLeft,
             children: [
               Image(image: NetworkImage('${model.image}'),
                 width: double.infinity,
                 height: 200,
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.name,style: TextStyle(
                  fontSize: 14.0,
                  height: 1.2,
                ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,),
                Row(
                  children: [
                    Text('${model.price.round()}'
                      ,style: TextStyle(color: Colors.blueAccent),),
                    SizedBox(width: 10,),
                    if(model.discount != 0)
                    Text('${model.oldPrice.round()}'
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
  );

  Widget CatItem(DataModel model)=>Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          height: 100,
          width: 100,
          image: NetworkImage(model.image),),
        Container(
          width: 100,
          color: Colors.black.withOpacity(0.6),
          child: Text(model.name,style: TextStyle(color: Colors.white,),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,),
        ),

      ]
  );
}
