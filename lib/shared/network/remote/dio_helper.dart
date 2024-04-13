import 'package:dio/dio.dart';
//https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca
//https://www.newsmisr.info/wp-content/uploads/2022/08/حديد-تسليح.jpg
//77b7c9627b664aa9b81ee875eafaf5ec key al api bta3y
//https://newsapi.org/v2/everything?q=tesla&apiKey=65f7f556ec76449fa7dc7c0069f040ca
class DioHelper {
  static late Dio dio ;
  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl:'https://student.valuxapps.com/api/', 
        receiveDataWhenStatusError: true,
      )
    );
  }


  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en', 
    String? token}) async{
    dio.options.headers = {
      'Content-Type' : 'application/json',
      'lang' : lang ,
      'Authorization' : token,
    };
    return await dio.get(url,queryParameters: query );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> Data,
    String lang = 'en', 
    String? token }) async{
    dio.options.headers = {
      'Content-Type' : 'application/json',
      'lang' : lang ,
      'Authorization' : token,
    }; 

    return dio.post(url, queryParameters: query, data: Data);

  }

  static Future<Response> putData({ 
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> Data,
    String lang = 'en', 
    String? token }) async{
    dio.options.headers = {
      'Content-Type' : 'application/json',
      'lang' : lang ,
      'Authorization' : token,
    }; 

    return dio.put(url, queryParameters: query, data: Data);

  }

}
