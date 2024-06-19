import 'package:flutter/material.dart';

class DeviceView extends StatefulWidget {
  const DeviceView({super.key});

  @override
  State<DeviceView> createState() => _DeviceViewState();
}

class _DeviceViewState extends State<DeviceView> {
  Map<String, dynamic> data = {
    'name': 'sds',
    'age': 30,
    // tambahkan data lain sesuai kebutuhan testing
  };

  @override
  Widget build(BuildContext context) {
    return Container(
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
              if (data.isEmpty)
                const CircularProgressIndicator()
              else if (data.containsKey('error'))
                Text('Error: ${data['error']}')
              else if (data['name'] == null || data['name'].isEmpty)
                const DeviceEmpty() // Tampilan ketika data kosong
              else
                const DeviceNotEmpty(),
            ],
          ),
        ),
      ),
    );
  }
}

class DeviceEmpty extends StatelessWidget {
  const DeviceEmpty({super.key});

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
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 60),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Hallo Users',
                                style: TextStyle(fontSize: 30),
                              ),
                              Text(
                                'Untuk saat ini data masih kosong, tekan tombol dibawah untuk menambahkan data baru.',
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: ElevatedButton(
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

class DeviceNotEmpty extends StatelessWidget {
  const DeviceNotEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Dashboard Not Empty");
  }
}
