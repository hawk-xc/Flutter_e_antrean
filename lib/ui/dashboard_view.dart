import 'package:flutter/material.dart';
import 'package:flutter_e_service_app/helpers/user_info.dart';
import 'package:flutter_e_service_app/ui/timeline.dart';

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
            image: AssetImage('assets/images/mydoodle.jpg'), // Background image
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Selamat datang,',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            _username ?? "Loading...",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(
                            'assets/images/avatar.png'), // Avatar image
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // CustomTimeline Widget
              SizedBox(
                height: 200, // Adjust the height as needed
                child: const CustomTimeline(),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ListView(
                      children: [
                        Text(
                          "Flow Apps",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        AccordionItem(
                          title: 'Register dan Login',
                          children: [
                            ListTile(
                              title: const Text(
                                  'Setelah anda berhasil register dan login anda akan dibawa ke halaman dashboard ini.'),
                              onTap: () {},
                            ),
                          ],
                        ),
                        AccordionItem(
                          title: 'Tambah Perangkat',
                          children: [
                            ListTile(
                              title: const Text(
                                  ' Pada tahap ini silakan anda tambah perangkat anda dihalaman tambah perangkat'),
                              onTap: () {},
                            ),
                          ],
                        ),
                        AccordionItem(
                          title: 'Tambah Antrian',
                          children: [
                            ListTile(
                              title: const Text(
                                  'Jika anda sudah mendaftarkan perangkat anda, langkah selanjutnya adalah melakukan registrasi antrean, dimana antrean ini kemudian akan diproses oleh tim helpdesk dan teknisi kami. Anda juga dapat melihat status perbaikan dan informasi lainnya di halaman Antrean, harap diingat aturan pemrosesannya adalah 3x24 jam dari awal tiket dibuat.'),
                              onTap: () {},
                            ),
                          ],
                        ),
                        AccordionItem(
                          title: 'Tunggu Notifikasi',
                          children: [
                            ListTile(
                              title: const Text(
                                  'Jika proses perbaikan telah selesai, tim kami akan mengirimkan notifikasi kepada pelanggan melalui fitur Chat dan alamat email. Pastikan untuk selalu rutin mengecek notifikasi.'),
                              onTap: () {},
                            ),
                          ],
                        ),
                        AccordionItem(
                          title: 'Tanya Jawab Helpdesk',
                          children: [
                            ListTile(
                              title: const Text(
                                  'Anda juga bisa tanya jawab dengan helpdesk kami.'),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AccordionItem extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const AccordionItem({
    required this.title,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        child: ExpansionTile(
          title: Text(title),
          children: children,
        ),
      ),
    );
  }
}
