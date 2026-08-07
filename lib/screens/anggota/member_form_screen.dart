import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../core/constants/api_constants.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../models/member_model.dart';
import '../../providers/member_provider.dart';
import '../../utils/helpers.dart';
import '../../utils/validators.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class MemberFormScreen extends StatefulWidget {
  final MemberModel? member;

  const MemberFormScreen({super.key, this.member});

  @override
  State<MemberFormScreen> createState() => _MemberFormScreenState();
}

class _MemberFormScreenState extends State<MemberFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _namaController;
  late TextEditingController _nimController;
  late TextEditingController _emailController;
  late TextEditingController _nomorHpController;

  String _angkatan = '2024';
  String _jabatan = 'Anggota Biasa';
  String _status = 'Aktif';
  File? _imageFile;

  bool get _isEditMode => widget.member != null;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.member?.nama ?? '');
    _nimController = TextEditingController(text: widget.member?.nim ?? '');
    _emailController = TextEditingController(text: widget.member?.email ?? '');
    _nomorHpController = TextEditingController(text: widget.member?.nomorHp ?? '');

    if (_isEditMode) {
      _angkatan = widget.member!.angkatan.toString();
      _jabatan = AppStrings.listJabatan.contains(widget.member!.jabatan)
          ? widget.member!.jabatan
          : 'Anggota Biasa';
      _status = AppStrings.listStatus.contains(widget.member!.status)
          ? widget.member!.status
          : 'Aktif';
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _nimController.dispose();
    _emailController.dispose();
    _nomorHpController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  String? _getPhotoUrl(String? foto) {
    if (foto == null || foto.isEmpty) return null;
    if (foto.startsWith('http://') || foto.startsWith('https://')) return foto;
    final base = ApiConstants.baseUrl.replaceAll('/api', '');
    return '$base/$foto';
  }

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      final provider = Provider.of<MemberProvider>(context, listen: false);

      final memberData = MemberModel(
        id: widget.member?.id,
        nama: _namaController.text.trim(),
        nim: _nimController.text.trim(),
        angkatan: int.tryParse(_angkatan) ?? 2024,
        email: _emailController.text.trim(),
        nomorHp: _nomorHpController.text.trim(),
        jabatan: _jabatan,
        status: _status,
        foto: widget.member?.foto,
      );

      bool success;
      if (_isEditMode) {
        success = await provider.updateMember(memberData);
      } else {
        success = await provider.createMember(memberData);
      }

      if (success) {
        // Upload photo if selected
        if (_imageFile != null && widget.member?.id != null) {
          await provider.uploadPhoto(widget.member!.id!, _imageFile!);
        }

        if (mounted) {
          Helpers.showSnackBar(
            context,
            _isEditMode ? 'Data berhasil diubah.' : 'Data berhasil ditambahkan.',
          );
          Navigator.pop(context);
        }
      } else {
        if (mounted) {
          Helpers.showSnackBar(
            context,
            provider.errorMessage ?? 'Gagal memproses data.',
            isError: true,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final existingPhotoUrl = _getPhotoUrl(widget.member?.foto);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? 'Edit Anggota' : 'Tambah Anggota'),
      ),
      body: Consumer<MemberProvider>(
        builder: (context, provider, child) {
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                // Photo Picker Header
                Center(
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primary, width: 2),
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile!) as ImageProvider
                              : (existingPhotoUrl != null ? NetworkImage(existingPhotoUrl) : null),
                          child: _imageFile == null && existingPhotoUrl == null
                              ? const Icon(Icons.person, size: 50, color: Colors.grey)
                              : null,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: _pickImage,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: AppColors.secondary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.camera_alt, color: AppColors.textPrimary, size: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Form Fields matching Section 10 Validation Rules
                CustomTextField(
                  controller: _namaController,
                  label: AppStrings.nama,
                  hint: 'Masukkan nama lengkap anggota',
                  icon: Icons.person_outline,
                  validator: Validators.validateNama,
                ),

                CustomTextField(
                  controller: _nimController,
                  label: AppStrings.nim,
                  hint: 'Masukkan NIM (contoh: 11203362410001)',
                  icon: Icons.badge_outlined,
                  validator: Validators.validateNIM,
                ),

                CustomTextField(
                  controller: _emailController,
                  label: AppStrings.email,
                  hint: 'Masukkan email aktif',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.validateEmail,
                ),

                CustomTextField(
                  controller: _nomorHpController,
                  label: AppStrings.nomorHp,
                  hint: 'Masukkan nomor HP (10-15 digit)',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: Validators.validatePhone,
                ),

                // Angkatan Dropdown
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: DropdownButtonFormField<String>(
                    initialValue: _angkatan,
                    decoration: const InputDecoration(
                      labelText: AppStrings.angkatan,
                      prefixIcon: Icon(Icons.school_outlined),
                    ),
                    items: AppStrings.listAngkatan
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (val) => setState(() => _angkatan = val!),
                  ),
                ),

                // Jabatan Dropdown
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: DropdownButtonFormField<String>(
                    initialValue: _jabatan,
                    decoration: const InputDecoration(
                      labelText: AppStrings.jabatan,
                      prefixIcon: Icon(Icons.work_outline),
                    ),
                    items: AppStrings.listJabatan
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (val) => setState(() => _jabatan = val!),
                  ),
                ),

                // Status Dropdown
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: DropdownButtonFormField<String>(
                    initialValue: _status,
                    decoration: const InputDecoration(
                      labelText: AppStrings.status,
                      prefixIcon: Icon(Icons.info_outline),
                    ),
                    items: AppStrings.listStatus
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (val) => setState(() => _status = val!),
                  ),
                ),

                // Submit Button
                CustomButton(
                  text: AppStrings.simpan,
                  icon: Icons.save_rounded,
                  isLoading: provider.isLoading,
                  onPressed: _saveForm,
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
