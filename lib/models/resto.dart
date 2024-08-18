class Restaurant {
  final String id;
  final String name;
  final String address;
  final String ville;
  final double rating;
  final List<String> images;

  Restaurant({
    required this.id,
    required this.name,
    required this.address,
    required this.ville,
    required this.rating,
    required this.images,
  });

  // Factory method to create a Restaurant from JSON
  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['nom'],
      address: json['adress'],
      ville: json['ville'],
      rating: json['rating'].toDouble(),
      images: List<String>.from(json['images']),
    );
  }
}
