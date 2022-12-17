
import 'package:first_app/Network/CacheHelper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'bordinglogin.dart';

class BordingScreensclass{
  final String image;
  final String title;
  final String body;
  BordingScreensclass({@required this.image,
    @required this.title,
    @required this.body});

}

class BordingScreen extends StatefulWidget {
  @override
  _BordingScreenState createState() => _BordingScreenState();
}

class _BordingScreenState extends State<BordingScreen> {
  var bordingcontrol=PageController();

  List<BordingScreensclass>bordingscreen=[
    BordingScreensclass(
        image: 'assets/photo1.png',
        title: 'Trust In God Success',
        body: 'Number 1'
    ),
    BordingScreensclass(
        image: 'assets/photo2.jpg',
        title: 'Trust In God Success',
        body: 'Number 2'
    ),
    BordingScreensclass(
        image: 'assets/photo3.jpg',
        title: 'Trust In God Success',
        body: 'Number 3'
    ),
  ];

  bool islast=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          actions: [
            TextButton(onPressed: ()
            {
              submit();
            },
                child: Text('SKIP',style: TextStyle(color: Colors.deepOrange,fontSize: 20),))
          ],
        ),
        body:Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(child: PageView.builder(
                onPageChanged: (int index){
                  if(index==bordingscreen.length-1){
                    setState(() {
                      islast=true;
                    });
                  }else{
                    setState(() {
                      islast=false;
                    });
                  }
                },
                controller:bordingcontrol ,
                physics: BouncingScrollPhysics(),
                itemBuilder: (contex,index)=> buidBordingItem(bordingscreen[index]),
                itemCount: bordingscreen.length,)),
              SizedBox(height: 20,),
              Row(
                children: [
                  SmoothPageIndicator(
                      effect:ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: Colors.green,
                        dotHeight: 10,
                        dotWidth: 10,
                        expansionFactor: 2,
                        spacing: 4,
                      ) ,
                      controller: bordingcontrol,
                      count: bordingscreen.length),
                  Spacer(),
                  FloatingActionButton(onPressed: ()
                  {
                    if(islast){
                      submit();
                    }else{
                      bordingcontrol.nextPage(duration:Duration(
                        milliseconds: 750,
                      ),curve:Curves.fastLinearToSlowEaseIn);
                    }
                  },
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }

  Widget buidBordingItem(BordingScreensclass model){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage('${model.image}'),
          ),
        ),
        SizedBox(height: 30,),
        Text("${model.title}",
          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        SizedBox(height: 15,),
        Text('${model.body}', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
      ],
    );
  }
  void submit(){
    CacheHelper.savedata(key: 'onBording', value: true).then((value){
      if(value){
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_)=>LoginScreen()),(rout){
              return false;
            });
      }

    });
  }
}
