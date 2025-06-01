class FilteredStoreModel {
  final int id;
  final String name;
  final List<String> images;
  final String geolocation;

  FilteredStoreModel({
    required this.id,
    required this.name,
    required this.images,
    required this.geolocation,
  });

  factory FilteredStoreModel.fromJson(Map<String, dynamic> json) {
    return FilteredStoreModel(
      id: json['id'],
      name: json['name'],
      geolocation: json['geolocation'],
      images: List<String>.from(json['images']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'images': images,
      'geolocation': geolocation,
    };
  }
}
