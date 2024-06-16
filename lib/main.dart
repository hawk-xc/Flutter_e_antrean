import 'package:flutter/material.dart';
// import 'package:flutter_e_service_app/ui/login_page.dart';
import 'package:flutter_e_service_app/ui/login_view.dart';
import 'package:flutter_e_service_app/ui/register_view.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Poppins',
        ),
        // home: LoginScreen(),
        // home: RegisterView(),
        home: LoginView(),
      ),
    );

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("hello world"),
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(child: Text('home base')),
      ),
    );
  }
}
