
import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_app/Network/CacheHelper.dart';
import 'package:first_app/shared/CONSTS.dart';
import 'package:first_app/shop_app/RegisterScreen.dart';
import 'package:first_app/shop_app/shoplyoute.dart';
import 'package:first_app/shop_app/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'cubit.dart';

class LoginScreen extends StatelessWidget {
  var emailcontrol=TextEditingController();
  var pasworcontrol=TextEditingController();
  var formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,Shoploginstates>(
        listener: (context,state){
          if(state is ShopLoginSuccess){
            if(state.loginModel.status){
              CacheHelper.savedata(key: 'token', value:state.loginModel.data.token).
              then((value) {
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
            appBar: AppBar(),
            body:Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("LOGIN",style: Theme.of(context).textTheme.headline5.copyWith(
                            color: Colors.black
                        ),),
                        SizedBox(height: 10,),
                        Text("Login now to browse our hot offers",
                          style: TextStyle(fontSize: 20).copyWith(
                              color: Colors.grey
                          ),),
                        SizedBox(height: 25,),
                        TextFormField(
                          controller: emailcontrol,
                          validator: (value){
                            if(value.isEmpty){
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: pasworcontrol,
                          obscureText: ShopLoginCubit.get(context).ispassword,
                          validator: (value){
                            if(value.isEmpty){
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon:IconButton(
                              icon: Icon(ShopLoginCubit.get(context).suffix),
                              onPressed: (){
                                ShopLoginCubit.get(context).changpassword();
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        ConditionalBuilder(
                          condition:state is! LodingShopLogin,
                          builder: (context)=> Container(
                            width: double.infinity,
                            child: MaterialButton(onPressed: (){
                              if(formkey.currentState.validate()){
                                ShopLoginCubit.get(context).userlogin(
                                    email: emailcontrol.text,
                                    password: pasworcontrol.text);
                              }
                            },
                              padding: EdgeInsets.all(15.0),
                              color: Colors.blueAccent,
                              child: Text("LOGIN"),
                            ),
                          ),
                          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don\,t have account?",
                              style: TextStyle(fontSize: 16,color: Colors.black),),
                            //SizedBox(width: 7,),
                            TextButton(
                              onPressed: (){
                                Navigator.push(context,MaterialPageRoute(builder: (_)=>RegisterScreen()));
                              },
                              child: Text("Register Now",
                                style: TextStyle(fontSize: 16,color: Colors.blueAccent),),
                            ),
                          ],
                        )
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