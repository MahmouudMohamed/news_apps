import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/model/SourcesResponse.dart';

import '../model/api_const.dart';

class ApiManager {
  static Future<SourcesResponse?> getSources(String categoryId) async {
    Uri url = Uri.https(
      ApiConst.baseUrl,
      ApiConst.endPointSources,
      {
        "apiKey": ApiConst.apiKey,
        "category": categoryId,
      },
    );

    var response = await http.get(url);
    try {
      // Map<String, dynamic> format = jsonDecode(response.body);
      SourcesResponse sourcesResponse =
          SourcesResponse.fromJson(jsonDecode(response.body));
      return sourcesResponse;
    } catch (e) {
      throw e;
    }
  }

  static Future<NewsResponse?> getNewsData(
      {String? sourceId, String? searchId}) async {
    Uri url = Uri.https(
      ApiConst.baseUrl,
      ApiConst.endPointNews,
      {
        "apiKey": ApiConst.apiKey,
        "sources": sourceId,
        "q": searchId,
      },
    );
    var response = await http.get(url);
    NewsResponse newsResponse =
        NewsResponse.fromJson(jsonDecode(response.body));
    return newsResponse;
  }
}
