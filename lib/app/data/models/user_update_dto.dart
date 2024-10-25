class UserUpdateDto {
  String? name;
  String? lastName;
  String? tel;
  String? gender;
  int? age;
  String? address;
  String? career;
  int? numOfFamMembers;
  bool? isHaveExperience;
  String? sizeOfResidence;
  String? typeOfResidence;
  int? freeTimePerDay;
  int? monthlyIncome;

  UserUpdateDto({
    this.name,
    this.lastName,
    this.tel,
    this.gender,
    this.age,
    this.address,
    this.career,
    this.numOfFamMembers,
    this.isHaveExperience,
    this.sizeOfResidence,
    this.typeOfResidence,
    this.freeTimePerDay,
    this.monthlyIncome,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (name != null) data['Name'] = name;
    if (lastName != null) data['LastName'] = lastName;
    if (tel != null) data['Tel'] = tel;
    if (gender != null) data['Gender'] = gender;
    if (age != null) data['Age'] = age;
    if (address != null) data['Address'] = address;
    if (career != null) data['Career'] = career;
    if (numOfFamMembers != null) data['NumOfFamMembers'] = numOfFamMembers;
    if (isHaveExperience != null) data['IsHaveExperience'] = isHaveExperience;
    if (sizeOfResidence != null) data['SizeOfResidence'] = sizeOfResidence;
    if (typeOfResidence != null) data['TypeOfResidence'] = typeOfResidence;
    if (freeTimePerDay != null) data['FreeTimePerDay'] = freeTimePerDay;
    if (monthlyIncome != null) data['MonthlyIncome'] = monthlyIncome;
    return data;
  }
}
