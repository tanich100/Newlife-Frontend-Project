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
  final String? sizeOfResidence;
  final String? typeOfResidence;
  final int? freeTimePerDay;
  final int? monthlyIncome;
  final bool? isHaveExperience;
  final List<int> interestedBreedIds;

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
    this.sizeOfResidence,
    this.typeOfResidence,
    this.freeTimePerDay,
    this.monthlyIncome,
    this.isHaveExperience,
    required this.interestedBreedIds,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    List<int> breedIds = [];
    if (json['interestedBreedIds'] != null &&
        json['interestedBreedIds'] is List) {
      breedIds = List<int>.from(json['interestedBreedIds']);
    }

    return RegisterModel(
      email: json['email'] ?? 'Unknown email',
      password: json['password'] ?? '',
      name: json['name'] ?? 'Unknown name',
      lastName: json['lastName'] ?? 'Unknown lastName',
      tel: json['tel'] ?? 'Unknown tel',
      gender: json['gender'] ?? 'Unknown gender',
      age: json['age'] ?? 0,
      address: json['address'] ?? '',
      career: json['career'] ?? '',
      numOfFamMembers: json['numOfFamMembers'] ?? 0,
      sizeOfResidence: json['sizeOfResidence'] ?? '',
      typeOfResidence: json['typeOfResidence'] ?? '',
      freeTimePerDay: json['freeTimePerDay'] ?? 0,
      interestedBreedIds: breedIds,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Email': email,
      'Password': password,
      'Name': name,
      'LastName': lastName,
      'Tel': tel,
      'Gender': gender,
      'Age': age,
      'Address': address ?? '', // กำหนดค่าเริ่มต้นหากเป็น null
      'Career': career ?? '', // กำหนดค่าเริ่มต้นหากเป็น null
      'NumOfFamMembers': numOfFamMembers ?? 0, // กำหนดค่าเริ่มต้นหากเป็น null
      'SizeOfResidence': sizeOfResidence ?? '', // กำหนดค่าเริ่มต้นหากเป็น null
      'TypeOfResidence': typeOfResidence ?? '', // กำหนดค่าเริ่มต้นหากเป็น null
      'FreeTimePerDay': freeTimePerDay ?? 0,
      'MonthlyIncome': monthlyIncome ?? 0,
      'IsHaveExperience': isHaveExperience ?? false,
      'InterestedBreedIds': interestedBreedIds,
    };
  }
}
