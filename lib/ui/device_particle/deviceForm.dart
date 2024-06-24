import 'package:flutter/material.dart';

class DeviceForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController yearController;
  final TextEditingController driveLinkController;
  final bool isLoading;
  final VoidCallback toggleFormVisibility;
  final VoidCallback addDevice;
  final bool isEditing;
  final VoidCallback? deleteDevice;

  // ignore: use_super_parameters
  const DeviceForm({
    required this.formKey,
    required this.nameController,
    required this.yearController,
    required this.driveLinkController,
    required this.isLoading,
    required this.toggleFormVisibility,
    required this.addDevice,
    required this.isEditing,
    this.deleteDevice,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    EdgeInsets dynamicPadding =
        EdgeInsets.symmetric(horizontal: screenWidth * 0.2, vertical: 12);

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView(children: [
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: toggleFormVisibility,
                              child: const Icon(
                                Icons.arrow_back_ios,
                                size: 30.0,
                                color: Colors.blue,
                              ),
                            ),
                            Text(
                              isEditing ? 'Edit Perangkat' : 'Tambah Perangkat',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              '0',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
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
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
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
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
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
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
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
                          ? const CircularProgressIndicator()
                          : Row(
                              mainAxisAlignment: isEditing
                                  ? MainAxisAlignment.spaceEvenly
                                  : MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    child: isEditing
                                        ? ElevatedButton(
                                            onPressed: deleteDevice,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  1, 10, 1, 10),
                                              child: Row(children: [
                                                Icon(
                                                  Icons.delete_outline,
                                                  color: Colors.white,
                                                ),
                                                Text('Hapus',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14)),
                                              ]),
                                            ),
                                          )
                                        : null),
                                Container(
                                  child: ElevatedButton(
                                    onPressed: addDevice,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: isEditing
                                          ? const EdgeInsets.fromLTRB(
                                              1, 10, 1, 10)
                                          : dynamicPadding,
                                      child: Row(children: [
                                        const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        ),
                                        Text(isEditing ? 'Ubah' : 'Simpan',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14)),
                                      ]),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ]),
      ]),
    );
  }
}
