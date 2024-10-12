class AdoptionPost {
  int? adoptionPostId;
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
      adoptionPostId: json['adoptionPostId'],
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
      breedId: json['breedId'],
      age: json['age'],
      sex: json['sex'],
      isNeedAttention: json['isNeedAttention'],
      description: json['description'],
      provinceId: json['provinceId'],
      districtId: json['districtId'],
      subdistrictId: json['subdistrictId'],
      addressDetails: json['addressDetails'],
      adoptionStatus: json['adoptionStatus'],
      postStatus: json['postStatus'],
      createAt:
          json['creatAt'] != null ? DateTime.parse(json['creatAt']) : null,
      updateAt:
          json['updateAt'] != null ? DateTime.parse(json['updateAt']) : null,
      deleteAt:
          json['deleteAt'] != null ? DateTime.parse(json['deleteAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adoptionPostId': adoptionPostId,
      'userId': userId,
      'image1': image1,
      'image2': image2,
      'image3': image3,
      'image4': image4,
      'image5': image5,
      'image6': image6,
      'image7': image7,
      'image8': image8,
      'image9': image9,
      'image10': image10,
      'name': name,
      'breedId': breedId,
      'age': age,
      'sex': sex,
      'isNeedAttention': isNeedAttention,
      'description': description,
      'provinceId': provinceId,
      'districtId': districtId,
      'subdistrictId': subdistrictId,
      'addressDetails': addressDetails,
      'adoptionStatus': adoptionStatus,
      'postStatus': postStatus,
      'createAt': createAt?.toIso8601String(),
      'updateAt': updateAt?.toIso8601String(),
      'deleteAt': deleteAt?.toIso8601String(),
    };
  }
}
