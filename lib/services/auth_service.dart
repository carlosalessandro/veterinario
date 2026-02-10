import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Credenciais fixas
  static const String _adminUsername = 'admin';
  static const String _adminPassword = '123456';

  // Login simples
  Future<bool> signIn(String username, String password) async {
    // Validar credenciais
    if (username == _adminUsername && password == _adminPassword) {
      await _saveLoginState(true, username);
      return true;
    }
    return false;
  }

  // Logout
  Future<void> signOut() async {
    await _saveLoginState(false, '');
  }

  // Verificar se está logado
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  // Obter usuário atual
  Future<String?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  // Salvar estado de login
  Future<void> _saveLoginState(bool isLoggedIn, String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
    await prefs.setString('username', username);
  }
}
