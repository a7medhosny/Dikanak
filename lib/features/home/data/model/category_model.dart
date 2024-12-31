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