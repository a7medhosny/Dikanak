import 'package:dikanak/features/home/data/model/category_model.dart';

class BannerModel {
  final int id;
  final String image;
  final CategoryModel? category;
  final dynamic product;

  BannerModel({
    required this.id,
    required this.image,
    this.category,
    this.product,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] as int,
      image: json['image'] as String,
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'])
          : null,
      product: json['product'], // `product` can be null or any type.
    );
  }
}


