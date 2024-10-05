class AdoptionPost {
  int? adoptionPostId;
  int? userId;
  String image1;
  String image2;
  String image3;
  String? image4;
  String? image5;
  String? image6;
  String? image7;
  String? image8;
  String? image9;
  String? image10;
  String? name;
  int? breedId;
  int? age;
  String? sex;
  bool? isNeedAttention;
  String? description;
  int? provinceId;
  int? districtId;
  int? subdistrictId;
  String? addressDetails;
  String? adoptionStatus;
  String? postStatus;
  DateTime? createAt;
  DateTime? updateAt;
  DateTime? deleteAt;

  AdoptionPost({
    this.adoptionPostId,
    this.userId,
    required this.image1,
    required this.image2,
    required this.image3,
    this.image4,
    this.image5,
    this.image6,
    this.image7,
    this.image8,
    this.image9,
    this.image10,
    this.name,
    this.breedId,
    this.age,
    this.sex,
    this.isNeedAttention,
    this.description,
    this.provinceId,
    this.districtId,
    this.subdistrictId,
    this.addressDetails,
    this.adoptionStatus,
    this.postStatus,
    this.createAt,
    this.updateAt,
    this.deleteAt,
  });

  factory AdoptionPost.fromJson(Map<String, dynamic> json) {
    return AdoptionPost(
      adoptionPostId: json['adoption_post_id'],
      userId: json['user_id'],
      image1: json['image1'] ?? '',
      image2: json['image2'] ?? '',
      image3: json['image3'] ?? '',
      image4: json['image4'],
      image5: json['image5'],
      image6: json['image6'],
      image7: json['image7'],
      image8: json['image8'],
      image9: json['image9'],
      image10: json['image10'],
      name: json['name'],
      breedId: json['breed_id'],
      age: json['age'],
      sex: json['sex'],
      isNeedAttention: json['is_need_attention'],
      description: json['description'],
      provinceId: json['province_id'],
      districtId: json['district_id'],
      subdistrictId: json['subdistrict_id'],
      addressDetails: json['address_details'],
      adoptionStatus: json['adoption_status'],
      postStatus: json['post_status'],
      createAt:
          json['create_at'] != null ? DateTime.parse(json['create_at']) : null,
      updateAt:
          json['update_at'] != null ? DateTime.parse(json['update_at']) : null,
      deleteAt:
          json['delete_at'] != null ? DateTime.parse(json['delete_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adoption_post_id': adoptionPostId,
      'user_id': userId,
      'image1': image1 ?? '',
      'image2': image2 ?? '',
      'image3': image3 ?? '',
      'image4': image4,
      'image5': image5,
      'image6': image6,
      'image7': image7,
      'image8': image8,
      'image9': image9,
      'image10': image10,
      'name': name,
      'breed_id': breedId,
      'age': age,
      'sex': sex,
      'is_need_attention': isNeedAttention,
      'description': description,
      'province_id': provinceId,
      'district_id': districtId,
      'subdistrict_id': subdistrictId,
      'address_details': addressDetails,
      'adoption_status': adoptionStatus,
      'post_status': postStatus,
      'create_at': createAt?.toIso8601String(),
      'update_at': updateAt?.toIso8601String(),
      'delete_at': deleteAt?.toIso8601String(),
    };
  }
}
