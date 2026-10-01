import 'package:flutter/foundation.dart';

class ApiConstants {
  // Configurable base host
  // Use 'localhost' for Chrome / Web / Windows App / iOS Simulator or ADB reverse
  // Use your PC's Wi-Fi IP (e.g. '192.168.1.7') for Physical Android Device
  static const String _hostWeb = 'http://localhost/hmjti_api/api';
  // IP Laptop Anda saat ini: 10.0.1.137
  static const String _hostAndroid = 'http://10.0.1.137/hmjti_api/api';

  static String get baseUrl {
    if (kIsWeb) {
      return _hostWeb;
    }
    return _hostAndroid;
  }
  
  static const String login = '/login';
  static const String logout = '/logout';
  static const String dashboard = '/dashboard';
  static const String anggota = '/anggota';
  
  static const int timeoutDuration = 30; // seconds
}
