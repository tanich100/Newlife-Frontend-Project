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
  String? sex;
  String? description;
  int? province;
  int? district;
  int? subDistrict;
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
    this.sex,
    this.description,
    this.province,
    this.district,
    this.subDistrict,
    this.addressDetails,
    this.postStatus,
    this.createAt,
    this.updateAt,
    this.deleteAt,
  });

  factory FindOwnerPost.fromJson(Map<String, dynamic> json) {
    return FindOwnerPost(
      findOwnerPostId: json['find_owner_post_id'],
      userId: json['userId'],
      image1: json['image1'],
      image2: json['image2'],
      image3: json['image3'],
      image4: json['image4'],
      image5: json['image5'],
      image6: json['image6'],
      image7: json['image7'],
      image8: json['image8'],
      image9: json['image9'],
      image10: json['image10'],
      name: json['name'],
      breedId: json['breed_id'],
      sex: json['sex'],
      description: json['description'],
      province: json['province_id'],
      district: json['district_id'],
      subDistrict: json['subdistrict_id'],
      addressDetails: json['address_details'],
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
      'sex': sex,
      'description': description,
      'province_id': province,
      'district_id': district,
      'subdistrict_id': subDistrict,
      'address_details': addressDetails,
      'post_status': postStatus,
      'create_at': createAt?.toIso8601String(),
      'update_at': updateAt?.toIso8601String(),
      'delete_at': deleteAt?.toIso8601String(),
    };
  }
}
