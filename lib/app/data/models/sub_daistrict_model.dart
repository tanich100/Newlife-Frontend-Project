class  SubDistrictModel{
  int? id;
  int? zipCode;
  String? nameTh;
  String? nameEn;
  int? districtId;

  SubDistrictModel({
    this.id,
    this.zipCode,
    this.nameTh,
    this.nameEn,
    this.districtId,
  });

  factory SubDistrictModel.fromJson(Map<String, dynamic> json) {
    return SubDistrictModel(
      id: json['id'] ?? json['id'],
      zipCode: json['zipCode'],
      nameTh: json['name_th'] ?? json['nameTh'],
      nameEn: json['name_en'] ?? json['nameEn'],
      districtId: json['districtId'] ?? json['districtId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'zipCode': zipCode,
      'nameTh': nameTh,
      'nameEn': nameEn,
      'districtId': districtId,
    };
  }
}