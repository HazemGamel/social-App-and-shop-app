import 'package:flutter/material.dart';
class ResultScreen extends StatelessWidget {
  final int result;
  final bool gender;
  final int age;

  const ResultScreen({@required this.result,
    @required this.gender,@required this.age});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text("Result"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Gender:${gender?"male":"female"}",style: TextStyle(fontSize: 30),),
            Text("Result:$result",style: TextStyle(fontSize: 30),),
            Text("Age:$age",style: TextStyle(fontSize: 30),),
          ],
        ),
      ),
    );
  }
}
