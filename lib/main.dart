import 'package:flutter/material.dart';
import 'package:flutter_e_service_app/helpers/user_info.dart';
import 'package:flutter_e_service_app/ui/device_view.dart';
import 'package:flutter_e_service_app/ui/main_dashboard.dart';
import 'package:flutter_e_service_app/ui/profile_view.dart';
import 'package:flutter_e_service_app/ui/device_view.dart';
import 'package:flutter_e_service_app/ui/splash_screen_view.dart';
import 'package:flutter_e_service_app/ui/ticket_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var token = await UserInfo().getToken();
  print(token);
  runApp(MaterialApp(
    title: "Klinik APP",
    debugShowCheckedModeBanner: false,
    home: token == null ? SplashScreen() : MainPage(),
  ));
}

// void main() => runApp(
//       MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//           fontFamily: 'Poppins',
//         ),
//         // home: const MainPage(),
//         // home: const DashboardData(),
//         // home: MainDashboard(),
//         // home: const DashboardView(),
//         // home: const TicketNotEmpty(),
//         // home: const TicketView(),
//         home: const SplashScreen(),
//         // home: const LoginView(),
//       ),
//     );

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  List<Widget> body = const [
    // DashboardView(),
    // DashboardData(),
    MainDashboard(),
    DeviceView(),
    TicketView(),

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
        height: 60,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 25,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.laptop_mac,
                size: 25,
              ),
              label: 'Laptop',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.layers,
                size: 25,
              ),
              label: 'Antrean',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                size: 25,
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
