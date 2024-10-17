class FindOwnerPost {
  int? findOwnerPostId;
  int? userId;
  String? image1;
  String? image2;
  String? image3;
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
  String? description;
  int? provinceId;
  int? districtId;
  int? subdistrictId;
  String? addressDetails;
  String? postStatus;
  DateTime? createAt;
  DateTime? updateAt;
  DateTime? deleteAt;

  FindOwnerPost({
    this.findOwnerPostId,
    this.userId,
    this.image1,
    this.image2,
    this.image3,
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
    this.description,
    this.provinceId,
    this.districtId,
    this.subdistrictId,
    this.addressDetails,
    this.postStatus,
    this.createAt,
    this.updateAt,
    this.deleteAt,
  });

  factory FindOwnerPost.fromJson(Map<String, dynamic> json) {
    return FindOwnerPost(
      findOwnerPostId: json['find_owner_post_id'] ?? json['findOwnerPostId'],
      userId: json['user_id'] ?? json['userId'],
      image1: json['image_1'] ?? json['image1'],
      image2: json['image_2'] ?? json['image2'],
      image3: json['image_3'] ?? json['image3'],
      image4: json['image_4'] ?? json['image4'],
      image5: json['image_5'] ?? json['image5'],
      image6: json['image_6'] ?? json['image6'],
      image7: json['image_7'] ?? json['image7'],
      image8: json['image_8'] ?? json['image8'],
      image9: json['image_9'] ?? json['image9'],
      image10: json['image_10'] ?? json['image10'],
      name: json['name'],
      breedId: json['breed_id'] ?? json['breedId'],
      age: json['age'],
      sex: json['sex'],
      description: json['description'],
      provinceId: json['province_id'] ?? json['provinceId'],
      districtId: json['district_id'] ?? json['districtId'],
      subdistrictId: json['subdistrict_id'] ?? json['subdistrictId'],
      addressDetails: json['address_details'] ?? json['addressDetails'],
      postStatus: json['post_status'] ?? json['postStatus'],
      createAt: json['create_at'] != null
          ? DateTime.parse(json['create_at'])
          : json['createAt'] != null
              ? DateTime.parse(json['createAt'])
              : null,
      updateAt: json['update_at'] != null
          ? DateTime.parse(json['update_at'])
          : json['updateAt'] != null
              ? DateTime.parse(json['updateAt'])
              : null,
      deleteAt: json['delete_at'] != null
          ? DateTime.parse(json['delete_at'])
          : json['deleteAt'] != null
              ? DateTime.parse(json['deleteAt'])
              : null,
    );
  }

  int? get adoptionPostId => null;

  Map<String, dynamic> toJson() {
    return {
      'find_owner_post_id': findOwnerPostId,
      'user_id': userId,
      'image_1': image1,
      'image_2': image2,
      'image_3': image3,
      'image_4': image4,
      'image_5': image5,
      'image_6': image6,
      'image_7': image7,
      'image_8': image8,
      'image_9': image9,
      'image_10': image10,
      'name': name,
      'breed_id': breedId,
      'age': age,
      'sex': sex,
      'description': description,
      'province_id': provinceId,
      'district_id': districtId,
      'subdistrict_id': subdistrictId,
      'address_details': addressDetails,
      'post_status': postStatus,
      'create_at': createAt?.toIso8601String(),
      'update_at': updateAt?.toIso8601String(),
      'delete_at': deleteAt?.toIso8601String(),
    };
  }
}
