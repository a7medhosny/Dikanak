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

class CategoryModel {
  final int id;
  final String image;
  final String name;

  CategoryModel({
    required this.id,
    required this.image,
    required this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      image: json['image'] as String,
      name: json['name'] as String,
    );
  }
}