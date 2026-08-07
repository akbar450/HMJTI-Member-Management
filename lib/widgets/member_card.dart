import 'package:flutter/material.dart';
import '../core/constants/api_constants.dart';
import '../core/constants/app_colors.dart';
import '../models/member_model.dart';

import '../screens/anggota/member_detail_screen.dart';
import '../utils/helpers.dart';

class MemberCard extends StatelessWidget {
  final MemberModel member;

  const MemberCard({super.key, required this.member});

  String? _getPhotoUrl(String? foto) {
    if (foto == null || foto.isEmpty) return null;
    if (foto.startsWith('http://') || foto.startsWith('https://')) return foto;
    final base = ApiConstants.baseUrl.replaceAll('/api', '');
    return '$base/$foto';
  }

  @override
  Widget build(BuildContext context) {
    final photoUrl = _getPhotoUrl(member.foto);
    final jabatanColor = Helpers.getJabatanColor(member.jabatan);
    final statusColor = Helpers.getStatusColor(member.status);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          if (member.id != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MemberDetailScreen(memberId: member.id!),
              ),
            );
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: jabatanColor.withValues(alpha: 0.15),
                backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
                child: photoUrl == null
                    ? Text(
                        Helpers.getInitials(member.nama),
                        style: TextStyle(
                          color: jabatanColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member.nama,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'NIM: ${member.nim} • ${member.angkatan}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: jabatanColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      member.jabatan,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: statusColor,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        member.status,
                        style: TextStyle(
                          fontSize: 11,
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
