import 'package:flutter/material.dart';
import 'package:flutter_e_service_app/ui/login_view.dart';
import 'package:flutter_e_service_app/ui/dashboard_view.dart';
import 'package:flutter_e_service_app/ui/profile_view.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Poppins',
        ),
        // home: const MainPage(),
        home: const LoginView(),
      ),
    );

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  List<Widget> body = const [
    DashboardView(),
    Icon(Icons.laptop),
    Icon(Icons.person),
    ProfileView(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 90,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.laptop_mac,
                size: 30,
              ),
              label: 'Laptop',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.layers,
                size: 30,
              ),
              label: 'Papers',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                size: 30,
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black38,
          // backgroundColor: Colors.black,
          onTap: _onItemTapped,
        ),
      ),
      body: body[_selectedIndex],
    );
  }
}
