import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_app/social_app/HomeLayout.dart';
import 'package:first_app/social_app/Register_States.dart';
import 'package:first_app/social_app/SocialCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Register_Cubit.dart';
import 'SocialLoginScreen.dart';

class SocialRegisterScreen extends StatelessWidget {

  var emailcontrol=TextEditingController();
  var pasworcontrol=TextEditingController();
  var phonecontrol=TextEditingController();
  var namecontrol=TextEditingController();
  var formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterstates>(
        listener: (context,state){
          if(state is SocialCreateUserSuccess){
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (_)=>HomeLayout()), (route) => false);
          }
        },
        builder: (context,state){
          return  Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/register.png'),
                  fit: BoxFit.cover,
                )
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,

              appBar: AppBar(
                title: Text("Register"),
                backgroundColor: Colors.purple[200],
                elevation: 15.0,
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
                          Text("Register now to communicate with new friends",
                            style: TextStyle(fontSize: 17).copyWith(
                                color: Colors.black,
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
                                    color: Colors.black,
                                  )
                              ),
                              labelText: 'User Name',
                              labelStyle: TextStyle(color: Colors.white),
                              prefixIcon: Icon(Icons.person,color: Colors.white,),
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
                                    color: Colors.black,
                                  )
                              ),
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.white),
                              prefixIcon: Icon(Icons.email,color: Colors.white,),
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
                                    color: Colors.black,
                                  )
                              ),
                              labelText: 'Phone',
                              labelStyle: TextStyle(color: Colors.white),
                              prefixIcon: Icon(Icons.phone,color: Colors.white,),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                            controller: pasworcontrol,
                            obscureText: SocialRegisterCubit.get(context).ispassword,
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
                                    color: Colors.black,
                                  )
                              ),
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.white),
                              prefixIcon: Icon(Icons.lock,color: Colors.white,),
                              suffixIcon:IconButton(
                                icon: Icon(SocialRegisterCubit.get(context).suffix,color: Colors.white,),
                                onPressed: (){
                                  SocialRegisterCubit.get(context).changpassword();
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          ConditionalBuilder(
                            condition:state is! LodingSocialRegister,
                            builder: (context)=> Center(
                              child: Container(
                                width: 200,
                                child: MaterialButton(onPressed: (){
                                  if(formkey.currentState.validate()){
                            SocialRegisterCubit.get(context).userRegister(
                                email: emailcontrol.text,
                                name: namecontrol.text,
                                phone: phonecontrol.text,
                                password: pasworcontrol.text);
                                  }
                                  //SocialCubit.get(context).getuserdate();
                                },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  padding: EdgeInsets.all(15.0),
                                  color: Colors.pinkAccent,
                                  child: Text("REGISTER"),
                                ),
                              ),
                            ),
                            fallback:(context)=>Center(child: CircularProgressIndicator()) ,
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have account?",
                                style: TextStyle(fontSize: 16,color: Colors.black),),
                              //SizedBox(width: 7,),
                              TextButton(
                                onPressed: (){
                                  Navigator.push(context,MaterialPageRoute(builder:
                                      (_)=>SocialLoginScreen()));
                                },
                                child: Text("Login ",
                                  style: TextStyle(fontSize: 16,color: Colors.pinkAccent),),
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
