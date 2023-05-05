import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/model/news_model.dart';
import 'package:newsapp/provider/news_provider.dart';
import 'package:newsapp/screen/details_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // const HomePage({Key? key}) : super(key: key);
  var pageNo = 1;
  String sorted = "relevancy";
  final scrollController = ScrollController();
  @override
  void initState() {
    scrollController.addListener(() {
      setState(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          pageNo = pageNo+1;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var newsPorvider = Provider.of<NewsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("News Paper")),
        backgroundColor: Color(0xff1B192F),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: DropdownButton(
                    value: sorted,
                    items: [
                      DropdownMenuItem(
                        child: Text("relevancy"),
                        value: "relevancy",
                      ),
                      DropdownMenuItem(
                        child: Text("popularity"),
                        value: "popularity",
                      ),
                      DropdownMenuItem(
                        child: Text("publishedAt"),
                        value: "publishedAt",
                      ),
                    ],
                    onChanged: (String? value) => setState(() {
                          sorted = value!;
                        })),
              ),
            ),
            FutureBuilder<NewsModel>(
              future: newsPorvider.getHomeData(pageNo, sorted),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    "Wrong",
                    style: TextStyle(color: Colors.black),
                  );
                } else if (snapshot.data == null) {
                  return Text(
                    "null",
                    style: TextStyle(color: Colors.black),
                  );
                }
                return ListView.builder(
                  controller: scrollController,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.articles!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailsPage(
                                articles: snapshot.data!.articles![index]),
                          ));
                        },
                        child: Container(
                          height: 150,
                          color: Color(0xff001429),
                          child: Stack(
                            children: [
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
                                  child: Container(
                                    height: 70,
                                    width: 70,
                                    color: Colors.redAccent,
                                  )),
                              Container(
                                margin: EdgeInsets.all(12),
                                color: Color(0xFF1B192F),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 5, top: 5, bottom: 5),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: CachedNetworkImage(
                                          imageUrl: "${snapshot.data!.articles![index].urlToImage}",
                                          height: 100,
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Image.network(
                                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOmYqa4Vpnd-FA25EGmYMiDSWOl9QV8UN1du_duZC9mQ&s"),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "${snapshot.data!.articles![index].source!.name}",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    "${snapshot.data!.articles![index].source!.id}",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "${snapshot.data!.articles![index].title}",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Icon(
                                                    Icons.add_link_outlined,
                                                    color: Colors.blue,
                                                  ),
                                                  Text(
                                                    "${snapshot.data!.articles![index].publishedAt}",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
