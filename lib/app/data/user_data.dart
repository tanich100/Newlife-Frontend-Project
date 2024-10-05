class UserData {
  final int rank;
  final String name;
  final String income;
  final String free_time_per_day;
  final String type_of_residence;
  final String email;
  final String role;
  final String address;
  final String tel;
  final String gender;
  final String age;
  final String career;
  final String experience;
  final String size_of_residence;
  final String reason_for_adoption;
  final String num_of_fam_members;

   
  UserData({
    required this.rank,
    required this.name,
    required this.income,
    required this.free_time_per_day,
    required this.type_of_residence,
    required this.email,
    required this.role,
    required this.address,
    required this.tel,
    required this.gender,
    required this.age,
    required this.career,
    required this.experience,
    required this.size_of_residence,
    required this.reason_for_adoption,
    required this.num_of_fam_members


    
  });
}

List<UserData> adoptionRequests = [
  UserData(
    rank: 1,
    name: 'มิน',
    income: '30,000',
    free_time_per_day: '6-8 ชม',
    type_of_residence: 'บ้านเดี่ยว',
    email: '',
    role: '',
    address: '',
    tel: '',
    gender: '',
    age: '',
    career: '',
    experience: '',
    size_of_residence: '',
    reason_for_adoption: '',
    num_of_fam_members: '',
  ),
  UserData(
    rank: 2,
    name: 'คิว',
    income: '25,000',
    free_time_per_day: '1-3 ชม',
    type_of_residence: 'คอนโดมิเนียม',
    email: '',
    role: '',
    address: '',
    tel: '',
    gender: '',
    age: '',
    career: '',
    experience: '',
    size_of_residence: '',
    reason_for_adoption: '',
    num_of_fam_members: '',
  ),
];