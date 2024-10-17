class District {
  int id;
  String code;
  String nameTh;
  String nameEn;
  int provinceId;

  District({
    required this.id,
    required this.code,
    required this.nameTh,
    required this.nameEn,
    required this.provinceId,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json['id'],
      code: json['code'],
      nameTh: json['nameTh'],
      nameEn: json['nameEn'],
      provinceId: json['provinceId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name_th': nameTh,
      'name_en': nameEn,
      'province_id': provinceId,
    };
  }
}