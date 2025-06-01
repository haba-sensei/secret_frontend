class StoreModel {
  final int id;
  final String name;
  final String? description;
  final String? location;
  final String? geolocation;
  final List<String> images;
  final double? rating;
  final int? reviewCount;
  double? distance;
  String? estimatedTime;

  StoreModel({
    required this.id,
    required this.name,
    this.description,
    this.location,
    this.geolocation,
    required this.images,
    this.rating,
    this.reviewCount,
    this.distance,
    this.estimatedTime,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      location: json['location'] as String?,
      geolocation: json['geolocation'] as String?,
      images: List<String>.from(json['images'] as List<dynamic>),
      rating:
          json['rating'] != null ? (json['rating'] as num).toDouble() : null,
      reviewCount: json['reviewCount'] as int?,
      distance: json['distance'] != null
          ? (json['distance'] as num).toDouble()
          : null,
      estimatedTime: json['estimatedTime'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'location': location,
      'geolocation': geolocation,
      'images': images,
      'rating': rating,
      'reviewCount': reviewCount,
      'distance': distance,
      'estimatedTime': estimatedTime,
    };
  }
}
