import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  String? _username;
  bool _isLoading = false;
  String? _errorMessage;

  String? get username => _username;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _username != null;

  AuthProvider() {
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final isLoggedIn = await _authService.isLoggedIn();
    if (isLoggedIn) {
      _username = await _authService.getCurrentUser();
      // Usar Future.microtask para evitar setState durante build
      Future.microtask(() => notifyListeners());
    }
  }

  Future<bool> signIn(String username, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final success = await _authService.signIn(username, password);
      _isLoading = false;
      
      if (success) {
        _username = username;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Usuário ou senha incorretos';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Erro ao fazer login: $e';
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _username = null;
    notifyListeners();
  }
}
