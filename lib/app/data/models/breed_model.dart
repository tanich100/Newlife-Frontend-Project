class Breed {
  final int? breedId;
  final String animalType;
  final String breedName;

  Breed({
    this.breedId,
    required this.animalType,
    required this.breedName,
  });

  factory Breed.fromJson(Map<String, dynamic> json) {
    return Breed(
      breedId: json['breedId'] != null ? json['breedId'] as int : null,
      animalType: json['animalType'] as String? ?? 'ไม่ทราบ',
      breedName: json['breedName'] as String? ?? 'ไม่ทราบสายพันธุ์',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'breedId': breedId,
      'animalType': animalType,
      'breedName': breedName,
    };
  }
}
