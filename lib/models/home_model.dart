import 'package:flutter/widgets.dart';

class HomeModel {
  final String categoryTitle;
  final String categorySubTitle;
  final IconData categoryImage;

  const HomeModel({
    required this.categoryTitle,
    required this.categorySubTitle,
    required this.categoryImage,
  });
}
