import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => DashboardViewState();
}

class DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.devices),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat datang,',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    Text(
                      'Fitri Ning Alisia',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 24,
                  child: Icon(Icons.face, size: 32),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatisticCard('Total Perangkat', '5'),
                _buildStatisticCard('Total Antrian', '3'),
                _buildStatisticCard('Total Proses', '1'),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Antrian',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildQueueCard(
              'Antrean #202411011',
              'Fitri Ning Alisia',
              'Asus Vivobook M14',
              '15 Menit yang lalu',
              Colors.blue,
              'Register',
            ),
            _buildQueueCard(
              'Antrean #202411010',
              'Fitri Ning Alisia',
              'Lenovo Thinkpad',
              '15 Menit yang lalu',
              Colors.red,
              'Reject',
            ),
            _buildQueueCard(
              'Antrean #202411009',
              'Fitri Ning Alisia',
              'Acer Aspire E14',
              '15 Menit yang lalu',
              Colors.yellow,
              'Verifikasi',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticCard(String title, String count) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 10),
            Text(
              count,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQueueCard(String title, String name, String device, String time,
      Color color, String buttonText) {
    return Card(
      color: color.withOpacity(0.1),
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name),
            Text(device),
            Row(
              children: [
                Icon(Icons.access_time, size: 16),
                SizedBox(width: 4),
                Text(time),
              ],
            ),
          ],
        ),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: color,
          ),
          onPressed: () {},
          child: Text(buttonText),
        ),
      ),
    );
  }
}
