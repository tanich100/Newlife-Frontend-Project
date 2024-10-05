class UserData {
  final int rank;
  final String name;
  final String income;
  final String duration;
  final String type;

  UserData({
    required this.rank,
    required this.name,
    required this.income,
    required this.duration,
    required this.type,
  });
}

List<UserData> adoptionRequests = [
  UserData(
    rank: 1,
    name: 'มิน',
    income: '30,000',
    duration: '6-8 ม.ย.',
    type: 'บ้านเดี่ยว',
  ),
  UserData(
    rank: 2,
    name: 'คิว',
    income: '25,000',
    duration: '1-3 ธ.ย.',
    type: 'คอนโดมิเนียม',
  ),
];