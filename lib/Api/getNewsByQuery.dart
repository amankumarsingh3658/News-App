import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapp/Model/NewsQueryModel.dart';

Future<NewsQueryModel> getNewsByQuery(String query) async {
  String url =
      "https://newsapi.org/v2/everything?q=$query&from=${DateTime.now().subtract(Duration(days: 3))}&sortBy=popularity&apiKey=cab885c685f84fa48b6ccf488f6c425e";
  http.Response response = await http.get(Uri.parse(url));
  final data = jsonDecode(response.body);
  if (response.statusCode == 200) {
    return NewsQueryModel.fromJson(data);
  } else {
    return NewsQueryModel.fromJson(data);
  }
}
