class Province {
  int? provinceId;
  String? code;
  String? nameTh;
  String? nameEn;
  int? geographyId;

  Province({
    this.provinceId,
    this.code,
    this.nameTh,
    this.nameEn,
    this.geographyId,
  });

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      provinceId: json['province_id'] ?? json['provinceId'],
      code: json['code'],
      nameTh: json['name_th'] ?? json['nameTh'],
      nameEn: json['name_en'] ?? json['nameEn'],
      geographyId: json['geography_id'] ?? json['geographyId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'province_id': provinceId,
      'code': code,
      'name_th': nameTh,
      'name_en': nameEn,
      'geography_id': geographyId,
    };
  }
}