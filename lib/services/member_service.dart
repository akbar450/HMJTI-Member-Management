import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../core/constants/api_constants.dart';
import '../models/member_model.dart';

class MemberService {
  final http.Client client;

  MemberService({http.Client? client}) : client = client ?? http.Client();

  Future<List<MemberModel>> getMembers({
    String? search,
    String? jabatan,
    int? angkatan,
    String? status,
    String? sort,
  }) async {
    try {
      final queryParams = <String, String>{};
      if (search != null && search.trim().isNotEmpty) queryParams['q'] = search.trim();
      if (jabatan != null && jabatan.isNotEmpty) queryParams['jabatan'] = jabatan;
      if (angkatan != null) queryParams['angkatan'] = angkatan.toString();
      if (status != null && status.isNotEmpty) queryParams['status'] = status;
      if (sort != null && sort.isNotEmpty) queryParams['sort'] = sort;

      final uri = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.anggota}')
          .replace(queryParameters: queryParams.isNotEmpty ? queryParams : null);

      final response = await client.get(uri).timeout(const Duration(seconds: ApiConstants.timeoutDuration));

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        if ((body['success'] == true || body['status'] == 'success') && body['data'] != null) {
          final List<dynamic> records = body['data'];
          return records.map((e) => MemberModel.fromJson(e)).toList();
        }
        return [];
      } else {
        throw Exception('Gagal memuat data anggota dari server.');
      }
    } catch (e) {
      if (e.toString().contains('Exception:')) rethrow;
      throw Exception('Gagal terhubung ke server. Periksa koneksi internet Anda.');
    }
  }

  Future<MemberModel> getMember(int id) async {
    try {
      final uri = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.anggota}?id=$id');
      final response = await client.get(uri).timeout(const Duration(seconds: ApiConstants.timeoutDuration));

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        if ((body['success'] == true || body['status'] == 'success') && body['data'] != null) {
          return MemberModel.fromJson(body['data']);
        }
        throw Exception(body['message'] ?? 'Data anggota tidak ditemukan');
      } else {
        throw Exception('Gagal memuat detail anggota.');
      }
    } catch (e) {
      if (e.toString().contains('Exception:')) rethrow;
      throw Exception('Gagal terhubung ke server.');
    }
  }

  Future<bool> createMember(MemberModel member) async {
    try {
      final uri = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.anggota}');
      final response = await client.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(member.toJson()),
      ).timeout(const Duration(seconds: ApiConstants.timeoutDuration));

      final Map<String, dynamic> body = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return body['success'] == true || body['status'] == 'success';
      } else {
        throw Exception(body['message'] ?? 'Gagal menambahkan data anggota.');
      }
    } catch (e) {
      if (e.toString().contains('Exception:')) rethrow;
      throw Exception('Gagal terhubung ke server.');
    }
  }

  Future<bool> updateMember(MemberModel member) async {
    if (member.id == null) throw Exception('ID Anggota tidak valid untuk perubahan.');

    try {
      final uri = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.anggota}?id=${member.id}');
      final response = await client.put(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(member.toJson()),
      ).timeout(const Duration(seconds: ApiConstants.timeoutDuration));

      final Map<String, dynamic> body = json.decode(response.body);

      if (response.statusCode == 200) {
        return body['success'] == true || body['status'] == 'success';
      } else {
        throw Exception(body['message'] ?? 'Gagal memperbarui data anggota.');
      }
    } catch (e) {
      if (e.toString().contains('Exception:')) rethrow;
      throw Exception('Gagal terhubung ke server.');
    }
  }

  Future<bool> deleteMember(int id) async {
    try {
      final uri = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.anggota}?id=$id');
      final response = await client.delete(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'id': id}),
      ).timeout(const Duration(seconds: ApiConstants.timeoutDuration));

      final Map<String, dynamic> body = json.decode(response.body);

      if (response.statusCode == 200) {
        return body['success'] == true || body['status'] == 'success';
      } else {
        throw Exception(body['message'] ?? 'Gagal menghapus data anggota.');
      }
    } catch (e) {
      if (e.toString().contains('Exception:')) rethrow;
      throw Exception('Gagal terhubung ke server.');
    }
  }

  Future<String?> uploadPhoto(int memberId, File imageFile) async {
    try {
      final uri = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.anggota}/upload?id=$memberId');
      var request = http.MultipartRequest('POST', uri);

      request.fields['id'] = memberId.toString();
      request.files.add(await http.MultipartFile.fromPath('foto', imageFile.path));

      var streamedResponse = await request.send().timeout(const Duration(seconds: ApiConstants.timeoutDuration));
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        if (body['success'] == true || body['status'] == 'success') {
          return body['data']?['file_name'] ?? body['file_name'];
        }
      }
      return null;
    } catch (e) {
      throw Exception('Gagal mengunggah foto: $e');
    }
  }

  Future<Map<String, dynamic>> getDashboardStats() async {
    try {
      final uri = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.dashboard}');
      final response = await client.get(uri).timeout(const Duration(seconds: ApiConstants.timeoutDuration));

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        if ((body['success'] == true || body['status'] == 'success') && body['data'] != null) {
          return body['data'];
        }
        throw Exception('Gagal memuat data statistik');
      } else {
        throw Exception('Gagal memuat statistik dashboard');
      }
    } catch (e) {
      if (e.toString().contains('Exception:')) rethrow;
      throw Exception('Gagal terhubung ke server.');
    }
  }
}
