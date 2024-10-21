import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:youbloom_task/Constants/constants.dart';

import '../Models/home_data_model.dart';

class HomeRepo {
  static Future<List<HomeDataModel>> fetchHome() async {
    List<HomeDataModel> postList = [];
    try {
      var response = await http.get(
        Uri.parse(apiKey),
      );
      List result = jsonDecode(response.body);
      for (var i = 0; i < result.length; i++) {
        HomeDataModel post = HomeDataModel.fromJson(result[i]);
        postList.add(post);
      }
      return postList;
    } catch (e) {
      Exception(e);
      return [];
    }
  }
}
