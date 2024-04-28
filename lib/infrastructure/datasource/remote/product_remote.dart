import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/model/product.dart';

class ProductRemote {
  final dio = Dio();

  Future<Product> getProducts(int? limit) async {
    try {
      final response =
          await dio.get("https://dummyjson.com/products?limit=${limit ?? 10}");
      debugPrint("Response : ${response.data}");
      return Product.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Product> getProductByName(String name) async {
    try {
      final response =
          await dio.get("https://dummyjson.com/products/search?q=$name");
      debugPrint("Response : ${response.data}");
      return Product.fromJson(response.data);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<Product> getProductByCategory(String category) async {
    try {
      final response =
          await dio.get("https://dummyjson.com/products/category/$category");
      debugPrint("Response : ${response.data}");
      return Product.fromJson(response.data);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
