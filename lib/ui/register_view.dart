import 'package:flutter/material.dart';
import '/controller/register_controller.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final RegisterController _registerController = RegisterController();
  bool _loading = false; // Penanganan loading state

  // Fungsi untuk menangani tombol register
  Future<void> _handleRegister() async {
    String username = _usernameController.text;
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    setState(() {
      _loading = true; // Menampilkan loading indicator
    });

    bool isRegistered =
        await _registerController.register(name, email, password);

    setState(() {
      _loading = false; // Menyembunyikan loading indicator
    });

    if (isRegistered) {
      // Tampilkan pesan sukses dan navigasi kembali ke layar login
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful!')));
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } else {
      // Tampilkan pesan kesalahan
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Registration failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Kolom input name
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            // Kolom input email
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            // Kolom input password
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              onSubmitted: (value) =>
                  _handleRegister(), // Menambahkan onSubmitted
            ),
            SizedBox(height: 20),
            // Tombol register
            _loading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _handleRegister,
                    child: Text('Register'),
                  ),
          ],
        ),
      ),
    );
  }
}
