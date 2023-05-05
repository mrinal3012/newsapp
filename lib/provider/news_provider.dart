import 'package:newsapp/http/custom_http.dart';
import 'package:newsapp/model/news_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class NewsProvider with ChangeNotifier{

  NewsModel? newsModel;

  Future<NewsModel> getHomeData(int pageNo,String sorted)async{

    newsModel=await CustomHttp.fetchHomeData(pageNo, sorted);

    return newsModel!;
}

}