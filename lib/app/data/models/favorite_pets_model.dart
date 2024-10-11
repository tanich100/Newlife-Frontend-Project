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
      favoriteAnimalId: json['favoriteAnimalId'] as int?,
      userId: json['userId'] as int,
      adoptionPostId: json['adoptionPostId'] as int,
      dateAdded: DateTime.parse(json['dateAdded'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'favoriteAnimalId': favoriteAnimalId,
      'userId': userId,
      'adoptionPostId': adoptionPostId,
      'dateAdded': dateAdded.toIso8601String(),
    };
  }
}
