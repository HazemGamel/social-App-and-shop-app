import 'dart:math';

import 'package:first_app/Result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LodinScreen extends StatefulWidget {
  @override
  _LodinScreenState createState() => _LodinScreenState();
}

class _LodinScreenState extends State<LodinScreen> {
  bool isMale=true;
  double height=120.0;
  int weight=40;
  int age=20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BmI"),
      ),
      body:Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                      child:GestureDetector(
                        onTap: (){
                          setState(() {
                            isMale=true;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color:isMale?Colors.blueAccent: Colors.grey,
                          ),

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.camera,size: 30,),
                              Text("Male"),
                            ],
                          ),
                        ),
                      ) ),
                  SizedBox(width: 20.0,),
                  Expanded(
                      child:GestureDetector(
                        onTap: (){
                          setState(() {
                            isMale=false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color:isMale? Colors.grey:Colors.blueAccent,
                          ),

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.camera,size: 30,),
                              Text("Male"),
                            ],
                          ),
                        ),
                      ) ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.grey,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("HEIGHT"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text("${height.round()}",style: TextStyle(fontSize: 30),),
                        Text("cm"),
                      ],
                    ),
                    Slider(value: height,
                        max: 220,
                        min: 80,
                        onChanged: (v){
                      setState(() {
                        height=v;
                      });
                        })
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey,
                      ),
                      child: Column(
                        children: [
                          Text("Age",style: TextStyle(fontSize: 30),),
                          Text("$age",style: TextStyle(fontSize: 30),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(onPressed: (){
                                setState(() {
                                  if(age==0){
                                    age=0;
                                  }else{ age--;}

                                });
                              },
                                heroTag: "age-",
                                mini: true,
                                child:Icon(Icons.remove) ,),
                              SizedBox(width: 10.0,),
                              FloatingActionButton(onPressed: (){
                                setState(() {
                                  age++;
                                });
                              },
                                heroTag: "age+",
                                mini: true,
                                child:Icon(Icons.add) ,),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0,),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey,
                      ),
                      child: Column(
                        children: [
                          Text("Weight",style: TextStyle(fontSize: 30),),
                          Text("$weight",style: TextStyle(fontSize: 30),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(onPressed: (){
                                setState(() {
                                  weight--;
                                });
                              },
                                heroTag: "weight-",
                                mini: true,
                                child:Icon(Icons.remove) ,),
                              SizedBox(width: 10.0,),
                              FloatingActionButton(onPressed: (){
                                setState(() {
                                  weight++;
                                });
                              },
                                heroTag: "weight+",
                                mini: true,
                                child:Icon(Icons.add) ,),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          MaterialButton(
            onPressed: (){
              setState(() {
                var result=weight/pow(height/100,2);
                print(result.round());
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>ResultScreen(
                      age: age,
                      result: result.round(),
                      gender: isMale,
                    ),));
              });
            },
            child: Text("Calculate"),),
        ],
      ),
    );
  }
}
