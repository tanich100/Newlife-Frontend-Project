import 'package:newlife_app/app/data/models/local_user.dart';
import 'package:newlife_app/app/data/network/services/api_service.dart';
import '../../../constants/app_url.dart';

class UserApi {
  final ApiService _apiService = ApiService();

  Future<localUser> login(int id) async {
    try {
      final response = await _apiService.post('${AppUrl.user+'/login'}');
      return localUser.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

}