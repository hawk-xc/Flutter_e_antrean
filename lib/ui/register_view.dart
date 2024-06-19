import 'package:flutter/material.dart';
import '/controller/register_controller.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final RegisterController _registerController = RegisterController();
  bool _loading = false; // Penanganan loading state
  bool _isObscure = true;

  // Fungsi untuk menangani tombol register
  Future<void> _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text;
      String name = _nameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;

      setState(() {
        _loading = true; // Menampilkan loading indicator
      });

      bool isRegistered =
          await _registerController.register(username, name, email, password);

      setState(() {
        _loading = false; // Menyembunyikan loading indicator
      });

      if (isRegistered) {
        // Tampilkan pesan sukses dan navigasi kembali ke layar login
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registrasi sukses, silakan login!')));
        Navigator.pop(context);
      } else {
        // Tampilkan pesan kesalahan
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registrasi akun galat')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/mydoodle.jpg',
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.5),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Image.asset('assets/images/logo_4.png',
                      width: 200, height: 200),
                ),
                Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Card(
                        color: Colors.white,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  child: const Row(
                                    children: [
                                      Text(
                                        'Register Akun',
                                        style: TextStyle(
                                          fontSize: 27,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  child: TextFormField(
                                    controller: _usernameController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Username tidak boleh kosong!';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Username',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  child: TextFormField(
                                    controller: _nameController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Nama tidak boleh kosong!';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Nama',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  child: TextFormField(
                                    controller: _emailController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Email tidak boleh kosong!';
                                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                          .hasMatch(value)) {
                                        return 'Masukkan Email yang valid!';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  child: TextFormField(
                                    controller: _passwordController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Kata Sandi tidak boleh kosong!';
                                      } else if (value.length < 8) {
                                        return 'Kata Sandi minimal 8 karakter!';
                                      }
                                      return null;
                                    },
                                    obscureText: _isObscure,
                                    decoration: InputDecoration(
                                      labelText: 'Katasandi',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _isObscure
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isObscure = !_isObscure;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                _loading
                                    ? const CircularProgressIndicator()
                                    : Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: ElevatedButton(
                                          onPressed: _handleRegister,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                            minimumSize:
                                                const Size(double.infinity, 50),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text(
                                            'Register akun',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Sudah Punya Akun? '),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'Login',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
