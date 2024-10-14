// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductModel {
  final int? id;
  final String? title;
  final double? price;
  final String? description;
  final String? category;
  final String? image;
  final Rating? rating;

  ProductModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  ProductModel copyWith({
    int? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
    Rating? rating,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': rating?.toMap(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      price: map['price'] != null
          ? map['price'] is int
              ? (map['price'] as int).toDouble()
              : map['price'] as double
          : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      rating: map['rating'] != null
          ? Rating.fromMap(map['rating'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id, title: $title, price: $price, description: $description, category: $category, image: $image, rating: $rating)';
  }

  bool get goodQuality => rating?.count == 5;

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.price == price &&
        other.description == description &&
        other.category == category &&
        other.image == image &&
        other.rating == rating;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        price.hashCode ^
        description.hashCode ^
        category.hashCode ^
        image.hashCode ^
        rating.hashCode;
  }
}

class Rating {
  final double rate;
  final int count;
  Rating({
    required this.rate,
    required this.count,
  });

  Rating copyWith({
    double? rate,
    int? count,
  }) {
    return Rating(
      rate: rate ?? this.rate,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rate': rate,
      'count': count,
    };
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      rate: map['rate'].toDouble() as double,
      count: map['count'].toInt() as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rating.fromJson(String source) =>
      Rating.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Rating(rate: $rate, count: $count)';

  @override
  bool operator ==(covariant Rating other) {
    if (identical(this, other)) return true;

    return other.rate == rate && other.count == count;
  }

  @override
  int get hashCode => rate.hashCode ^ count.hashCode;
}
