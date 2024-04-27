import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/model/product.dart';

class ProductRemote {
  final dio = Dio();

  Future<Product> getProducts() async {
    try {
      final response = await dio.get("https://dummyjson.com/products");
      debugPrint("Response : ${response.data}");
      return Product.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
