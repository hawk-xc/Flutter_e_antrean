import 'package:flutter/material.dart';
import 'package:flutter_e_service_app/ui/login_page.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Poppins',
        ),
        home: LoginScreen(),
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
