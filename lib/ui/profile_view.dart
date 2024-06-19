import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../helpers/user_info.dart';
import '../helpers/api_client.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ApiClient apiClient = ApiClient();
  Map<String, dynamic> data = {};
  final UserInfo userInfo = UserInfo();

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
      });
    } catch (e) {
      setState(() {
        data = {'error': e.toString()};
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/mydoodle.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  data.isEmpty
                      ? const CircularProgressIndicator()
                      : data.containsKey('error')
                          ? Text('Error: ${data['error']}')
                          : ProfileForm(data: data),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileForm extends StatelessWidget {
  final Map<String, dynamic> data;
  const ProfileForm({Key? key, required this.data}) : super(key: key);

  /// Builds the widget for the profile view.
  ///
  /// This widget displays the user's profile information, including their username,
  /// name, and email. It also includes an avatar image and fields for password
  /// management.
  ///
  /// The widget is built using a [Stack] widget, which allows for the avatar
  /// image to be positioned on top of the profile information. The profile
  /// information is displayed in a [Container] with a white background and rounded
  /// corners. The avatar image is a [CircleAvatar] with a blue background and
  /// a person icon. The profile fields are instances of the [ProfileTextField]
  /// widget, which display the label, initial value, and an optional obscure
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 130),
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ignore: avoid_unnecessary_containers
                Container(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(children: [
                          // username, name, email
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
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 30),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    child: ProfileTextField(
                                        label: 'Username',
                                        initialValue: data['username']),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    child: ProfileTextField(
                                        label: 'Nama',
                                        initialValue: data['name']),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    child: ProfileTextField(
                                        label: 'Email',
                                        initialValue: data['email']),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // password, c_password
                          Card(
                            color: Colors.white,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 30),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    child: const ProfileTextField(
                                        label: 'Password Sebelumnya',
                                        initialValue: '',
                                        obscureText: true),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    child: const ProfileTextField(
                                        label: 'Password baru',
                                        initialValue: '',
                                        obscureText: true),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    child: const ProfileTextField(
                                        label: 'Ulangi Password baru',
                                        initialValue: '',
                                        obscureText: true),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Tindakan yang dilakukan ketika tombol ditekan
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(335, 50),
                                      backgroundColor: Colors
                                          .blue, // Warna latar belakang tombol // Warna teks tombol
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10.0), // Radius sudut tombol
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
                          // hapus akun
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
                                  Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 10),
                                            child: const Text(
                                              'Hapus Akun',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          const Text(
                                              'Setelah akun anda dihapus, Semua data pada system otomatis akan terhapus. Sebelum menghapus akun, mohon dipastikan ulang dengan teliti.')
                                        ],
                                      )),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Tindakan yang dilakukan ketika tombol ditekan
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(335, 50),
                                      backgroundColor: Colors
                                          .red, // Warna latar belakang tombol // Warna teks tombol
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10.0), // Radius sudut tombol
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
                        ]),
                      ),
                    ),
                  ),
                ),
              ]),
        ),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120, // diameter dari CircleAvatar (2 * radius)
                  height: 120, // diameter dari CircleAvatar (2 * radius)
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade200, Colors.blue.shade400],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors
                        .transparent, // Set transparan karena sudah ada gradient
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                ),
              ],
            )),
      ]),
    );
  }
}

class ProfileTextField extends StatelessWidget {
  final String label;
  final String? initialValue;
  final bool obscureText;

  const ProfileTextField({
    Key? key,
    required this.label,
    this.initialValue,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
