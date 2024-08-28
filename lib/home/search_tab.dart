import 'package:flutter/material.dart';
import '../api/api_manager.dart';
import '../model/NewsResponse.dart';
import 'news/news_item.dart';

class SearchTab extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
            showSuggestions(context);
          },
          icon: Icon(
            Icons.clear_outlined,
            color: Colors.green,
          )),
      IconButton(
          onPressed: () {
            showResults(context);
          },
          icon: Icon(
            Icons.search_rounded,
            size: 30,
            color: Colors.green,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return searchSuggestionsBar();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return searchSuggestionsBar();
  }

  searchSuggestionsBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage("assets/images/pattern.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: FutureBuilder<NewsResponse?>(
        future: ApiManager.getNewsData(searchId: query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.green,
            ));
          }
          if (snapshot.hasError) {
            return Center(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage("assets/images/pattern.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Something Went Wrong"),
                  ],
                ),
              ),
            );
          }
          if (snapshot.data!.status == "error") {
            return Center(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage("assets/images/pattern.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("No Item Found"),
                  ],
                ),
              ),
            );
          }
          var newsList = snapshot.data!.articles ?? [];
          return ListView.builder(
            itemBuilder: (context, index) {
              return NewsItem(articles: newsList[index]);
            },
            itemCount: newsList.length,
          );
        },
      ),
    );
  }
}
