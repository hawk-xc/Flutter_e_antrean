import 'package:flutter/material.dart';
import 'package:flutter_e_service_app/model/device_model.dart';

class DeviceNotEmpty extends StatelessWidget {
  final List<DeviceModel> devices;
  final VoidCallback onAddDevice;
  final Function(DeviceModel) onEditDevice;

  const DeviceNotEmpty({
    super.key,
    required this.devices,
    required this.onAddDevice,
    required this.onEditDevice,
  });

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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: onAddDevice,
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
                        onTap: () => onEditDevice(device),
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
