import 'package:meta/meta.dart';
import 'dart:convert';

class Category {
  final List<String> categories;

  Category({
    required this.categories,
  });

  List<String> categoryFromJson(String str) =>
      List<String>.from(json.decode(str).map((x) => x));

  String categoryToJson(List<String> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x)));

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categories: List<String>.from(json["categories"].map((x) => x)),
      );
}
