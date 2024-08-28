import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/Model/TopNewsModel.dart';

Future<TopHeadingsModel> getTopNews()async{
  String url = "https://newsapi.org/v2/top-headlines?country=in&apiKey=cab885c685f84fa48b6ccf488f6c425e";
  http.Response response = await http.get(Uri.parse(url));
  var data = jsonDecode(response.body);
  if (response.statusCode == 200) {
    return TopHeadingsModel.fromJson(data);
  } else {
    return TopHeadingsModel.fromJson(data);
  }
}