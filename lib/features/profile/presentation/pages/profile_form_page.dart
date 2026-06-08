import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobspot/utils/app_colors.dart';
import 'package:jobspot/utils/app_styles.dart';
import 'package:jobspot/widgets/custom_button.dart';
import 'package:jobspot/widgets/custom_textfield.dart';
import '../../domain/entities/profile_entity.dart';
import '../provider/profile_provider.dart';

/// Màn hình Thêm mới / Chỉnh sửa hồ sơ.
///
/// - [profile] == null  -> chế độ Thêm mới (Create)
/// - [profile] != null  -> chế độ Chỉnh sửa (Update)
class ProfileFormPage extends StatefulWidget {
  final ProfileEntity? profile;

  const ProfileFormPage({super.key, this.profile});

  @override
  State<ProfileFormPage> createState() => _ProfileFormPageState();
}

class _ProfileFormPageState extends State<ProfileFormPage> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _studentIdController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;

  bool get _isEditing => widget.profile != null;

  @override
  void initState() {
    super.initState();
    final p = widget.profile;
    _fullNameController = TextEditingController(text: p?.fullName ?? '');
    _studentIdController = TextEditingController(text: p?.studentId ?? '');
    _emailController = TextEditingController(text: p?.email ?? '');
    _phoneController = TextEditingController(text: p?.phone ?? '');
    _addressController = TextEditingController(text: p?.address ?? '');
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _studentIdController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _save() async {
    if (_fullNameController.text.trim().isEmpty ||
        _studentIdController.text.trim().isEmpty) {
      _showMessage('Vui lòng nhập Họ tên và Mã số sinh viên');
      return;
    }

    final provider = context.read<ProfileProvider>();
    final entity = ProfileEntity(
      id: widget.profile?.id,
      fullName: _fullNameController.text.trim(),
      studentId: _studentIdController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      address: _addressController.text.trim(),
    );

    final success = _isEditing
        ? await provider.editProfile(entity)
        : await provider.addProfile(entity);

    if (!mounted) return;

    if (success) {
      _showMessage(_isEditing ? 'Đã cập nhật hồ sơ' : 'Đã thêm hồ sơ mới');
      Navigator.pop(context);
    } else {
      _showMessage(provider.errorMessage ?? 'Có lỗi xảy ra');
    }
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
          _isEditing ? 'Chỉnh sửa hồ sơ' : 'Thêm hồ sơ',
          style: AppStyles.heading3.copyWith(color: AppColors.white),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                label: 'Họ và tên',
                controller: _fullNameController,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Mã số sinh viên',
                controller: _studentIdController,
              ),
              const SizedBox(height: 16),
              CustomTextField(label: 'Email', controller: _emailController),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Số điện thoại',
                controller: _phoneController,
              ),
              const SizedBox(height: 16),
              CustomTextField(label: 'Địa chỉ', controller: _addressController),
              const SizedBox(height: 32),
              CustomButton(
                text: _isEditing ? 'CẬP NHẬT' : 'LƯU HỒ SƠ',
                onPressed: _save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
