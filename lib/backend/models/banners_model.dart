class BannerModel {
  final String image;
  final String id;
  final String title;

  BannerModel({
    required this.id,
    required this.image,
    required this.title,
  });

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'id': id,
      'title': title,
    };
  }

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] as String,
      image: json['image'] as String,
      title: json['title'] as String,
    );
  }
}
