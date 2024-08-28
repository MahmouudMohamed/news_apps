import 'package:flutter/material.dart';
import 'package:news_app/home/news/news_item.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/model/SourcesResponse.dart';

import '../../api/api_manager.dart';

class NewsWidget extends StatefulWidget {
  NewsWidget({required this.source, super.key});

  Source source;

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NewsResponse?>(
      future: ApiManager.getNewsData(sourceId:widget.source.id??""),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: Colors.green,
          ));
        }
        if (snapshot.hasError) {
          return Center(
            child: Column(
              children: [
                Text("something went wrong"),
                ElevatedButton(onPressed: () {
                  ApiManager.getNewsData(sourceId:widget.source.id??"");
                  setState(() {
                  });
                }, child: Text("Try Again"))
              ],
            ),
          );
        }
        if (snapshot.data!.status == "error") {
          return Center(
            child: Column(
              children: [
                Text("${snapshot.data!.message!}"),
                ElevatedButton(onPressed: () {
                  ApiManager.getNewsData(sourceId:widget.source.id??"");
                  setState(() {
                  });
                }, child: Text("Try Again"))
              ],
            ),
          );
        }
        var newsList = snapshot.data!.articles ?? [];
        return ListView.builder(
          itemBuilder: (context, index) {
            return NewsItem(articles: newsList[index]);
          },itemCount: newsList.length,
        );
      },
    );
  }
}
