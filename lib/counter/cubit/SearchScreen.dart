import 'package:first_app/counter/cubit/NewsAppStates.dart';
import 'package:first_app/counter/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Business.dart';
class SearchScreen extends StatelessWidget {
  var searchControl=TextEditingController();
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context)=>NewsAppCubit(),
      child: BlocConsumer<NewsAppCubit,NewsAppStates>(
        listener: (context,state){},
        builder: (context,state){
          var list=NewsAppCubit.get(context).search;
          return Scaffold(
            appBar: AppBar(
              title: Text("Searching"),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: searchControl,
                    onTap: (){},
                    onChanged: (value){
                    NewsAppCubit.get(context).getsearch(value);
                    },
                    decoration: InputDecoration(
                        labelText: 'search',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        )
                    ),

                  ),
                ),
                Expanded(child: buiditem(list,context)),

              ],
            ),
          );
        },

      ),
    );
  }
}
