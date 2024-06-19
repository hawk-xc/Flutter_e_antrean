import 'package:flutter/material.dart';
import 'package:flutter_e_service_app/helpers/user_info.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  String? _username;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    UserInfo userInfo = UserInfo();
    String? username = await userInfo.getUsername();
    setState(() {
      _username = username;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                if (_username == null)
                  const CircularProgressIndicator()
                else if (_username!.isEmpty)
                  DashboardEmpty() // Tampilan ketika data username kosong
                else
                  DashboardNotEmpty(
                      username:
                          _username!), // Tampilan ketika data username ada
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardEmpty extends StatelessWidget {
  const DashboardEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Card(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Image.asset('assets/images/item-empty.png',
                            width: 300, height: 300),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 60),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Hallo ',
                              style: TextStyle(fontSize: 30),
                            ),
                            Text(
                              'Untuk saat ini data masih kosong, tekan tombol dibawah untuk menambahkan data baru.',
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: ElevatedButton(
                          onPressed: () {
                            // Tindakan yang dilakukan ketika tombol ditekan
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(335, 50),
                            backgroundColor:
                                Colors.blue, // Warna latar belakang tombol
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Radius sudut tombol
                            ),
                          ),
                          child: const Text(
                            'Tambah data',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardNotEmpty extends StatelessWidget {
  final String username;
  const DashboardNotEmpty({required this.username, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Welcome, $username!",
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
