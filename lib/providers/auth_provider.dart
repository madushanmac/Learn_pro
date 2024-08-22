import 'package:flutter/material.dart';
import 'package:leran_pro/services/auth_service.dart';

class AuthProvider with ChangeNotifier{
  final AuthService _authService = AuthService();

  String? _token;
  String? get token => _token;


  Future<bool> registerUser(String name, String email, String password, String role) async {
    final success = await _authService.registerUser(name, email, password, role);
    return success;
  }



  Future<bool> login(String email, String password) async {
    final token = await _authService.login(email, password);
    if (token != null) {
      _token = token;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    if (_token != null) {
      await _authService.logout(_token!);
      _token = null;
      notifyListeners();
    }
  }
}