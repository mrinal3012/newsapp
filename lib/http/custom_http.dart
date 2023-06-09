import 'dart:convert';

import 'package:newsapp/model/news_model.dart';
import 'package:provider/provider.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;

class CustomHttp{



  static Future<NewsModel>fetchHomeData(int pageNo,String sorted)async{
    String url="https://newsapi.org/v2/everything?q=india&page=${pageNo}&pageSize=10&sortBy=${sorted}&apiKey=ccdb5fd8b4744dacb1416e93f8c8cf7d";
    NewsModel? newsModel;
    var responce= await http.get(Uri.parse(url));
    var data =jsonDecode(responce.body);
    newsModel=NewsModel.fromJson(data);
    return newsModel!;
  }

}