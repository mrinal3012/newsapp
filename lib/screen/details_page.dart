import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/model/news_model.dart';

class DetailsPage extends StatelessWidget {
 // const DetailsPage({Key? key}) : super(key: key);

  Articles? articles;
  DetailsPage({required this.articles});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1B192F),
      appBar: AppBar(
        backgroundColor: Color(0xff1B192F),
        title:  Center(
          child: Text(
            "${articles?.source?.name}",
            style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: ListView(
          children: [
            Text(
              "${articles!.title}",
              style: TextStyle(
                  fontSize: 35, color: Colors.white, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${articles!.publishedAt}",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                Text(
                  "less them a minute",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 350,
              width: 50,
              // color: Colors.redAccent,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: CachedNetworkImage(
                imageUrl: "${articles!.urlToImage}",height: 300,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOmYqa4Vpnd-FA25EGmYMiDSWOl9QV8UN1du_duZC9mQ&s"),
              ),


              // Image(image: NetworkImage("${articles!.urlToImage}")),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Description",
                style: TextStyle(fontSize: 26, color: Colors.white,fontWeight: FontWeight.w600)),
            SizedBox(
              height: 20,
            ),
            Text(
                "${articles!.description}",
                style: TextStyle(fontSize: 22, color: Colors.white)),
            SizedBox(
              height: 20,
            ),
            Text("Contruct", style: TextStyle(fontSize: 26, color: Colors.white,fontWeight: FontWeight.w600)),
            SizedBox(
              height: 20,
            ),
            Text(
                "${articles!.content}",
                style: TextStyle(fontSize: 22, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
