import '../core/constants/app_strings.dart';

class Validators {
  static String? validateNama(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.errorRequired;
    }
    final trimmed = value.trim();
    if (trimmed.length < 3) {
      return AppStrings.errorNamaMin;
    }
    if (trimmed.length > 100) {
      return AppStrings.errorNamaMax;
    }
    return null;
  }

  static String? validateNIM(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.errorRequired;
    }
    final trimmed = value.trim();
    if (trimmed.length > 30) {
      return AppStrings.errorNimMax;
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.errorRequired;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return AppStrings.errorEmailValid;
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.errorRequired;
    }
    final digitsOnly = value.trim().replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.length < 10 || digitsOnly.length > 15) {
      return AppStrings.errorPhoneDigit;
    }
    return null;
  }

  static String? validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.errorRequired;
    }
    return null;
  }
}
