import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/model/news_model.dart';

class HomePage extends StatelessWidget {
 // const HomePage({Key? key}) : super(key: key);
  String url="https://newsapi.org/v2/everything?q=bangladesh&page=1&pageSize=5&apiKey=ccdb5fd8b4744dacb1416e93f8c8cf7d";
  NewsModel? newsModel;
  Future<NewsModel>fetchHomeData()async{
    var responce= await http.get(Uri.parse(url));
    var data =jsonDecode(responce.body);
    newsModel=NewsModel.fromJson(data);
    return newsModel!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("News Paper"),),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child:ListView(children: [
          
          FutureBuilder<NewsModel>(
              future: fetchHomeData(),
              builder: (context, snapshot) {
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),

                  );
                }else if(snapshot.hasError){
                  return Text("Wrong",style: TextStyle(color: Colors.black),);
                }else if(snapshot.data==null){
                  return Text("null",style: TextStyle(color: Colors.black),);
                }return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.articles!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 150,color: Color(0xff001429),
                        child: Stack(children: [
                          Container(
                            height: 70,
                            width: 70,
                            color: Colors.redAccent,
                          ),
                          Container(
                            height: 70,
                            width: 70,
                            color: Colors.redAccent,
                          ),
                          Container(
                            margin: EdgeInsets.all(20),
                            color: Colors.black,
                          ),
                          Positioned(
                            right: 0,
                              bottom: 0,
                              child:Container(
                                height: 70,
                                width: 70,
                                color: Colors.redAccent,
                          ) ),
                          Container(
                            margin: EdgeInsets.all(12),
                            color: Color(0xFF1B192F),
                            child:  Padding(
                              padding: const EdgeInsets.only(left: 10,right: 5,top: 5,bottom: 5),
                              child: Row(
                                children: [
                                  Expanded(flex: 2,child:CachedNetworkImage(
                                    imageUrl: "${snapshot.data!.articles![index].urlToImage}",height: 100,
                                    placeholder: (context, url) => CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOmYqa4Vpnd-FA25EGmYMiDSWOl9QV8UN1du_duZC9mQ&s"),
                                  ), ),
                                  SizedBox(width: 10,),
                                  Expanded(flex: 3, child:Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      Text("${snapshot.data!.articles![index].source!.name}",style: TextStyle(color: Colors.white),),
                                      Text("${snapshot.data!.articles![index].source!.id}",style: TextStyle(color: Colors.white),),
                                    ],),
                                    Text("${snapshot.data!.articles![index].title}",style: TextStyle(color: Colors.white),),
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                     Icon(Icons.add_link_outlined,color: Colors.blue,),
                                     Text("${snapshot.data!.articles![index].publishedAt}",style: TextStyle(color: Colors.white),),
                                   ],)
                                  ],) ),
                                ],
                              ),
                            ),
                          ),

                        ],),

                      ),
                    );
                },);
              },)
          
        ],) ,),
    );
  }
}
