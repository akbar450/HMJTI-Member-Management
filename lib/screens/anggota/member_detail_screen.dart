import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/api_constants.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/member_provider.dart';
import '../../utils/helpers.dart';
import '../../widgets/confirmation_dialog.dart';
import '../../widgets/custom_button.dart';
import 'member_form_screen.dart';

class MemberDetailScreen extends StatefulWidget {
  final int memberId;

  const MemberDetailScreen({super.key, required this.memberId});

  @override
  State<MemberDetailScreen> createState() => _MemberDetailScreenState();
}

class _MemberDetailScreenState extends State<MemberDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MemberProvider>(context, listen: false).fetchMember(widget.memberId);
    });
  }

  void _confirmDelete(BuildContext context, MemberProvider provider) async {
    final confirmed = await showConfirmationDialog(
      context: context,
      title: 'Konfirmasi Hapus',
      message: 'Apakah Anda yakin ingin menghapus anggota ini?',
      confirmText: 'Hapus',
      cancelText: 'Batal',
      isDestructive: true,
    );

    if (confirmed && context.mounted) {
      final success = await provider.deleteMember(widget.memberId);
      if (context.mounted) {
        if (success) {
          Helpers.showSnackBar(context, 'Data berhasil dihapus.');
          Navigator.pop(context);
        } else {
          Helpers.showSnackBar(
            context,
            provider.errorMessage ?? 'Gagal menghapus data.',
            isError: true,
          );
        }
      }
    }
  }

  String? _getPhotoUrl(String? foto) {
    if (foto == null || foto.isEmpty) return null;
    if (foto.startsWith('http://') || foto.startsWith('https://')) return foto;
    final base = ApiConstants.baseUrl.replaceAll('/api', '');
    return '$base/$foto';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Anggota'),
      ),
      body: Consumer<MemberProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.selectedMember?.id != widget.memberId) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          }

          final member = provider.selectedMember;
          if (member == null) {
            return const Center(child: Text('Data anggota tidak ditemukan.'));
          }

          final photoUrl = _getPhotoUrl(member.foto);
          final jabatanColor = Helpers.getJabatanColor(member.jabatan);
          final statusColor = Helpers.getStatusColor(member.status);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Profile Header Card
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: jabatanColor, width: 3),
                          ),
                          child: CircleAvatar(
                            radius: 48,
                            backgroundColor: jabatanColor.withValues(alpha: 0.15),
                            backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
                            child: photoUrl == null
                                ? Text(
                                    Helpers.getInitials(member.nama),
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: jabatanColor,
                                    ),
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          member.nama,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'NIM: ${member.nim}',
                          style: const TextStyle(
                            fontSize: 15,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                              decoration: BoxDecoration(
                                color: jabatanColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                member.jabatan,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                              decoration: BoxDecoration(
                                color: statusColor.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: statusColor),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: statusColor,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    member.status,
                                    style: TextStyle(
                                      color: statusColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Detail Info Card
                const Text(
                  'Informasi Anggota',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Card(
                  elevation: 1.5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildInfoRow(Icons.school_outlined, 'Angkatan', member.angkatan.toString()),
                        const Divider(height: 24),
                        _buildInfoRow(Icons.email_outlined, 'Email', member.email),
                        const Divider(height: 24),
                        _buildInfoRow(Icons.phone_outlined, 'Nomor HP', member.nomorHp),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Consumer<MemberProvider>(
        builder: (context, provider, child) {
          final member = provider.selectedMember;
          if (member == null) return const SizedBox.shrink();

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _confirmDelete(context, provider),
                      icon: const Icon(Icons.delete_outline_rounded, color: AppColors.error),
                      label: const Text('Hapus', style: TextStyle(color: AppColors.error)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.error, width: 1.5),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                    child: CustomButton(
                      text: 'Edit',
                      icon: Icons.edit_rounded,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MemberFormScreen(member: member),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primary, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 2),
              Text(
                value.isNotEmpty ? value : '-',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
