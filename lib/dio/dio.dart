import 'package:dio/dio.dart';
// import 'package:shopping_app/reusable%20components/reusable_components.dart';

 class DioHelper
{
 static Dio? dio;

 static void initDio()
 {
  dio=Dio(
    BaseOptions(
      baseUrl:"https://student.valuxapps.com/api/",
      receiveDataWhenStatusError: true,
      ),
  );
 }

 static Future<Response> postData(
  {
    required String path,
    required Map<String,dynamic> data,
    Map<String,dynamic> ?query,
    String lang="en",
    String ? authorization,
  }
 )async
 {
    dio!.options.headers=
    {
      "lang":lang,
      "Authorization":authorization??"",
      "Content-Type":"application/json",
    };
    return await dio!.post(path,queryParameters: query,data: data);
 }

 static Future<Response> getData(
  {
    required String path,
    // required Map<String,dynamic> data,
    Map<String,dynamic> ?query,
    String lang="en",
    String ? authorization,
  }
 )async
 {
    dio!.options.headers=
    {
      "lang":lang,
      "Authorization":authorization??"",
      "Content-Type":"application/json",
    };
    return await dio!.get(path,queryParameters: query);
 }

 static Future<Response> putData(
  {
    required String path,
    required Map<String,dynamic> data,
    Map<String,dynamic> ?query,
    String lang="en",
    String ? authorization,
  }
 )async
 {
    dio!.options.headers=
    {
      "lang":lang,
      "Authorization":authorization??"",
      "Content-Type":"application/json",
    };
    return await dio!.put(path,queryParameters: query,data: data);
 }
}