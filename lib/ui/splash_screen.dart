import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_e_service_app/helpers/user_info.dart';
import 'package:flutter_e_service_app/main.dart';
import 'package:flutter_e_service_app/ui/login_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  void startSplashScreen() async {
    WidgetsFlutterBinding.ensureInitialized();
    var token = await UserInfo().getToken();
    print(token);

    var duration = const Duration(seconds: 10);
    Timer(duration, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              token == null ? const LoginView() : const MainPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logobaru.png',
                  width: 280,
                ),
                const SizedBox(
                  height: 80,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginView()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // : Colors.blueAccent, // Text color
                    minimumSize: const Size(150, 50), // Button size
                  ),
                  child: const Text(
                    'Mulai',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset('assets/images/blobs.png',
                fit: BoxFit.cover, height: MediaQuery.of(context).size.height),
          ),
        ],
      ),
    );
  }
}
