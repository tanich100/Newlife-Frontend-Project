class RegisterModel {
  final String email;
  final String password;
  final String name;
  final String lastName;
  final String tel;
  final String gender;
  final int age;
  final String? address;
  final String? career;
  final int? numOfFamMembers;
  final String? experience;
  final String? sizeOfResidence;
  final String? typeOfResidence;
  final int? freeTimePerDay;
  final String? reasonForAdoption;

  RegisterModel({
    required this.email,
    required this.password,
    required this.name,
    required this.lastName,
    required this.tel,
    required this.gender,
    required this.age,
    this.address,
    this.career,
    this.numOfFamMembers,
    this.experience,
    this.sizeOfResidence,
    this.typeOfResidence,
    this.freeTimePerDay,
    this.reasonForAdoption,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    // พิมพ์ข้อมูล JSON ที่ได้รับมา
    print('JSON Data: $json');

    return RegisterModel(
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
      name: json['name'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      tel: json['tel'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      age: json['age'] as int? ?? 0,
      address: json['address'] as String? ?? '',
      career: json['career'] as String? ?? '',
      numOfFamMembers: json['numOfFamMembers'] as int? ?? 0,
      experience: json['experience'] as String? ?? '',
      sizeOfResidence: json['sizeOfResidence'] as String? ?? '',
      typeOfResidence: json['typeOfResidence'] as String? ?? '',
      freeTimePerDay: json['freeTimePerDay'] as int? ?? 0,
      reasonForAdoption: json['reasonForAdoption'] as String? ?? '',
    );
  }
  // แก้ไขการแปลงข้อมูลเป็น JSON โดยตรวจสอบ null ก่อน
  Map<String, dynamic> toJson() {
    return {
      'Email': email,
      'Password': password,
      'Name': name,
      'LastName': lastName,
      'Tel': tel,
      'Gender': gender,
      'Age': age,
      'Address': address ?? '', // กำหนดค่าเริ่มต้นเป็น '' หากเป็น null
      'Career': career ?? '', // กำหนดค่าเริ่มต้นเป็น '' หากเป็น null
      'NumOfFamMembers':
          numOfFamMembers ?? 0, // กำหนดค่าเริ่มต้นเป็น 0 หากเป็น null
      'Experience': experience ?? '', // กำหนดค่าเริ่มต้นเป็น '' หากเป็น null
      'SizeOfResidence':
          sizeOfResidence ?? '', // กำหนดค่าเริ่มต้นเป็น '' หากเป็น null
      'TypeOfResidence':
          typeOfResidence ?? '', // กำหนดค่าเริ่มต้นเป็น '' หากเป็น null
      'FreeTimePerDay':
          freeTimePerDay ?? 0, // กำหนดค่าเริ่มต้นเป็น 0 หากเป็น null
      'ReasonForAdoption':
          reasonForAdoption ?? '', // กำหนดค่าเริ่มต้นเป็น '' หากเป็น null
    };
  }
}
