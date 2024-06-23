// deviceForm.dart
import 'package:flutter/material.dart';

class DeviceForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController yearController;
  final TextEditingController driveLinkController;
  final bool isLoading;
  final VoidCallback toggleFormVisibility;
  final Future<void> Function() addDevice;

  const DeviceForm({
    required this.formKey,
    required this.nameController,
    required this.yearController,
    required this.driveLinkController,
    required this.isLoading,
    required this.toggleFormVisibility,
    required this.addDevice,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 50,
      padding: const EdgeInsets.all(40),
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(children: [
                  Text(
                    'Tambah Perangkat',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE9F7EF),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.info, color: Colors.black),
                            SizedBox(width: 8.0),
                            Text(
                              'Perhatian',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          '• pastikan menambahkan nama perangkat anda dengan lengkap, merk dan type',
                          style: TextStyle(fontSize: 13),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                            '• pastikan tahun produksi laptop anda dengan benar',
                            style: TextStyle(fontSize: 13)),
                        SizedBox(height: 4.0),
                        Text(
                            '• data perangkat yang anda inputkan akan menjadi pertimbangan kami untuk menentukan metode perbaikan',
                            style: TextStyle(fontSize: 13)),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama perangkat wajib diisi!';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Nama Perangkat',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: TextFormField(
                    controller: yearController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Tahun perangkat wajib diisi!';
                      } else if (int.tryParse(value) == null) {
                        return 'Tahun perangkat harus berupa angka';
                      } else if (int.parse(value) > DateTime.now().year) {
                        return 'Tahun perangkat tidak boleh melebihi tahun sekarang';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Tahun Perangkat',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: TextFormField(
                    controller: driveLinkController,
                    decoration: InputDecoration(
                      labelText: 'Drive Link',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                isLoading
                    ? CircularProgressIndicator()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: toggleFormVisibility,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(25, 12, 25, 12),
                              child: Text('Batalkan',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14)),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: addDevice,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(25, 12, 25, 12),
                              child: Text('Submit',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14)),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
