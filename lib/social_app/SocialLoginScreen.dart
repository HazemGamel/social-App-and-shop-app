import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_app/Network/CacheHelper.dart';
import 'package:first_app/shared/CONSTS.dart';
import 'package:first_app/social_app/HomeLayout.dart';
import 'package:first_app/social_app/SocialCubit.dart';
import 'package:first_app/social_app/SocialRegisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'SocialCubit.dart';
import 'SocialCubit.dart';
import 'SocialCubit.dart';
import 'login_cubit.dart';
import 'login_states.dart';

class SocialLoginScreen extends StatelessWidget {
  var formkey=GlobalKey<FormState>();
  var  emailcontrol=TextEditingController();
  var  passwordcontrol=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,Socialloginstates>(
        listener: (context,state){
          if(state is SocialLoginError){
            Fluttertoast.showToast(msg: 'something error!');
          }
          if(state is SocialLoginSuccess){
            CacheHelper.savedata(key: 'UId',
                value:state.UId).then((value) {
                  UId=state.UId;
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (_)=>HomeLayout()), (route) => false);
            });
          }
        },
        builder: (context,state){
          return  Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/blue.jpg'),
                  fit: BoxFit.cover,
                )
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("LOGIN",style: Theme.of(context).textTheme.headline5.copyWith(
                              color: Colors.pinkAccent
                          ),),
                          SizedBox(height: 10,),
                          Text("Login now to communicat with friends",
                            style: TextStyle(fontSize: 18).copyWith(
                                color: Colors.white70
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
                              labelStyle:TextStyle(color: Colors.grey) ,
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email,color: Colors.white70,),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                            controller: passwordcontrol,
                            obscureText: SocialLoginCubit.get(context).ispassword,
                            validator: (value){
                              if(value.isEmpty){
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelStyle:TextStyle(color: Colors.grey) ,
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock,color: Colors.white70,),
                              suffixIcon:IconButton(
                                icon: Icon(SocialLoginCubit.get(context).suffix,color: Colors.black,),
                                onPressed: (){
                                  SocialLoginCubit.get(context).changpassword();
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: Colors.white70
                                )
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          ConditionalBuilder(
                            condition:state is! LodingSocialLogin,
                            builder: (context)=> Center(
                              child: Container(
                                width: 150,
                                child: MaterialButton(onPressed: (){
                                  if(formkey.currentState.validate()){
                            SocialLoginCubit.get(context).userlogin(
                                email: emailcontrol.text,
                                password: passwordcontrol.text);
                                  }
                                },
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(20.0),
                                 ),
                                  padding: EdgeInsets.all(15.0),
                                  color: Colors.pinkAccent.withOpacity(0.8),
                                  child: Text("LOGIN"),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                )
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
                                   Navigator.push(context,MaterialPageRoute(builder: (_)=>SocialRegisterScreen()));
                                },
                                child: Text("Register Now",
                                  style: TextStyle(fontSize: 16,color: Colors.grey),),
                              ),
                            ],
                          )
                        ],
                      ),
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
}
