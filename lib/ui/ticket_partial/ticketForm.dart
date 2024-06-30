import 'package:flutter/material.dart';
import 'package:flutter_e_service_app/model/device_model.dart';

class TicketForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final List<String> deviceNames;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController driveLinkController;
  final bool isLoading;
  final VoidCallback toggleFormVisibility;
  final VoidCallback addTicket;
  final bool isEditing;
  final VoidCallback? deleteDevice;
  final DeviceModel? selectedDevice;

  TicketForm({
    required this.formKey,
    required this.deviceNames,
    required this.nameController,
    required this.descriptionController,
    required this.driveLinkController,
    required this.isLoading,
    required this.toggleFormVisibility,
    required this.addTicket,
    required this.isEditing,
    this.deleteDevice,
    this.selectedDevice,
    Key? key,
  }) : super(key: key);

  @override
  _TicketFormState createState() => _TicketFormState();
}

class _TicketFormState extends State<TicketForm> {
  String? _selectedItem;

  @override
  void initState() {
    super.initState();
    _initializeSelectedItem();
    print(widget.nameController.text);
  }

  void _initializeSelectedItem() {
    setState(() {
      _selectedItem = widget.deviceNames.contains(widget.nameController.text)
          ? widget.nameController.text
          : null;
    });
  }

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
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: Form(
                key: widget.formKey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: widget.toggleFormVisibility,
                            child: const Icon(
                              Icons.arrow_back_ios,
                              size: 30.0,
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            widget.isEditing
                                ? 'Edit Antrean'
                                : 'Tambah Antrean',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
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
                              '• Pastikan menambahkan perangkat yang anda pilih dengan benar',
                              style: TextStyle(fontSize: 13),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              '• Berikan deskripsi yang jelas untuk kendala atau kerusakan dari perangkat yang anda pilih',
                              style: TextStyle(fontSize: 13),
                            ),
                            SizedBox(height: 4.0),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: DropdownButtonFormField<String>(
                        value: _selectedItem,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedItem = newValue;
                            widget.nameController.text = newValue ?? '';
                          });
                        },
                        items: widget.deviceNames.map((String deviceName) {
                          return DropdownMenuItem<String>(
                            value: deviceName,
                            child: Text(deviceName),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Nama Perangkat',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) =>
                            value == null ? 'Please select a device' : null,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: TextFormField(
                        controller: widget.descriptionController,
                        maxLines: 4,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Deskripsi kerusakan wajib diisi!';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Deskripsi Kerusakan',
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
                        controller: widget.driveLinkController,
                        decoration: InputDecoration(
                          labelText: 'Drive Link',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    widget.isLoading
                        ? const CircularProgressIndicator()
                        : Row(
                            mainAxisAlignment: widget.isEditing
                                ? MainAxisAlignment.spaceEvenly
                                : MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (widget.isEditing)
                                ElevatedButton(
                                  onPressed: widget.deleteDevice,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(1, 10, 1, 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.delete_outline,
                                          color: Colors.white,
                                        ),
                                        Text('Hapus',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                ),
                              ElevatedButton(
                                onPressed: widget.addTicket,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: widget.isEditing
                                      ? const EdgeInsets.fromLTRB(1, 10, 1, 10)
                                      : dynamicPadding,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                      Text(widget.isEditing ? 'Ubah' : 'Simpan',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
