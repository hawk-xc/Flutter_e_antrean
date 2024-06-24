import 'package:flutter/material.dart';
import 'package:flutter_e_service_app/controller/ticket_controller.dart';
import 'package:flutter_e_service_app/helpers/user_info.dart';
import 'package:flutter_e_service_app/model/ticket_model.dart';

class DashboardData extends StatefulWidget {
  const DashboardData({Key? key}) : super(key: key);

  @override
  _DashboardDataState createState() => _DashboardDataState();
}

class _DashboardDataState extends State<DashboardData> {
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
                                _username ?? 'Guest', // Username
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          CircleAvatar(
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
                    future: futureTickets,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text(
                                'Failed to load tickets: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No tickets available'));
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
                              child: _buildStatCard('Total Antrean',
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
                    future: futureTickets,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text(
                                'Failed to load tickets: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No tickets available'));
                      } else {
                        return Column(
                          children: snapshot.data!.map((ticket) {
                            return _buildQueueCard(
                              context,
                              'Antrean #${ticket.idTicket}',
                              _username ?? 'Guest',
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
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.devices),
            label: 'Devices',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Queues',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
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
                count,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
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
          gradient: LinearGradient(
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
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(_getStatusText(statusId)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.person, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    '$userName', // Username
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.devices, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    '$device',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.timer, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    '$time',
                    style: TextStyle(color: Colors.white),
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
        return Colors.orange;
      case 3:
        return Colors.green;
      case 4:
        return Colors.red;
      case 5:
        return Colors.yellow;
      default:
        return Colors.grey;
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
