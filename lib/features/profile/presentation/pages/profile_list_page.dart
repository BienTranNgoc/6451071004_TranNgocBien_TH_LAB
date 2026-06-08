import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobspot/utils/app_colors.dart';
import 'package:jobspot/utils/app_styles.dart';
import 'package:jobspot/features/auth/presentation/provider/auth_provider.dart';
import '../../domain/entities/profile_entity.dart';
import '../provider/profile_provider.dart';
import '../widgets/profile_card.dart';
import 'profile_form_page.dart';

/// Màn hình chính sau khi đăng nhập: danh sách Hồ sơ (CRUD bằng SQLite).
class ProfileListPage extends StatefulWidget {
  const ProfileListPage({super.key});

  @override
  State<ProfileListPage> createState() => _ProfileListPageState();
}

class _ProfileListPageState extends State<ProfileListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().loadProfiles();
    });
  }

  Future<void> _openForm({ProfileEntity? profile}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ProfileFormPage(profile: profile)),
    );
  }

  Future<void> _confirmDelete(ProfileEntity profile) async {
    final profileProvider = context.read<ProfileProvider>();
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Xoá hồ sơ'),
        content: Text('Bạn có chắc muốn xoá hồ sơ "${profile.fullName}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Huỷ'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Xoá', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );

    if (shouldDelete == true && profile.id != null) {
      await profileProvider.removeProfile(profile.id!);
    }
  }

  Future<void> _logout() async {
    final authProvider = context.read<AuthProvider>();
    await authProvider.logout();
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          'Hồ sơ cá nhân',
          style: AppStyles.heading3.copyWith(color: AppColors.white),
        ),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            tooltip: 'Đăng xuất',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: AppColors.white),
        label: Text('Thêm hồ sơ', style: AppStyles.buttonText),
      ),
      body: SafeArea(
        child: Consumer<ProfileProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading && provider.profiles.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            return RefreshIndicator(
              onRefresh: () => provider.loadProfiles(),
              color: AppColors.primary,
              child: provider.profiles.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
                      itemCount: provider.profiles.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return _buildHeader(provider.profiles.length);
                        }
                        final profile = provider.profiles[index - 1];
                        return ProfileCard(
                          profile: profile,
                          onEdit: () => _openForm(profile: profile),
                          onDelete: () => _confirmDelete(profile),
                        );
                      },
                    ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(int count) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Danh sách hồ sơ', style: AppStyles.heading2),
          const SizedBox(height: 4),
          Text(
            'Quản lý hồ sơ bằng SQLite • $count hồ sơ',
            style: AppStyles.body2,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 120),
        const Icon(Icons.inbox_outlined, size: 80, color: AppColors.grey),
        const SizedBox(height: 16),
        Text(
          'Chưa có hồ sơ nào',
          style: AppStyles.heading3,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Nhấn "Thêm hồ sơ" để tạo hồ sơ đầu tiên',
          style: AppStyles.body2,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
