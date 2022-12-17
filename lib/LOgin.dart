import 'package:flutter/material.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
 var control=TextEditingController();

 bool psww=true;
 var formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: formkey,
              child: TextFormField(
                validator: (value){
                  if(value.isEmpty){
                    return "please enter your password";
                  }
                  return null;
                },
                obscureText: psww,
                controller:control ,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefix: Icon(Icons.lock),
                  suffix: IconButton(
                    onPressed: (){
                      setState(() {
                        psww=!psww;
                      });
                    },
                    icon:psww? Icon(Icons.visibility):Icon(Icons.visibility_off),
                  ),
                  labelText: "Password",
                  border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
           buildbutton(text: "register",
           w: 200,
           c: Colors.red),
          ],
        ),
      ),
    );
  }
  Widget buildbutton({@required String text,
    double w=double.infinity,Color c=Colors.blueAccent}){
    return  Container(
      width: w,
      color: c,
      child: MaterialButton(
          child: Text(text),
          onPressed: (){

            if(formkey.currentState.validate()) {
              print(control.text);
            }
          } ),
    );
  }
}
