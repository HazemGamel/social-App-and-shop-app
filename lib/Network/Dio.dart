
//baseurl:https://newsapi.org/
//methodUrl:v2/top-headlines?
//query:country=eg&category=business&apiKey=33a6190deaf143b488f76d6e3387edca
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
class DoiHelper{
 static Dio dio;
  static init(){
    try{
      dio=Dio(
        BaseOptions(
          baseUrl:'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,
        ),
      );
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate=
          (HttpClient client){
        client.badCertificateCallback=
            (X509Certificate cert,String host,int port)=>true;
        return client;
      };
    }catch(e){
      print("error is be ${e.toString()}");
    }

  }
 static Future<Response> getData({
  @required String Url,
   Map<String,dynamic> query,
   String lang='ar',
   String token,
})async{
    dio.options.headers={
      'lang':lang,
      'Authorization':token??'',
      'Content-Type':'application/json',
    };
   return await dio.get(Url,queryParameters:query );
}
 static Future<Response> postdata({
   @required String url,
   Map<String,dynamic> query,
   String lang='ar',
   String token,
   @required Map<String,dynamic> data,
 })async {
   dio.options.headers = {
     'lang': lang,
     'Authorization': token ?? '',
     'Content-Type': 'application/json',
   };
   return dio.post(url,
     queryParameters: query,
     data: data,
   );
 }
   static Future<Response> putData({
     @required String url,
     Map<String,dynamic> query,
     String lang='ar',
     String token,
     @required Map<String,dynamic> data,
   })async {
     dio.options.headers = {
       'lang': lang,
       'Authorization': token ?? '',
       'Content-Type': 'application/json',
     };
     return dio.put(url,
       queryParameters: query,
       data: data,
     );
   }
}
//{
//  "status": "ok",
//"totalResults": 25,
//-"articles": [
//-{
//-"source": {
//"id": "rt",
//"name": "RT"
//},
//"author": "RT Arabic",
//"title": "هل ستتأثر مصر بقرار تركيا خفض الفائدة؟ - RT Arabic",
//"description": "يتوقع الخبراء أن يصب قرار البنك المركزي التركي خفض أسعار الفائدة 1% في صالح مصر، التي تعد دولة منافسة لتركيا والأسواق الناشئة في جذب الاستثمارات الأجنبية وخاصة في أدوات الدين.",
//"url": "https://arabic.rt.com/business/1277474-%D9%87%D9%84-%D8%B3%D9%8A%D8%A4%D8%AB%D8%B1-%D9%82%D8%B1%D8%A7%D8%B1-%D8%AA%D8%B1%D9%83%D9%8A%D8%A7-%D8%A8%D8%AE%D9%81%D8%B6-%D8%A7%D9%84%D9%81%D8%A7%D8%A6%D8%AF%D8%A9-%D8%B9%D9%84%D9%89-%D9%85%D8%B5%D8%B1/",
//"urlToImage": "https://cdni.rt.com/media/pics/2021.09/original/6151ec114236046b225ac4a7.jpg",
//"publishedAt": "2021-09-27T17:12:00Z",
//"content": null
//},

