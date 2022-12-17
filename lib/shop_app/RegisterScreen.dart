import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_app/Network/CacheHelper.dart';
import 'package:first_app/shared/CONSTS.dart';
import 'package:first_app/shop_app/%D9%8DShopRegisterCubit.dart';
import 'package:first_app/shop_app/shoplyoute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'ShopRegisterStates.dart';
import 'bordinglogin.dart';

class RegisterScreen extends StatelessWidget {
  var emailcontrol=TextEditingController();
  var pasworcontrol=TextEditingController();
  var phonecontrol=TextEditingController();
  var namecontrol=TextEditingController();
  var formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterstates>(
        listener: (context,state){
          if(state is ShopRegisterSuccess){
            if(state.loginModel.status){
              CacheHelper.savedata(key: 'token', value:state.loginModel.data.token).then((value) {
                token=state.loginModel.data.token;
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (_)=>ShopHome()),(rout){
                      return false;
                    });
                toastshow(text: state.loginModel.message, state: ToastState.SUCCESS);
              });
              //print("status is ${state.loginModel.status}");
            }else{
              toastshow(text: state.loginModel.message,
                  state: ToastState.ERROR);
              // print("status is ${state.loginModel.message}");
            }
          }
        },
        builder: (context,state){
          return  Scaffold(
            appBar: AppBar(
              title: Text("Register"),
            ),
            body:Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("REGISTER",style: Theme.of(context).textTheme.headline5.copyWith(
                            color: Colors.black
                        ),),
                        SizedBox(height: 10,),
                        Text("Register now to browse our hot offers",
                          style: TextStyle(fontSize: 20).copyWith(
                              color: Colors.grey
                          ),),
                        SizedBox(height: 25,),
                        TextFormField(
                          controller: namecontrol,
                          validator: (value){
                            if(value.isEmpty){
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(

                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  color: Colors.pinkAccent,
                                )
                            ),
                            labelText: 'Name',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: emailcontrol,
                          validator: (value){
                            if(value.isEmpty){
                              return 'Please enter your Email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(

                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  color: Colors.pinkAccent,
                                )
                            ),
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: phonecontrol,
                          keyboardType: TextInputType.phone,
                          validator: (value){
                            if(value.isEmpty){
                              return 'Please enter your Phone';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  color: Colors.pinkAccent,
                                )
                            ),
                            labelText: 'Phone',
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: pasworcontrol,
                          obscureText: ShopRegisterCubit.get(context).ispassword,
                          validator: (value){
                            if(value.isEmpty){
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(

                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  color: Colors.pinkAccent,
                                )
                            ),
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon:IconButton(
                              icon: Icon(ShopRegisterCubit.get(context).suffix),
                              onPressed: (){
                                ShopRegisterCubit.get(context).changpassword();
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        ConditionalBuilder(
                          condition:state is! LodingShopRegister,
                          builder: (context)=> Container(
                            width: double.infinity,
                            child: MaterialButton(onPressed: (){
                              if(formkey.currentState.validate()){
                                ShopRegisterCubit.get(context).userRegister(
                                    email: emailcontrol.text,
                                    name: namecontrol.text,
                                    phone: phonecontrol.text,
                                    password: pasworcontrol.text);
                              }
                            },
                              padding: EdgeInsets.all(15.0),
                              color: Colors.blueAccent,
                              child: Text("REGISTER"),
                            ),
                          ),
                          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void toastshow({@required String text,
    @required ToastState state}){
    Fluttertoast.showToast(
      msg:text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: toaststate(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
  Color toaststate(ToastState state){
    Color color;
    switch(state){
      case ToastState.SUCCESS:
        color=Colors.green;
        break;
      case ToastState.ERROR:
        color=Colors.red;
        break;
      case ToastState.WARNING:
        color=Colors.amber;
        break;
    }
    return color;
  }
}
enum ToastState{SUCCESS,ERROR,WARNING}