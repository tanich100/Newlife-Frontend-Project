import 'package:newlife_app/app/data/models/local_user.dart';
import 'package:newlife_app/app/data/network/services/api_service.dart';
import '../../../constants/app_url.dart';

class UserApi {
  final ApiService _apiService = ApiService();

  Future<localUser> login(String username, String password) async {
    final requestData = {
      'email': username,
      'password': password,
    };

    try {
      final response =
          await _apiService.post('${AppUrl.user}/login', data: requestData);
      if (response.statusCode == 200) {
        return localUser.fromJson(response.data);
      } else {
        throw Exception('Failed to login: ${response.data['message']}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
