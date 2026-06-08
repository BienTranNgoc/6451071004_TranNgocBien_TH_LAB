import 'package:flutter/material.dart';
import 'package:jobspot/utils/app_colors.dart';
import 'package:jobspot/utils/app_styles.dart';
import '../../domain/entities/profile_entity.dart';

/// Thẻ hiển thị một hồ sơ trong danh sách (Phần 3 - CRUD Profile).
class ProfileCard extends StatelessWidget {
  final ProfileEntity profile;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProfileCard({
    super.key,
    required this.profile,
    required this.onEdit,
    required this.onDelete,
  });

  String get _initials {
    final parts = profile.fullName.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first.characters.first.toUpperCase();
    return (parts.first.characters.first + parts.last.characters.first)
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: AppColors.secondary,
              child: Text(
                _initials,
                style: AppStyles.heading3.copyWith(color: AppColors.primary),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile.fullName,
                    style: AppStyles.body1.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  _InfoRow(
                    icon: Icons.badge_outlined,
                    text: 'MSSV: ${profile.studentId}',
                  ),
                  _InfoRow(icon: Icons.email_outlined, text: profile.email),
                  _InfoRow(icon: Icons.phone_outlined, text: profile.phone),
                  _InfoRow(
                    icon: Icons.location_on_outlined,
                    text: profile.address,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit, color: AppColors.primary),
                  tooltip: 'Sửa',
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(
                    Icons.delete_outline,
                    color: AppColors.error,
                  ),
                  tooltip: 'Xoá',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Row(
        children: [
          Icon(icon, size: 14, color: AppColors.grey),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: AppStyles.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
