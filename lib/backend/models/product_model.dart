class ProductModel {
  final String id;
  final String name;
  final String image;
  final double price;
  final String description;
  final double discountPrice;
  final bool haveDiscount;
  final String currency;

  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.discountPrice,
    required this.haveDiscount,
    required this.currency,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      discountPrice: (json['discountPrice'] as num).toDouble(),
      haveDiscount: json['haveDiscount'] as bool,
      currency: json['currency'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'description': description,
      'discountPrice': discountPrice,
      'haveDiscount': haveDiscount,
      'currency': currency,
    };
  }
}
