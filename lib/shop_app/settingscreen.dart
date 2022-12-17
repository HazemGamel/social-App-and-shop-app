import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_app/Network/CacheHelper.dart';
import 'package:first_app/shop_app/shopcubit.dart';
import 'package:first_app/shop_app/shopstates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bordinglogin.dart';
class settingscreen extends StatelessWidget {
 var formkey=GlobalKey<FormState>();
  var namecontroler=TextEditingController();
  var emailcontroler=TextEditingController();
  var phonecontroler=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){

        var seet=ShopCubit.get(context).UserModel;

        namecontroler.text=seet.data.name;
        emailcontroler.text=seet.data.email;
        phonecontroler.text=seet.data.phone;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).UserModel != null,
          builder: (context)=>SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    if(state is UpdateLodingSuccess)
                      LinearProgressIndicator(
                        backgroundColor: Colors.green,
                      ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.amber,
                              child: Image(image: NetworkImage(seet.data.image),),
                            ),
                            SizedBox(height: 10,),
                            Text("My Picture",style: TextStyle(fontSize: 20,color: Colors.black54),),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: namecontroler,
                      validator: (value){
                        if(value.isEmpty){
                          return "Name must not be empty";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          labelText: 'Name',
                          prefixIcon: Icon(Icons.person),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Colors.pinkAccent,
                              )
                          )
                      ),

                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      controller: emailcontroler,
                      validator: (value){
                        if(value.isEmpty){
                          return "Email must not be empty";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Colors.pinkAccent,
                              )
                          )
                      ),

                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      controller: phonecontroler,
                      validator: (value){
                        if(value.isEmpty){
                          return "Phone must not be empty";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          labelText: 'Phone',
                          prefixIcon: Icon(Icons.phone),
                          focusedBorder: OutlineInputBorder(

                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Colors.pinkAccent,
                              )
                          )
                      ),

                    ),
                    SizedBox(height: 15,),
                    Container(
                      width: double.infinity,
                      child: MaterialButton(onPressed: (){
                        CacheHelper.removedate(key: 'token').then((value) {
                          if(value){
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (_)=>LoginScreen())
                                , (route) => false);
                          }
                        });
                      },
                        padding: EdgeInsets.all(15.0),
                        color: Colors.blueAccent,
                        child: Text("LOGOut"),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      width: double.infinity,
                      child: MaterialButton(onPressed: (){
                        if(formkey.currentState.validate()){
                          ShopCubit.get(context).updatedata(
                              name: namecontroler.text,
                              email: emailcontroler.text,
                              phone: phonecontroler.text);
                        }
                      },
                        padding: EdgeInsets.all(15.0),
                        color: Colors.blueAccent,
                        child: Text("Update"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      }

    );
  }
}