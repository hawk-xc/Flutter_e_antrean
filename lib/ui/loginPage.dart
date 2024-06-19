import 'package:flutter/material.dart';
import 'package:flutter_e_service_app/helpers/api_client.dart';
import 'package:flutter_e_service_app/helpers/user_info.dart';
import 'package:flutter_e_service_app/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _loading = false;

  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Login Page',
      //     style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
      //   ),
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      //   centerTitle: true,
      // ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("E-Service",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 30)),
                SizedBox(height: 20),
                Card(
                  color: Colors.grey.shade100,
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  margin: EdgeInsets.all(30),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 60, horizontal: 20),
                    child: Column(
                      children: [
                        Text(
                          "Login Your Account 😎",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: Form(
                            key: _formKey,
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.3,
                              child: Column(
                                children: [
                                  _usernameField(),
                                  SizedBox(height: 20),
                                  _passwordField(),
                                  SizedBox(height: 40),
                                  _loading
                                      ? CircularProgressIndicator()
                                      : _tombolLogin()
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Text(
                //   "Login Your Account 😎",
                //   style: TextStyle(
                //       fontSize: 22,
                //       fontWeight: FontWeight.w500,
                //       fontFamily: 'Poppins'),
                // ),
                // SizedBox(
                //   height: 50,
                // ),
                // Center(
                //   child: Form(
                //     key: _formKey,
                //     child: Container(
                //       width: MediaQuery.of(context).size.width / 1.3,
                //       child: Column(
                //         children: [
                //           _usernameField(),
                //           SizedBox(height: 20),
                //           _passwordField(),
                //           SizedBox(height: 40),
                //           _tombolLogin()
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _usernameField() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: "Email", border: OutlineInputBorder()),
      controller: _emailController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
    );
  }

  Widget _passwordField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Password",
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
          border: OutlineInputBorder()),
      controller: _passwordController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
      obscureText: _obscureText,
    );
  }

  Widget _tombolLogin() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () {
          _login();
        },
        child: Text(
          "Login",
          style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _loading = true;
    });
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      final response = await ApiClient().post('login', {
        'email': email,
        'password': password,
      });
      setState(() {
        _loading = false;
      });
      if (response.statusCode == 200) {
        final jsonData = response.data;
        final token = jsonData['token'];
        final username = jsonData['username'];
        await UserInfo().setToken(token);
        await UserInfo().setUsername(username);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login successful'),
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid email or password'),
          ),
        );
      }
    } catch (e) {
      print("login error $e");
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again.'),
        ),
      );
    }
  }
}

class MainMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
      ),
      body: Center(
        child: Text('Welcome to the main menu!'),
      ),
    );
  }
}
