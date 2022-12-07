class BannerModel {
  BannerModel({
    required this.id,
    required this.topImage,
    required this.bottomImage,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String topImage;
  final String bottomImage;
  final String? title;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    id: json["id"],
    topImage: json["top_image"],
    bottomImage: json["bottom_image"],
    title: json["title"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}
