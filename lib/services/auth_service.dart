
import 'dart:convert';

import 'package:http/http.dart' as http;
class AuthService{

  final String BASE_URL="https://festive-clarke.93-51-37-244.plesk.page/api/v1";

   // register user
  Future<bool> registerUser(String name,String email,String password ,String role)async{
        final response = await http.post(Uri.parse('$BASE_URL/register'),
        body: {
          'name':name,
          'email':email,
          'password':password,
          'role':role,
        });
        print(response.body);
        return response.statusCode == 200;

  }
//login user
  Future<String?> login(String email,String password)async{
    final response = await http.post(Uri.parse('$BASE_URL/login'),
    body: {
      'email':email,
      'password':password
    },
    );
    if(response.statusCode == 200){
      final responseBody = jsonDecode(response.body);
      return responseBody['token'];
    }
    return null;
  }
  // logout user
  Future<bool> logout(String token)async{
    final response = await http.post(Uri.parse('$BASE_URL/logout'),
    headers: {'Authorization':'Bearer $token'});
    return response.statusCode == 200;
  }

}