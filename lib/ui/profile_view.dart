import 'package:flutter/material.dart';
import 'package:flutter_e_service_app/controller/profile_controller.dart';
import 'package:flutter_e_service_app/helpers/user_info.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ProfileController profileController = ProfileController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String? userImageUrl;
  Map<String, dynamic> data = {};

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    String baseUrl = 'http://localhost:8000/';
    final userData = await profileController.getUserData();
    // print(userData); // Print data untuk memastikan data diterima dengan benar
    setState(() {
      data = userData;
      if (data.containsKey('data')) {
        final userInfo = data['data'];
        usernameController.text = userInfo['username'] ?? '';
        nameController.text = userInfo['name'] ?? '';
        emailController.text = userInfo['email'] ?? '';
        // userImageUrl = userInfo['user_image'] ?? '';
        String userImageName = userInfo['user_image'];
        userImageUrl = '$baseUrl/$userImageName';
      } else {
        // print('Error: ${data['error']}');
      }
    });
  }

  Future<void> confirmDeleteAccount() async {
    bool? shouldDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus Akun'),
          content: const Text(
              'Apakah Anda yakin ingin menghapus akun Anda? Semua data Anda akan dihapus secara permanen.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Tidak'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      // ignore: use_build_context_synchronously
      await profileController.deleteAccount(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/mydoodle.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50), // Spacer untuk mengatur posisi elemen
              Container(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.blue.shade400,
                      child: const Icon(Icons.person,
                          size: 80, color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    Card(
                      color: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  Icons.account_circle_outlined,
                                  size: 25,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Informasi Pengguna',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            ProfileTextField(
                              label: 'Username',
                              controller: usernameController,
                            ),
                            const SizedBox(height: 10),
                            ProfileTextField(
                              label: 'Nama',
                              controller: nameController,
                            ),
                            const SizedBox(height: 10),
                            ProfileTextField(
                              label: 'Email',
                              controller: emailController,
                            ),
                            const SizedBox(height: 30),
                            const Row(
                              children: [
                                Icon(
                                  Icons.password,
                                  size: 25,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Ubah kata sandi',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            ProfileTextField(
                              label: 'Password Sebelumnya',
                              controller: oldPasswordController,
                              obscureText: true,
                            ),
                            const SizedBox(height: 10),
                            ProfileTextField(
                              label: 'Password Baru',
                              controller: newPasswordController,
                              obscureText: true,
                            ),
                            const SizedBox(height: 10),
                            ProfileTextField(
                              label: 'Ulangi Password Baru',
                              controller: confirmPasswordController,
                              obscureText: true,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () async {
                                await profileController.confirmUpdate(
                                  context,
                                  usernameController.text,
                                  nameController.text,
                                  emailController.text,
                                  oldPasswordController.text,
                                  newPasswordController.text,
                                  confirmPasswordController.text,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(500, 50),
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: const Text(
                                'Simpan Informasi',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Card(
                      color: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Row(
                              children: <Widget>[
                                Icon(Icons.logout, size: 25),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Logout akun',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Row(
                              children: [
                                Text(
                                    'Setelah logout, Anda akan kembali ke halaman login.'),
                              ],
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () async {
                                await profileController.logout(context);
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(500, 50),
                                backgroundColor: const Color(0xFFD5B4B4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: const Text(
                                'Logout Akun',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Card(
                      color: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Row(children: [
                              Icon(
                                Icons.delete_forever_outlined,
                                size: 25,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Hapus Akun',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ]),
                            const SizedBox(height: 10),
                            const Text(
                              'Setelah akun anda dihapus, Semua data pada system otomatis akan terhapus. Sebelum menghapus akun, mohon dipastikan ulang dengan teliti.',
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () async {
                                await confirmDeleteAccount();
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(500, 50),
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: const Text(
                                'Hapus Akun',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    nameController.dispose();
    emailController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}

class ProfileTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final String? initialValue;
  final bool obscureText;

  const ProfileTextField({
    super.key,
    required this.label,
    this.controller,
    this.initialValue,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
      ),
    );
  }
}
