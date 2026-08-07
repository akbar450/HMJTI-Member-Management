import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class Helpers {
  static Color getJabatanColor(String? jabatan) {
    switch (jabatan) {
      case 'Ketua':
        return const Color(0xFFB71C1C); // Merah Tua
      case 'Wakil Ketua':
        return const Color(0xFFE65100); // Oranye Tua
      case 'Sekretaris':
      case 'Bendahara':
        return const Color(0xFF1565C0); // Biru Tua
      case 'Koor Divisi Humas':
      case 'Koor Divisi Minat & Bakat':
        return const Color(0xFF2E7D32); // Hijau Tua
      case 'Anggota Divisi Humas':
      case 'Anggota Divisi Minat & Bakat':
        return const Color(0xFF00897B); // Teal
      case 'Anggota Biasa':
      default:
        return const Color(0xFF616161); // Abu-abu
    }
  }

  static Color getStatusColor(String? status) {
    if (status == 'Aktif') {
      return AppColors.success;
    }
    return AppColors.error;
  }

  static String getInitials(String? name) {
    if (name == null || name.trim().isEmpty) return '?';
    final parts = name.trim().split(' ');
    if (parts.length > 1) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  static void showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: isError ? AppColors.error : AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
