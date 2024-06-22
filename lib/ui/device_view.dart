import 'package:flutter/material.dart';
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
    'name': 'sds',
    'age': 30,
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
        child: Stack(
          children: [
            Positioned.fill(
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
                      Center(
                        child: DeviceEmpty(onAddDevice: _toggleFormVisibility),
                      )
                    else
                      DeviceNotEmpty(devices: devices),
                  ],
                ),
              ),
            ),
          ],
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
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
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
                        ElevatedButton(
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]);
  }
}

class DeviceNotEmpty extends StatelessWidget {
  final List<DeviceModel> devices;

  const DeviceNotEmpty({super.key, required this.devices});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Card(
          color: Colors.white,
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total Perangkat Anda'),
                    Text(
                      devices.length.toString(),
                      style: const TextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: const Row(children: [Icon(Icons.add), Text("Tambah")]),
                ),
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white,
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: devices.isEmpty
                ? const CircularProgressIndicator()
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: devices.length,
                    itemBuilder: (context, index) {
                      final device = devices[index];
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 5),
                          decoration: BoxDecoration(
                              color: const Color(0xFFEFF0F9),
                              borderRadius: BorderRadius.circular(8)),
                          child: ListTile(
                            leading: const CircleAvatar(
                              child: Icon(Icons.devices),
                            ),
                            title: Text(
                              device.deviceName,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  const Icon(
                                    Icons.person,
                                    size: 12,
                                  ),
                                  Text(
                                    device.userName.toString(),
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                                // Text('Year: ${device.deviceYear}'),
                                Row(children: [
                                  const Icon(Icons.access_alarm, size: 12),
                                  Text(
                                    device.createdAtDiff.toString(),
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
