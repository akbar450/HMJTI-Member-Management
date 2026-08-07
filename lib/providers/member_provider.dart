import 'dart:io';
import 'package:flutter/material.dart';
import '../models/member_model.dart';
import '../services/member_service.dart';

class MemberProvider extends ChangeNotifier {
  final MemberService _service;

  MemberProvider(this._service);

  List<MemberModel> _members = [];
  List<MemberModel> get members => _members;

  MemberModel? _selectedMember;
  MemberModel? get selectedMember => _selectedMember;

  Map<String, dynamic> _stats = {
    'total_anggota': 0,
    'total_pengurus': 0,
    'total_angkatan': 0,
    'anggota_aktif': 0,
  };
  Map<String, dynamic> get stats => _stats;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  // Filters
  String? _selectedJabatan;
  String? get selectedJabatan => _selectedJabatan;

  String? _selectedAngkatan;
  String? get selectedAngkatan => _selectedAngkatan;

  String? _selectedStatus;
  String? get selectedStatus => _selectedStatus;

  String? _selectedSort;
  String? get selectedSort => _selectedSort;

  Future<void> fetchMembers() async {
    _setLoading(true);
    try {
      _members = await _service.getMembers(
        search: _searchQuery.isNotEmpty ? _searchQuery : null,
        jabatan: _selectedJabatan,
        angkatan: _selectedAngkatan != null ? int.tryParse(_selectedAngkatan!) : null,
        status: _selectedStatus,
        sort: _selectedSort,
      );
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    }
    _setLoading(false);
  }

  Future<void> fetchMember(int id) async {
    _setLoading(true);
    try {
      _selectedMember = await _service.getMember(id);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    }
    _setLoading(false);
  }

  Future<bool> createMember(MemberModel member) async {
    _setLoading(true);
    bool success = false;
    try {
      success = await _service.createMember(member);
      _errorMessage = null;
      await fetchMembers();
      await fetchStats();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      success = false;
    }
    _setLoading(false);
    return success;
  }

  Future<bool> updateMember(MemberModel member) async {
    _setLoading(true);
    bool success = false;
    try {
      success = await _service.updateMember(member);
      _errorMessage = null;
      if (_selectedMember?.id == member.id) {
        _selectedMember = member;
      }
      await fetchMembers();
      await fetchStats();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      success = false;
    }
    _setLoading(false);
    return success;
  }

  Future<bool> deleteMember(int id) async {
    _setLoading(true);
    bool success = false;
    try {
      success = await _service.deleteMember(id);
      _errorMessage = null;
      if (_selectedMember?.id == id) {
        _selectedMember = null;
      }
      await fetchMembers();
      await fetchStats();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      success = false;
    }
    _setLoading(false);
    return success;
  }

  void searchMembers(String query) {
    _searchQuery = query;
    fetchMembers();
  }

  Future<void> fetchStats() async {
    try {
      _stats = await _service.getDashboardStats();
      notifyListeners();
    } catch (e) {
      // Keep previous stats silently if network issue
    }
  }

  Future<bool> uploadPhoto(int id, File photo) async {
    _setLoading(true);
    bool success = false;
    try {
      final photoUrl = await _service.uploadPhoto(id, photo);
      if (photoUrl != null && _selectedMember?.id == id) {
        _selectedMember = _selectedMember?.copyWith(foto: photoUrl);
      }
      _errorMessage = null;
      success = photoUrl != null;
      await fetchMembers();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    }
    _setLoading(false);
    return success;
  }

  void setFilters({
    String? jabatan,
    String? angkatan,
    String? status,
    String? sort,
  }) {
    _selectedJabatan = jabatan;
    _selectedAngkatan = angkatan;
    _selectedStatus = status;
    _selectedSort = sort;
  }

  Future<void> applyFilters() async {
    await fetchMembers();
  }

  Future<void> clearFilters() async {
    _selectedJabatan = null;
    _selectedAngkatan = null;
    _selectedStatus = null;
    _selectedSort = null;
    await fetchMembers();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
