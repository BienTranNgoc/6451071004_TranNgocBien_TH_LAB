# JobSpot — Báo cáo Thực hành Phát triển ứng dụng di động

> **Sinh viên thực hiện:** Trần Ngọc Biên
> **Mã số sinh viên (MSSV):** 6451071004

Ứng dụng Flutter mô phỏng nền tảng tìm kiếm việc làm **JobSpot**, được xây dựng theo
3 phần của bài thực hành: clone giao diện từ Figma, xác thực bằng Firebase và lưu trữ
cục bộ bằng SQLite — toàn bộ tổ chức theo **Clean Architecture**.

---

## 👤 Thông tin

| | |
|---|---|
| Họ và tên | **Trần Ngọc Biên** |
| MSSV | **6451071004** |
| Đề tài | JobSpot — Flutter Mobile App |
| Kiến trúc | Clean Architecture (data / domain / presentation) |

## 🔗 Tài liệu tham khảo (UI / API)

- https://publicapis.dev/category
- https://free-apis.github.io/#/browse
- https://github.com/khanhtran0599/Movie-App

---

## 📦 Nội dung 3 phần

### Phần 1 — Clone UI từ Figma
Dựng lại giao diện các màn hình bằng Flutter, dùng các widget tái sử dụng:

- `SplashScreen` — màn hình khởi động.
- `OnboardingScreen` — giới thiệu, `SmoothPageIndicator`.
- `LoginPage` / `RegisterPage` / `ForgotPasswordPage` — biểu mẫu xác thực.
- `CheckEmailScreen` / `SuccessScreen` — màn hình thông báo.
- Widget dùng chung: `CustomButton`, `CustomTextField`, `CustomCheckbox`, `SocialButton`.
- Hệ thống thiết kế: `AppColors`, `AppStyles`, `AppStrings`, `AppAssets` (icon dạng SVG).

### Phần 2 — Firebase + Clean Architecture
Tính năng **đăng ký / đăng nhập / quên mật khẩu** bằng `firebase_auth`, tổ chức theo
3 tầng:

- **domain**: `UserEntity`, `AuthRepository` (abstract), các `UseCase` (SignUp, Login, ResetPassword, Logout, GetCurrentUser).
- **data**: `FirebaseAuthDataSource`, `UserModel` (JSON), `AuthRepositoryImpl`.
- **presentation**: `AuthProvider` (state management) + các trang UI.
- **core**: `ServiceLocator` (Dependency Injection), hằng số thông báo lỗi.

### Phần 3 — SQLite + CRUD Profile
Quản lý **hồ sơ cá nhân** lưu cục bộ bằng `sqflite` (Create / Read / Update / Delete):

- **domain**: `ProfileEntity`, `ProfileRepository`, các `UseCase` (GetProfiles, CreateProfile, UpdateProfile, DeleteProfile).
- **data**: `ProfileLocalDataSource` → `SqliteProfileDataSource`, `ProfileModel` (toMap/fromMap), `ProfileRepositoryImpl`.
- **presentation**: `ProfileProvider`, `ProfileListPage` (màn hình chính sau đăng nhập), `ProfileFormPage` (thêm/sửa), `ProfileCard`.
- **core/db**: `AppDatabase` — khởi tạo SQLite, tạo bảng `profiles` và chèn sẵn hồ sơ mẫu.
- Widget sử dụng: `ListView.builder`, `Card`, `CircleAvatar`, `FloatingActionButton.extended`,
  `AlertDialog` (xác nhận xoá), `RefreshIndicator` (kéo để tải lại).

---

## 🗂️ Cấu trúc thư mục

```
lib/
├── apps/                      # MaterialApp + định nghĩa routes
├── core/
│   ├── constants/             # Thông báo lỗi
│   ├── db/                    # AppDatabase (SQLite)
│   └── di/                    # ServiceLocator (Dependency Injection)
├── features/
│   ├── auth/                  # Phần 2 — Firebase Auth
│   │   ├── data/ │ domain/ │ presentation/
│   └── profile/               # Phần 3 — SQLite CRUD Profile
│       ├── data/ │ domain/ │ presentation/
├── utils/                     # AppColors / AppStyles / AppStrings / AppAssets
├── views/                     # Phần 1 — Splash, Onboarding, các màn hình thông báo
├── widgets/                   # Widget dùng chung
├── firebase_options.dart      # Cấu hình Firebase (FlutterFire)
└── main.dart                  # Điểm khởi chạy
```

## 🚀 Chạy ứng dụng

```bash
flutter pub get
flutter run
```

- **Firebase:** dự án `job-finder-7111c` (đã cấu hình sẵn `firebase_options.dart` và `google-services.json`).
- **SQLite:** `sqflite` chạy trên Android/iOS. Khuyến nghị chạy trên **Android emulator/thiết bị**.
- Sau khi đăng nhập thành công, ứng dụng chuyển tới màn hình **Hồ sơ cá nhân** (Phần 3).

## 🛠️ Công nghệ

Flutter • Firebase Auth • Provider • sqflite • google_fonts • flutter_svg • smooth_page_indicator
