import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  Map<String, dynamic> data = {
    'name': 'John Doe',
    'age': 30,
    // tambahkan data lain sesuai kebutuhan testing
  };

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
                if (data.isEmpty)
                  const CircularProgressIndicator()
                else if (data.containsKey('error'))
                  Text('Error: ${data['error']}')
                else if (data['name'] == null || data['name'].isEmpty)
                  const DashboardEmpty() // Tampilan ketika data kosong
                else
                  const DashboardNotEmpty(),
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
    return const Text('Dashboard Empty');
  }
}

class DashboardNotEmpty extends StatelessWidget {
  const DashboardNotEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Dashboard Not Empty");
  }
}
