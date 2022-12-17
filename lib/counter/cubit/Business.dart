import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_app/counter/cubit/NewsAppStates.dart';
import 'package:first_app/counter/cubit/Web_View.dart';
import 'package:first_app/counter/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit,NewsAppStates>(
      listener: (context,state){},
      builder: (context,state){
        var list=NewsAppCubit.get(context).business;
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
Widget buiditem(artical,context)=> InkWell(
  onTap: (){
    Navigator.push(context,MaterialPageRoute(builder: (_)=>WebviewScreen(
      artical['url'],
    )));
  },
  child:   Padding(

    padding: const EdgeInsets.all(10.0),

    child: Row(

      children: [

        Container(

          width: 120,

          height: 120,

          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(15.0),

              image:DecorationImage(

                fit: BoxFit.cover,

                image: NetworkImage('${artical['urlToImage']}'),

              )

          ),

        ),

        SizedBox(width: 10.0,),

        Expanded(

          child: Container(

            height: 120,

            child: Column(

              mainAxisSize: MainAxisSize.min,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Expanded(

                  child: Text("${artical['title']} ",

                    style: Theme.of(context).textTheme.headline6,

                    maxLines: 3,overflow: TextOverflow.ellipsis,),

                ),

                Text("${artical['publishedAt']}",style: TextStyle(fontSize: 15,color: Colors.grey),),

              ],

            ),

          ),

        ),

      ],

    ),

  ),
);