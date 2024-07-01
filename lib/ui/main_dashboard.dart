import 'package:flutter/material.dart';
import 'package:flutter_e_service_app/controller/ticket_controller.dart';
import 'package:flutter_e_service_app/helpers/user_info.dart';
import 'package:flutter_e_service_app/model/ticket_model.dart';
import 'package:flutter_e_service_app/ui/timeline.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({Key? key}) : super(key: key);

  @override
  _MainDashboardState createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  String? _username;
  late Future<List<Ticket>> futureTickets;

  @override
  void initState() {
    super.initState();
    _loadUsername();
    futureTickets = TicketController().fetchTickets();
  }

  Future<void> _loadUsername() async {
    UserInfo userInfo = UserInfo();
    String? username = await userInfo.getUsername();
    setState(() {
      _username = username;
      print(_username);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Ticket>>(
        future: futureTickets,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Failed to load tickets: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return DashboardView(username: _username);
          } else {
            return DashboardData(username: _username);
          }
        },
      ),
    );
  }
}

class DashboardView extends StatelessWidget {
  final String? username;

  const DashboardView({Key? key, this.username}) : super(key: key);

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
                            username ?? "Loading...",
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
              const SizedBox(
                height: 200, // Adjust the height as needed
                child: CustomTimeline(),
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
                        const Text(
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
    Key? key,
  }) : super(key: key);

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

class DashboardData extends StatelessWidget {
  final String? username;

  const DashboardData({Key? key, this.username}) : super(key: key);

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
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome Section
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
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
                                username ?? 'Guest', // Username
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          const CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(
                                'assets/images/avatar.png'), // Placeholder image
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Statistic Section
                  FutureBuilder<List<Ticket>>(
                    future: TicketController().fetchTickets(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text(
                                'Failed to load tickets: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text('No tickets available'));
                      } else {
                        int totalDevices = snapshot.data!
                            .map((ticket) => ticket.device)
                            .toSet()
                            .length;
                        int totalProcesses = snapshot.data!
                            .map((ticket) => ticket.process.id)
                            .toSet()
                            .length;

                        // Calculate total queues
                        int totalQueues = snapshot.data!
                            .map((ticket) => ticket)
                            .toSet()
                            .length;

                        return Row(
                          children: [
                            Expanded(
                              child: _buildStatCard('Total Perangkat',
                                  totalDevices.toString(), Colors.blue),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildStatCard('Total \n Antrean',
                                  totalQueues.toString(), Colors.orange),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildStatCard('Total \n Proses',
                                  totalProcesses.toString(), Colors.green),
                            ),
                          ],
                        );
                      }
                    },
                  ),

                  const SizedBox(height: 16),

                  // Queue Section
                  const Text(
                    'Antrean',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // FutureBuilder to display tickets
                  FutureBuilder<List<Ticket>>(
                    future: TicketController().fetchTickets(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text(
                                'Failed to load tickets: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text('No tickets available'));
                      } else {
                        return Column(
                          children: snapshot.data!.map((ticket) {
                            return _buildQueueCard(
                              context,
                              'Antrean #${ticket.idTicket}',
                              ticket.userName ?? 'Guest',
                              ticket.device.deviceName,
                              ticket.createdAtDiff,
                              _getColor(ticket.process.statusId),
                              ticket.process.statusId,
                            );
                          }).toList(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.devices),
      //       label: 'Devices',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.list),
      //       label: 'Queues',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Profile',
      //     ),
      //   ],
      // ),
    );
  }

  Widget _buildStatCard(String title, String count, Color color) {
    return HoverCard(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                count,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQueueCard(
    BuildContext context,
    String title,
    String userName,
    String device,
    String time,
    Color color,
    int statusId,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _getColor(statusId),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      _getStatusText(statusId),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.person, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    '$userName', // Username
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.devices, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    '$device',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.timer, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    '$time',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getStatusText(int statusId) {
    switch (statusId) {
      case 1:
        return 'Registrasi';
      case 2:
        return 'Verifikasi';
      case 3:
        return 'Proses';
      case 4:
        return 'Selesai';
      case 5:
        return 'Ditolak';
      default:
        return 'Unknown';
    }
  }

  Color _getColor(int statusId) {
    switch (statusId) {
      case 1:
        return Colors.blue;
      case 2:
        return Colors.grey;
      case 3:
        return Colors.yellow;
      case 4:
        return Colors.green;
      case 5:
        return Colors.red;
      default:
        return Colors.pink;
    }
  }
}

class HoverCard extends StatefulWidget {
  final Widget child;

  const HoverCard({required this.child, Key? key}) : super(key: key);

  @override
  _HoverCardState createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.1 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: widget.child,
      ),
    );
  }
}
