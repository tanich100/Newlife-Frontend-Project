class AdoptionRequestDto {
  final int userId;
  final int adoptionPostId;
  final String reasonForAdoption;

  AdoptionRequestDto({
    required this.userId,
    required this.adoptionPostId,
    required this.reasonForAdoption,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'adoptionPostId': adoptionPostId,
        'reasonForAdoption': reasonForAdoption,
      };
}
