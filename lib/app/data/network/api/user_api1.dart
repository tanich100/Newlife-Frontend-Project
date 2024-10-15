// import 'package:dio/dio.dart';
// import 'package:newlife_app/app/data/models/local_user.dart';

// class UserApi1 {
//   final Dio dio = Dio(); // Create an instance of Dio
//   Future<localUser> login(String username, String password) async {
//     try {
//       // Send the username and password as query parameters
//       final response = await dio.post(
//         "http://10.0.2.2:5296/User/login",
//         queryParameters: {
//           'email': username,
//           'password': password,
//         },
//       );
//       print(response.statusCode);
//       print(response.statusMessage);
//       print(response.data);
//       if (response.statusCode == 200) {
//         return localUser.fromJson(response.data);
//       } else {
//         throw Exception('Failed to login: ${response.data['message']}');
//       }
//     } catch (e) {
//       // Optional: Print error details for debugging
//       if (e is DioError) {
//         print('DioError: ${e.response?.data}');
//         print('Status code: ${e.response?.statusCode}');
//         print('Request data: ${e.requestOptions.data}');
//       }
//       rethrow; // Re-throw the error for further handling
//     }
//   }

//   // Post method for making the HTTP request
//   Future<Response> post(String url, {dynamic data}) async {
//     try {
//       return await dio.post(url, data: data);
//     } catch (e) {
//       rethrow; // Re-throw the error for handling in the calling function
//     }
//   }
// }
