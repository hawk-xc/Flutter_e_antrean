import 'package:flutter/material.dart';
import '../helpers/user_info.dart';
import '../helpers/api_client.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ApiClient apiClient = ApiClient();
  TextEditingController usernameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Map<String, dynamic> data = {};
  final UserInfo userInfo = UserInfo();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    String? token = await userInfo.getToken();

    if (token == null) {
      setState(() {
        data = {'error': 'No token found'};
      });
      return;
    }

    try {
      final response = await apiClient.get(
        'user',
        headers: {'Authorization': 'Bearer $token'},
      );
      setState(() {
        data = response.data;
        // Set nilai controller sesuai dengan data yang diperoleh
        usernameController.text = data['username'] ?? '';
        nameController.text = data['name'] ?? '';
        emailController.text = data['email'] ?? '';
      });
    } catch (e) {
      setState(() {
        data = {'error': e.toString()};
      });
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
              SizedBox(height: 100), // Spacer untuk mengatur posisi elemen
              Container(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.blue.shade400,
                      child: const Icon(Icons.person,
                          size: 50, color: Colors.white),
                    ),
                    SizedBox(height: 20),
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
                            ProfileTextField(
                              label: 'Username',
                              controller: usernameController,
                            ),
                            SizedBox(height: 10),
                            ProfileTextField(
                              label: 'Nama',
                              controller: nameController,
                            ),
                            SizedBox(height: 10),
                            ProfileTextField(
                              label: 'Email',
                              controller: emailController,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
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
                            ProfileTextField(
                              label: 'Password Sebelumnya',
                              initialValue: '',
                              obscureText: true,
                            ),
                            SizedBox(height: 10),
                            ProfileTextField(
                              label: 'Password Baru',
                              initialValue: '',
                              obscureText: true,
                            ),
                            SizedBox(height: 10),
                            ProfileTextField(
                              label: 'Ulangi Password Baru',
                              initialValue: '',
                              obscureText: true,
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                // Tindakan yang dilakukan ketika tombol ditekan
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(335, 50),
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
                    SizedBox(height: 20),
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
                            Text(
                              'Hapus Akun',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Setelah akun anda dihapus, Semua data pada system otomatis akan terhapus. Sebelum menghapus akun, mohon dipastikan ulang dengan teliti.',
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                // Tindakan yang dilakukan ketika tombol ditekan
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(335, 50),
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
    // Cleanup controllers when not needed
    usernameController.dispose();
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }
}

class ProfileTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final String? initialValue;
  final bool obscureText;

  const ProfileTextField({
    Key? key,
    required this.label,
    this.controller,
    this.initialValue,
    this.obscureText = false,
  }) : super(key: key);

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
        fillColor: Colors.white.withOpacity(0.9),
      ),
    );
  }
}
