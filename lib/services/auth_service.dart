import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants/api_constants.dart';
import '../models/user_model.dart';

class AuthService {
  final http.Client client;

  AuthService({http.Client? client}) : client = client ?? http.Client();

  static const String keyIsLoggedIn = 'isLoggedIn';
  static const String keyToken = 'token';
  static const String keyUserId = 'userId';
  static const String keyUserName = 'userName';
  static const String keyUserEmail = 'userEmail';
  static const String keyUserRole = 'userRole';

  Future<UserModel> login(String email, String password) async {
    try {
      final uri = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.login}');
      final response = await client.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      ).timeout(const Duration(seconds: ApiConstants.timeoutDuration));

      final Map<String, dynamic> body = json.decode(response.body);

      if ((response.statusCode == 200 || response.statusCode == 201) && (body['success'] == true)) {
        final data = body['data'];
        final user = UserModel.fromJson(data['user']);

        // Save Session to Shared Preferences according to PRD section 20
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool(keyIsLoggedIn, true);
        await prefs.setString(keyUserName, user.name);
        await prefs.setString(keyUserRole, user.role);

        return user;
      } else {
        throw Exception(body['message'] ?? 'Login gagal. Periksa kembali email dan password Anda.');
      }
    } catch (e) {
      if (e.toString().contains('Exception:')) {
        rethrow;
      }
      throw Exception('Gagal terhubung ke server. Periksa koneksi internet Anda.');
    }
  }

  Future<bool> logout() async {
    try {
      final uri = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.logout}');
      await client.post(uri).timeout(const Duration(seconds: 5));
    } catch (_) {
      // Ignore network errors on logout
    }

    final prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyIsLoggedIn) ?? false;
  }

  Future<UserModel?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool(keyIsLoggedIn) ?? false;
    if (!isLoggedIn) return null;

    final name = prefs.getString(keyUserName) ?? 'Pengurus HMJTI';
    final role = prefs.getString(keyUserRole) ?? 'sekretaris';

    return UserModel(id: 0, name: name, email: '', role: role);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyToken);
  }
}
