import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  final TextEditingController _usernameController =
      TextEditingController(text: 'wahyuae');
  final TextEditingController _nameController =
      TextEditingController(text: 'wahyu tri cahyono');
  final TextEditingController _emailController =
      TextEditingController(text: 'wahyu@gmail.com');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              opacity: 0.5,
              image: AssetImage('assets/images/mydoodle.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 130),
              child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ignore: avoid_unnecessary_containers
                    Container(
                      child: Center(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Column(children: [
                              // username, name, email
                              Card(
                                color: Colors.white,
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 30),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 15),
                                        child: TextField(
                                          controller: _usernameController,
                                          decoration: InputDecoration(
                                            labelText: 'Email',
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 15),
                                        child: TextField(
                                          controller: _nameController,
                                          decoration: InputDecoration(
                                            labelText: 'Email',
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 15),
                                        child: TextField(
                                          controller: _emailController,
                                          decoration: InputDecoration(
                                            labelText: 'Email',
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // password, c_password
                              Card(
                                color: Colors.white,
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 30),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 15),
                                        child: TextField(
                                          controller: _usernameController,
                                          decoration: InputDecoration(
                                            labelText: 'Password sebelumnya',
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 15),
                                        child: TextField(
                                          controller: _nameController,
                                          decoration: InputDecoration(
                                            labelText: 'Password baru',
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 15),
                                        child: TextField(
                                          controller: _emailController,
                                          decoration: InputDecoration(
                                            labelText: 'Ulangi Password baru',
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Tindakan yang dilakukan ketika tombol ditekan
                                        },
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: Size(400, 50),
                                          backgroundColor: Colors
                                              .blue, // Warna latar belakang tombol // Warna teks tombol
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10.0), // Radius sudut tombol
                                          ),
                                        ),
                                        child: const Text(
                                          'Simpan Informasi',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // hapus akun
                              Card(
                                color: Colors.white,
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 10),
                                                child: Text(
                                                  'Hapus Akun',
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ),
                                              Text(
                                                  'Setelah akun anda dihapus, Semua data pada system otomatis akan terhapus. Sebelum menghapus akun, mohon dipastikan ulang dengan teliti.')
                                            ],
                                          )),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Tindakan yang dilakukan ketika tombol ditekan
                                        },
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: Size(400, 50),
                                          backgroundColor: Colors
                                              .red, // Warna latar belakang tombol // Warna teks tombol
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10.0), // Radius sudut tombol
                                          ),
                                        ),
                                        child: const Text(
                                          'Hapus Akun',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120, // diameter dari CircleAvatar (2 * radius)
                      height: 120, // diameter dari CircleAvatar (2 * radius)
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.blue.shade200, Colors.blue.shade400],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors
                            .transparent, // Set transparan karena sudah ada gradient
                        child:
                            Icon(Icons.person, size: 50, color: Colors.white),
                      ),
                    ),
                  ],
                )),
          ]),
        ),
      ),
    );
  }
}
