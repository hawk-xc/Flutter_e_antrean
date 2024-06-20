import 'package:flutter/material.dart';
// import 'package:flutter_e_service_app/model/device_model.dart';
import 'package:flutter_e_service_app/controller/device_controller.dart';
import 'package:flutter_e_service_app/model/device_model.dart';

class DeviceView extends StatefulWidget {
  const DeviceView({super.key});

  @override
  State<DeviceView> createState() => _DeviceViewState();
}

class _DeviceViewState extends State<DeviceView>
    with SingleTickerProviderStateMixin {
  Map<String, dynamic> data = {
    'name': 'sd',
    'age': 30,
    // // tambahkan data lain sesuai kebutuhan testing
  };

  List<DeviceModel> devices = [];

  bool showForm = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  late AnimationController _animationController;
  late Animation<Offset> _animation;

  Future<void> _getDeviceData() async {
    var response = await DeviceController().index();
    setState(() {
      devices = response;
    });
  }

  @override
  void initState() {
    _getDeviceData();
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _toggleFormVisibility() {
    setState(() {
      showForm = !showForm;
      if (showForm) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _addDevice() {
    setState(() {
      data['name'] = _nameController.text;
      data['age'] = int.tryParse(_ageController.text) ?? 30;
      showForm = false;
    });
    _animationController.reverse();
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
                if (showForm)
                  SlideTransition(
                    position: _animation,
                    child: _buildForm(),
                  )
                else if (data.isEmpty)
                  const CircularProgressIndicator()
                else if (data.containsKey('error'))
                  Text('Error: ${data['error']}')
                else if (data['name'] == null || data['name'].isEmpty)
                  DeviceEmpty(
                      onAddDevice:
                          _toggleFormVisibility) // Pass the function to toggle form visibility
                else
                  DeviceNotEmpty(devices[0].deviceName),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Card(
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
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addDevice,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class DeviceEmpty extends StatelessWidget {
  final VoidCallback onAddDevice;

  const DeviceEmpty({super.key, required this.onAddDevice});

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
                            onPressed: onAddDevice,
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(335, 50),
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Tambah Perangkat',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            )),
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

// ignore: must_be_immutable
class DeviceNotEmpty extends StatelessWidget {
  String? deviceName;
  // const DeviceNotEmpty({super.key});
  DeviceNotEmpty(this.deviceName);

  @override
  Widget build(BuildContext context) {
    return Text(deviceName.toString());
  }
}
