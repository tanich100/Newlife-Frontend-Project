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
  String? tel;
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
  List<String> imageFileNames;

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
    this.tel,
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
    this.imageFileNames = const [],
  });

  factory AdoptionPost.fromJson(Map<String, dynamic> json) {
    return AdoptionPost(
      adoptionPostId: json['adoption_post_id'] ?? json['adoptionPostId'],
      userId: json['user_id'] ?? json['userId'],
      imageFileNames: List<String>.from(json['image_file_names'] ?? []),
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
      tel: json['tel'],
      breedId: json['breed_id'] ?? json['breedId'],
      age: json['age'],
      sex: json['sex'],
      isNeedAttention: json['is_need_attention'] ?? json['isNeedAttention'],
      description: json['description'],
      provinceId: json['province_id'] ?? json['provinceId'],
      districtId: json['district_id'] ?? json['districtId'],
      subdistrictId: json['subdistrict_id'] ?? json['subdistrictId'],
      addressDetails: json['address_details'] ?? json['addressDetails'],
      adoptionStatus: json['adoption_status'] ?? json['adoptionStatus'],
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

  Map<String, dynamic> toJson() {
    final data = {
      'adoptionPostId': adoptionPostId ?? 1,
      'userId': userId ?? 61, // ต้องปรับให้เหมาะสม
      'name': name ?? "test",
      'tel': tel ?? null,
      'breedId': breedId ?? null,
      'age': age ?? null,
      'sex': sex ?? "M",
      'isNeedAttention': isNeedAttention ?? null,
      'description': description ?? "testdescription",
      'provinceId': provinceId ?? null,
      'districtId': districtId ?? null,
      'subdistrictId': subdistrictId ?? null,
      'addressDetails': addressDetails ?? "addressDetails",
      'adoptionStatus': adoptionStatus ?? "pending",         // ต้องปรับให้เหมาะสม
      'postStatus': postStatus ?? "active",
      'createAt': createAt?.toIso8601String(),
      'updateAt': updateAt?.toIso8601String(),
      'deleteAt': deleteAt?.toIso8601String(),
    };

    // เพิ่มชื่อไฟล์รูปภาพลงใน image1 ถึง image10 ตามลำดับ
    for (int i = 0; i < imageFileNames.length; i++) {
      data['Image${i + 1}'] = imageFileNames[i];
    }

    // กรณีที่ไม่มีข้อมูลรูปภาพให้ตั้งค่าเป็น null
    for (int i = imageFileNames.length; i < 10; i++) {
      data['Image${i + 1}'] = null;
    }

    return data;
  }
}
