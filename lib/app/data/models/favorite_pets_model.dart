class FavoriteAnimal {
  int? favoriteAnimalId;
  int userId;
  int adoptionPostId;
  DateTime dateAdded;

  FavoriteAnimal({
    this.favoriteAnimalId,
    required this.userId,
    required this.adoptionPostId,
    required this.dateAdded,
  });

  factory FavoriteAnimal.fromJson(Map<String, dynamic> json) {
    return FavoriteAnimal(
      favoriteAnimalId: json['favorite_animal_id'] != null
          ? json['favorite_animal_id'] as int
          : 0,
      userId: json['user_id'] != null ? json['user_id'] as int : 0,
      adoptionPostId: json['adoption_post_id'] != null
          ? json['adoption_post_id'] as int
          : 0,
      dateAdded: json['date_added'] != null
          ? DateTime.parse(json['date_added'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'favorite_animal_id': favoriteAnimalId,
      'user_id': userId,
      'adoption_post_id': adoptionPostId,
      'date_added': dateAdded.toIso8601String(),
    };
  }
}
