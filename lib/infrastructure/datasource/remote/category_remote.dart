import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/model/category.dart';

class CategoryRemote {
  final Dio dio = Dio();

  Future<Category> getCategory() async {
    try {
      final response =
          await dio.get("https://dummyjson.com/products/categories");
      debugPrint("Response : ${response.data}");
      return Category.fromJson(response.data);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
